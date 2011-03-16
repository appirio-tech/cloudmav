module WidgetHelper

  def basic_widget_html(profile)
    result = javascript_include_tag(widget_profile_url(profile)) 
    result += "\n" 
    result += "\n" 
    result += %Q{<script type='text/css' source='http://#{request.host}/public#{stylesheet_path("basic_widget.css")}'</script>}
    result
  end

end
