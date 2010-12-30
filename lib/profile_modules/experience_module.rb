module CodeMav
  module ExperienceModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :projects
        embeds_many :experiences
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def calculate_experience
        self.experiences.each{|e| e.destroy}
        self.projects.each do |project|
          project_xp = project.get_xp
          project_xp.each_pair do |name, duration|
            puts "duration is #{duration.inspect}"
            xp = find_create_xp(name)
            # xp.duration = 0 if xp.duration.nil?
            puts "#{xp.duration} + #{duration}"
            # xp.duration += duration unless duration.nil?
            a = xp.duration + duration
            xp.duration = xp.duration + duration unless duration.nil?
            xp.duration = a
            puts "xp dur = #{xp.duration.inspect}"
            puts "a #{a.inspect}"
          end
        end
      end
      
      def experience_with(technology_name)
        self.experiences.with(technology_name).first
      end
      
      private
        def find_create_xp(name)
          xp = self.experiences.with(name).first
          unless xp
            puts "creating.."
            xp = Experience.new
            xp.name = name
            xp.technology = Technology.named(name).first
            # xp.duration = Duration.new(0)
            xp.duration = 0
            self.experiences << xp
          end
          puts "xp create = #{xp.duration.inspect}"
          return xp
        end
    end
  end
end