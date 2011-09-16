module CodeMav
  module Skillable
    def self.included(receiver)
      receiver.class_eval do
        embeds_many :skillings, :as => :skillable
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def clear_skills!
        self.skillings.destroy_all
      end
      
      def earn_skill(points, skill_name, description, subject)
        skilling = Skilling.new(:skill_name => skill_name, :description => description, :score => points)
        skilling.subject = subject
        self.skillings << skilling
        skilling.save
        self.save
      end
      
      def skill_score(skill_name)
        score = 0
        self.skillings.select{|s| s.skill_name == skill_name}.each{|s| score += s.score }
        score        
      end

    end
  end
end
