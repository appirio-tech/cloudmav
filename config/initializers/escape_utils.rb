module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end

class SimpleRSS
  def unescape(content)
    if content =~ /([^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]%)/ then
      CGI.unescape(content).gsub(/(<!\[CDATA\[|\]\]>)/,'').strip
    else
      content.gsub(/(<!\[CDATA\[|\]\]>)/,'').strip
    end
  end
end
