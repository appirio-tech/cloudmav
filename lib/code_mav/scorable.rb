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

      def recalculate_score!
        self.scorings.destroy_all
        self.total_score = 0
        self.save
        event = RecalculateScoreEvent.new(:profile => self)
        event.save
      end

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
      
      def earn(points, point_type, name, subject)
        scoring = Scoring.new(:name => name, :point_type => point_type, :score => points)
        scoring.subject = subject
        self.scorings << scoring
        scoring.save
        self.save
        calculate_total_score
      end

      def adjust_score(name, points, point_type)
        scoring = self.scorings.select{|s| s.point_type == point_type && s.name == name}.first
        if scoring.nil?
          scoring = self.scorings.create(:name => name, :point_type => point_type, :score => points)
        else
          scoring.score = points
          scoring.save
        end
        self.save
        calculate_total_score
      end
    end
  end
end
