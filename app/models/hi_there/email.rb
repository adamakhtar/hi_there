module HiThere
  class Email < ActiveRecord::Base
    belongs_to :course
    
    validates :subject, :body, :course_id, presence: true
    validates :interval, numericality: { only_integer: true, minimum_value: 1 }

    def self.soonest_first
      order('interval ASC')
    end
  end
end
