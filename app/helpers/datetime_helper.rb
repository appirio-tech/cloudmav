module DatetimeHelper
  
  def codemav_time_select(param_name, time)
    result = ""
    result << "<select id='hour_#{param_name}' name='hour_#{param_name}'>"
    
    hour_to_select = 12
    unless time.blank?
      hour_to_select = time.hour > 12 ? time.hour - 12 : time.hour
    end
    (1..12).each do |h| 
      result << "<option value='#{h}'"
      result << " selected='selected'" if h == hour_to_select
      result << ">#{h}</option>"
    end
    result << "</select>"
    
    min_to_select = time.blank? ? 0 : time.min
    result << "<select id='minute_#{param_name}' name='minute_#{param_name}'>"
    (0..59).each do |m|
      result << "<option value='#{m}'"
      result << " selected='selected'" if m == min_to_select
      n = m < 10 ? "0#{m}" : m
      result << ">#{n}</option>"
    end
    result << "</select>"

    result << "<select id='ampm_#{param_name}' name='ampm_#{param_name}'>"
    
    is_am = false
    unless time.blank?
      is_am = time.hour < 12
    end
    result << "<option value='AM'"
    result << " selected='selected'" if is_am
    result << ">AM</option>"
    
    result << "<option value='PM'"
    result << " selected='selected'" unless is_am
    result << ">PM</option>"
    
    result << "</select>"
    return result.html_safe
  end    
  
end
