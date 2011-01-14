module CodeMav
  module ExperienceModule
    def self.included(receiver)
      receiver.class_eval do
        references_many :jobs
        references_many :projects
        embeds_many :experiences
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def experience_tags
        self.projects.map{|p| p.technologies }.flatten.map{|t| t.name}
      end
      
      def calculate_experience
        self.experiences.each{|e| e.destroy}
        self.projects.each do |project|
          project_xp = project.get_xp
          project_xp.each_pair do |name, duration|
            xp = find_create_xp(name)
            unless duration.nil?
              sum = xp.duration + duration
              xp.duration= sum.to_i
            end
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
            xp = Experience.new
            xp.name = name
            xp.technology = Technology.named(name).first
            xp.duration = 0
            self.experiences << xp
          end
          return xp
        end
    end
  end
end