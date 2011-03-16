module WidgetHelper

  def basic_widget_html(profile)
    javascript_include_tag(widget_profile_url(profile)) 
  end

  def widget_stylesheet(stylesheet)
    %Q{<script type='text/css' source='http://#{request.host}#{stylesheet_path(stylesheet)}'></script>}.html_safe
  end

end
