module Virgil
  class Config
    
    class << self
      attr_accessor :guidance_definitions
    end
    
    attr_reader :klass, :conditions_array, :subject_proc, :partial_name
    
    def partial(name)
      @partial_name = name
    end
    
    def initialize
      @conditions_array = [Proc.new {true}]
      subject :user
    end
    
    def subject(sym = nil, &block)
      @subject_name = sym
      if block_given?
        @subject_proc = Proc.new {|instance|
          block.call(instance)
        }
      else
        @subject_proc = Proc.new { |instance|
          if klass.to_s.underscore.to_sym == @subject_name
            instance
          else
            instance.send(sym)
          end
        }
      end
    end
    
    def thing(klass)
      @klass = klass
    end
    
    def conditions(&block)
      @conditions_array << Proc.new {|instance|
        block.call(instance)
      }
    end 
  end
end