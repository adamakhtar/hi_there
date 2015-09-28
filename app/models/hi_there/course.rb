module HiThere
  class Course < ActiveRecord::Base
    include Workflow
    
    has_many :emails, -> { order(interval: :asc) }
    has_many :subscriptions

    validates :title, presence: true, uniqueness: true
    
    workflow do
      state :draft do
        event :open, :transitions_to => :opened
      end

      state :opened do
        event :close, :transitions_to => :closed
      end

      state :closed do
        event :open, :transitions_to => :opened
      end
    end    
  end
end
