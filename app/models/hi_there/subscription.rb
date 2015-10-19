require 'csv'

module HiThere
  class Subscription < ActiveRecord::Base
    include Workflow

    belongs_to :course
    belongs_to :subscriber
    belongs_to :next_email, class_name: 'HiThere::Email'
    belongs_to :previous_email, class_name: 'HiThere::Email'
    
    validates :course_id, :workflow_state, presence: :true

    workflow do
      state :opted_in do
        event :confirm, transitions_to: :confirmed
        event :activate, transitions_to: :activated
      end

      state :activated do
        event :complete, transitions_to: :completed
        event :unsubscribe, transitions_to: :unsubscribed 
      end

      state :completed
      state :unsubscribed
      state :terminated
    end

    before_create :generate_token

    def self.is_or_was_activated
      where('activated_at IS NOT NULL')
    end

    def self.overdue
      where('next_email_at < ?', Time.current)
    end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << ['Email', 'Status', 'Opted In', 'Current email', 'Next email']
        find_each do |subscription|
          csv << [
            subscription.email,
            subscription.current_state,
            subscription.created_at,
            subscription.previous_email.try(:issue_number),
            subscription.next_email.try(:issue_number)
          ]
        end
      end
    end

    def generate_token
      self.token ||= SecureRandom.urlsafe_base64
    end

    def overdue?
      next_email_at < Time.current
    end

    def unsubscribe_and_stamp!(datetime=Time.current)
      unsubscribe!
      update_attribute(:unsubscribed_at, datetime)
    end

    def activate_and_stamp!(datetime=Time.current)
      activate!
      update_attributes!(activated_at: datetime)
    end
  end
end
