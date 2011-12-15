module CodeMav
  module Scorable
    def self.included(receiver)
      receiver.class_eval do
        field :total_score, :type => Integer, :default => 0

        index :total_score

        scope :order_by_score, order_by([:total_score, :desc])

        embeds_many :scorings, :as => :scorable
      end
            
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      
      def clear_score!
        self.scorings.destroy_all
      end

      def calculate_total_score
        self.total_score = 0
        self.scorings.each{|s| self.total_score += s.score }
        save
      end
      
      def score(point_type)
        score = 0
        point_type = point_type.to_s
        self.scorings.select{|s| s.point_type == point_type}.each{|s| score += s.score }
        score        
      end
      
      def earn(points, point_type, name, subject)
        scoring = Scoring.new(:name => name, :point_type => point_type, :score => points)
        scoring.subject = subject
        self.scorings << scoring
        scoring.save
        self.save
        calculate_total_score
      end
      
    end
  end
end
