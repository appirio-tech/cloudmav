module Virgil
  module Learn
    
    def learn(name, options = {}, &block)
      after_callback = options[:after] || :save
      config = Virgil::Config.new
      config.instance_eval(&block)
      method_name = "learn_#{make_methodable name}".to_sym
      config.klass.class_eval do
        set_callback after_callback, :after, method_name
        define_method method_name, Proc.new { 
          if config.conditions_array.all? {|p| p.call(self) }
            config.subject_proc.call(self).learn(name)
          end
        }
      end
      create_guidance(name, config)
    end
    
    private
      def make_methodable(value)
        value.to_s.titleize.gsub(/\s/, '').underscore
      end
      
      def create_guidance(name, config)
        return if Guidance.where(:title => name).any?
        
        guidance = Guidance.new(:title => name)
        guidance.partial = config.partial_name        
        guidance.save
      end
  end
  
end