module ScoreIt
  module Subject
    def self.included(receiver)
      receiver.class_eval do
        field :total_score, :type => Integer, :default => 0
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

      def calculate_total_score
        self.total_score = 0
        self.scorings.each{|s| self.total_score += s.score }
        save
      end
      
      def score(point_type)
        score = 0
        self.scorings.select{|s| s.point_type == point_type}.each{|s| score += s.score }
        score        
      end
      
      def earn(name, points, point_type)
        scoring = Scoring.new(:name => name, :point_type => point_type, :score => points)
        self.scorings << scoring
        scoring.save
        calculate_total_score
      end
    end
  end
end
