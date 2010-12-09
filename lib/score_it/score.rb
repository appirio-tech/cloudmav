module ScoreIt
  module Score
    
    def score(points, point_type, name, options = {}, &block)
      after_callback = options[:after] || :save
      config = ScoreIt::Config.new
      config.instance_eval(&block)
      method_name = "earn_#{make_methodable name}_#{make_methodable point_type}".to_sym
      config.klass.class_eval do
        set_callback after_callback, :after, method_name
        define_method method_name, Proc.new { 
          if config.conditions_array.all? {|p| p.call(self) }
            config.subject_proc.call(self).earn(name, points, point_type)
          end
        }
      end
    end
    
    private
      def make_methodable(value)
        value.to_s.titleize.gsub(/\s/, '').underscore
      end

  end
  
end