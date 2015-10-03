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
        event :start, transitions_to: :started
      end

      state :started do
        event :complete, transitions_to: :completed
      end

      state :completed
    end

    before_create :generate_token

    def self.overdue
      where('next_delivery_at < ?', Time.current)
    end

    def generate_token
      self.token ||= SecureRandom.urlsafe_base64
    end

    def update_next_issue!(issue_number:, delivery_at:)
      update_attributes!(next_issue_number: issue_number, next_delivery_at: delivery_at)
    end
  end
end
