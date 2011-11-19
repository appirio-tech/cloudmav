module CodeMav

  module Followable
    def self.included(receiver)
      receiver.class_eval do
        has_many :followings, :as => :followable
        has_many :following_bys, :as => :following_by_able
      end
      
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def follow!(subject)
        return if self.follows?(subject)

        self.followings.create(:subject => subject)
        subject.following_bys.create(:subject => self)
      end

      def unfollow!(subject)
        self.following_for(subject).destroy
        subject.following_by_for(self).destroy
      end

      def follows?(subject)
        !following_for(subject).nil?
      end

      def followees
        self.followings.collect{|f| f.subject}
      end

      def followers
        self.following_bys.collect{|f| f.subject}
      end

      def friends
        followees.select{|p| p.follows?(self)}
      end

      def follower?(subject)
        !following_by_for(subject).nil?
      end

      def friend?(subject)
        self.follows?(subject) && subject.follows?(self)
      end

      def following_by_for(subject)
        self.following_bys.where(:subject_id => subject.id).first
      end

      def following_for(subject)
        self.followings.where(:subject_id => subject.id).first
      end

    end
  end
end
