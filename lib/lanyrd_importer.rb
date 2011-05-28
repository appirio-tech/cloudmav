class LanyrdImporter

  def self.import!
    topics.each do |t|
      delay.import_from_topic!(t)
    end
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

      i.tags_text = content.partition("Topics:").last.partition("Speakers:").first
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

  def self.topics
    ["net", 
    "development", 
    "agile", 
    "android",
    "android-30",
    "android-development",
    "altnet",
    "apple",
    "ant",
    "artificial-intelligence",
    "aspnet",
    "aspnet-mvc",
    "backbonejs",
    "behavior-driven-development",
    "blackberry",
    "c",
    "c-sharp",
    "c-1",
    "cloud",
    "clojure",
    "cocos2d",
    "cocoa",
    "cocoa-touch",
    "code",
    "code-camp",
    "coffeescript",
    "common-lisp",
    "coldfusion",
    "compilers",
    "couchdb",
    "continuous-integration",
    "computer-science",
    "core-data",
    "css",
    "css3",
    "design-patterns",
    "ddd",
    "django",
    "dojo",
    "domain-driven-design",
    "domain-specific-languages",
    "drupal",
    "dynamic-languages",
    "erlang",
    "expression-blend",
    "extjs",
    "extreme-programming",
    "f",
    "free-software",
    "games-development",
    "games-programming",
    "haskell",
    "html",
    "html5",
    "hudson",
    "http",
    "ios",
    "java", 
    "javascript", 
    "jquery", 
    "jquery-mobile", 
    "json", 
    "kanban",
    "less",
    "lisp",
    "mac-os-x",
    "mapreduce",
    "microsoft",
    "microsoft-sql-server",
    "microsoft-visual-studio",
    "mongodb",
    "nodejs",
    "nosql",
    "obj-c",
    "object-databases",
    "object-oriented-programming",
    "objective-c",
    "objective-j",
    "ocaml",
    "odata",
    "open-source",
    "oss",
    "pair-programming",
    "parallel-programming",
    "perl",
    "perl-6",
    "phonegap",
    "php",
    "postgresql",
    "programming",
    "programming-languages",
    "prototypejs",
    "pycon",
    "python",
    "python-3",
    "rack",
    "rails-3",
    "rails-31",
    "raven-db",
    "reactive-extensions-rx",
    "rest",
    "restsharp",
    "rspec",
    "ruby",
    "ruby-on-rails",
    "sass",
    "scala",
    "scheme",
    "scrum",
    "sencha-touch",
    "silverlight",
    "sinatra",
    "software",
    "software-architecture",
    "software-craftsmanship",
    "software-development",
    "software-engineering",
    "software-testing",
    "solid",
    "solr",
    "source-control",
    "spring",
    "sql",
    "sql-server",
    "sqlite",
    "stack-overflow",
    "svg",
    "teamcity",
    "titanium",
    "tomcat",
    "twilio",
    "unit-testing",
    "vim",
    "visual-studio",
    "windows-azure",
    "windows-phone-7",
    "xaml",
    "xcode",
    "xcode4",
    "xml",
    "yaml"] 
  end

end
