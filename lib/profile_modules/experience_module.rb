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
            xp = find_create_xp(name)
            xp.duration = 0 if xp.duration.nil?
            xp.duration += duration unless duration.nil?
          end
        end
      end
      
      private
        def find_create_xp(name)
          xp = self.experiences.with(name).first
          unless xp
            xp = Experience.new
            xp.name = name
            xp.technology = Technology.named(name).first
            xp.duration = Duration.new(0)
            self.experiences << xp
          end
          return xp
        end
    end
  end
end