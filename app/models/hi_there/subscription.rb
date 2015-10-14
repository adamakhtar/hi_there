require 'csv'

module HiThere
  class Subscription < ActiveRecord::Base
    include Workflow

    belongs_to :course
    belongs_to :next_email, class_name: 'HiThere::Email'
    belongs_to :previous_email, class_name: 'HiThere::Email'
    
    validates :email, email: true                     
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

    validates :email, email: true

    def self.is_or_was_activated
      where('activated_at IS NOT NULL')
    end

    def self.overdue
      where('next_delivery_at < ?', Time.current)
    end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << ['Email', 'Status', 'Opted In', 'Current issue', 'Next issue']
        find_each do |subscription|
          csv << [
            subscription.email,
            subscription.current_state,
            subscription.created_at,
            subscription.previous_issue_number,
            subscription.next_issue_number
          ]
        end
      end
    end

    def generate_token
      self.token ||= SecureRandom.urlsafe_base64
    end

    def stamp_unsubscribe!(datetime=Time.current_stateent)
      unsubscribe!
      update_attribute(:unsubscribed_at, datetime)
    end

    def update_activated_at(datetime=Time.current)
      update_attributes!(activated_at: datetime)
    end

    def update_next_issue!(issue_number:, delivery_at:)
      update_attributes!(next_issue_number: issue_number, next_delivery_at: delivery_at)
    end

    def previous_issue_number 
      [next_issue_number - 1, 0].max
    end
  end
end
