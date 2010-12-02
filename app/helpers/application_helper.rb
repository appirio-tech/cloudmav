module ApplicationHelper
  
  def flashy
    f_names = [:notice, :error, :warning, :message, :success]
    fl = ''

    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"flash #{name}\">#{flash[name]}</div>"
      end
      flash[name] = nil;
    end
    return fl.html_safe
  end

  def js_date(date)
    return escape_javascript "new Date()" if date.nil?
    escape_javascript "new Date(#{date.year}, #{date.month - 1}, #{date.day})"
  end
    
end
