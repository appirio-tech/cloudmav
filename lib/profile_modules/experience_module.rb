module CodeMav
  module ExperienceModule
    def self.included(receiver)
      receiver.class_eval do
        
        embeds_many :projects
        
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def calculate_experience
        self.experiences.each{|e| e.destroy}
        self.projects.each do |project|
          project_xp = project.get_xp
          
        end
      end
      
    end
  end
end