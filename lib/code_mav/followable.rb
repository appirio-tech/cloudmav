module CodeMav

  module Followable
    def self.included(receiver)
      receiver.class_eval %Q{
        references_many :followings, :inverse_of => :#{receiver.to_s.underscore}
        references_many :following_bys, :inverse_of => :#{receiver.to_s.underscore}
      }
      Following.class_eval %Q{
        referenced_in :#{receiver.to_s.underscore}, :inverse_of => :followings
      }
      FollowingBy.class_eval %Q{
        referenced_in :#{receiver.to_s.underscore}, :inverse_of => :following_bys
      }
    
      receiver.send(:include, InstanceMethods)
    end
    
    module InstanceMethods

      def follow!(subject)
        self.followings.create(:subject => subject)
        subject.following_bys.create(:subject => self)
      end

      def follows?(subject)
        !self.followings.select{|f| f.subject_id = subject.id }.first.nil?
      end

      def followees
        self.followings.collect{|f| f.subject}
      end

      def followers
        self.following_bys.collect{|f| f.subject}
      end

      def follower?(subject)
        !self.following_bys.select{|f| f.subject_id = subject.id }.first.nil?
      end

    end

  end

end
