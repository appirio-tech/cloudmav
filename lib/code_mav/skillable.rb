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
      
      def earn_skill(points, skill_name, point_type, description, subject)
        skilling = Skilling.new(:skill_name => skill_name, :point_type => point_type, :description => description, :score => points)
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
      
      def skill_score_for_type(skill_name, point_type)
        score = 0
        point_type = point_type.to_s
        both = self.skillings.select{|s| s.skill_name == skill_name && s.point_type == point_type}     
        self.skillings.select{|s| s.skill_name == skill_name && s.point_type == point_type}.each{|s| score += s.score }
        score        
      end
      
      def skills
        self.skillings.map{|s| s.skill_name }.uniq
      end

    end
  end
end
