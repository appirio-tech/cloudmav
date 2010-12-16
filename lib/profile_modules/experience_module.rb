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
          project_xp.keys.each_pair do |name, duration|
            xp = find_create_xp(name)
            xp.duration += duration
          end
        end
      end
      
      private
        def find_create_xp(name)
          xp = self.experiences.with(name).first
          unless xp
            xp = Experience.new
            xp.name = name
            xp.technology << Technology.named(name)
            self.experiences << xp
          end
          return xp
        end
    end
  end
end