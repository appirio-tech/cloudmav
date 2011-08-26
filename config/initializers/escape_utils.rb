module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end

class SimpleRSS
  def unescape(content)
    if content =~ /([^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]%)/u then
  		CGI.unescape(content).gsub(/(<!\[CDATA\[|\]\]>)/u,'').strip
  	else
  		content.gsub(/(<!\[CDATA\[|\]\]>)/u,'').strip
  	end
    
  end
end
