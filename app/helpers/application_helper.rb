module ApplicationHelper

  def flashy
    f_names = [:notice, :error, :warning, :message, :success, :alert]
    fl = ''

    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"alert-message #{name}\">#{flash[name]}</div>"
      end
      flash[name] = nil;
    end
    return fl.html_safe
  end
  
  def js_date(date)
    return escape_javascript "new Date()" if date.nil?
    escape_javascript "new Date(#{date.year}, #{date.month - 1}, #{date.day})"
  end
  
  def show_date(date)
    return "" if date.nil?
    date.strftime("%m/%d/%y")
  end
  
  def pointify(points)
    return points if points < 1000
    result = ((points / 1000) * 10).round.to_f / 10
    "#{result} k"
  end
  
end
