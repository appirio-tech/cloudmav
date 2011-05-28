class LanyrdImporter

  def self.import!
    topics = ["net", "development", "agile", "altnet"]  
    topics.each { |t| import_from_topic!(t) }
  end

  def self.import_from_topic!(topic)
    rss = SimpleRSS.parse open("http://lanyrd.com/topics/#{topic}/feed/")
    coder = HTMLEntities.new

    rss.items.each do |item|
      i = BacklogItem.find_or_initialize_by(:imported_from => "Lanyrd", :imported_id => item[:id])
      i.title = item[:title]
      i.url = item[:link]

      summary_html = coder.decode(item.summary).squish
      summary_html = Nokogiri::HTML(summary_html)
      
      content = summary_html.children[1].content
      loc = content.partition("Topics:").first.split("   ").last
      i.location = loc if loc

      i.tags_text = content.partition("Topics:").last
      i.description = content.partition("  ").first

      short_conf_name = i.url.partition("http://lanyrd.com/2011/").last[0..-2]
      ical_url = i.url + short_conf_name + ".ics"
      ical = Icalendar.parse open(ical_url)
      i.start_date = Chronic.parse ical.first.events.first.dtstart
      i.end_date = Chronic.parse ical.first.events.first.dtend

      i.save
      i.retag!
    end
  end

end
