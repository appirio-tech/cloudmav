module ScoreIt
  module Subject
    def self.included(receiver)
      receiver.class_eval do
        embeds_many :scorings
      end

      ::Scoring.class_eval %Q{
        embedded_in :#{receiver.to_s.underscore}, :inverse_of => :scorings
        def earner
          #{receiver.to_s.underscore}
        end
      }
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def total_score
        score = 0
        self.scorings.each{|s| score += s.score }
        score
      end
      
      def score(point_type)
        score = 0
        self.scorings.select{|s| s.point_type == point_type}.each{|s| score += s.score }
        score        
      end
      
      def earn(name, points, point_type)
        scoring = self.scorings.select{|s| s.name == name && s.point_type == point_type}.first
        return if scoring
        scoring = Scoring.new(:name => name, :point_type => point_type, :score => points)
        self.scorings << scoring
      end
    end
  end
end