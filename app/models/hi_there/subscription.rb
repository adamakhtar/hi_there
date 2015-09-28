module HiThere
  class Subscription < ActiveRecord::Base
    include Workflow

    belongs_to :course
    
    validates :email, email: true                     
    validates :course_id, :workflow_state, presence: :true

    workflow do
      state :opted_in do
        event :confirm, transitions_to: :confirmed
      end

      state :confirmed do
        event :unsubscribe, transitions_to: :unsubscribed
      end
    end
  end
end
