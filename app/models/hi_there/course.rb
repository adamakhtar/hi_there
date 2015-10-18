module HiThere
  class Course < ActiveRecord::Base
    include Workflow
    
    has_many :emails, -> { order(issue_number: :asc) }
    has_many :subscriptions

    validates :title, :deliver_at, presence: true
    validates :name, format: {with: /\A[a-z_\d]+\z/}
    
    workflow do
      state :draft do
        event :open, :transitions_to => :opened
        event :terminate, :transitions_to => :terminated 
      end

      state :opened do
        event :close, :transitions_to => :closed
        event :terminate, :transitions_to => :terminated 
      end

      state :closed do
        event :open, :transitions_to => :opened
        event :terminate, :transitions_to => :terminated 
      end

      state :terminated
    end 

    def issue(number)
      emails.where(issue_number: number).take
    end   
  end
end
