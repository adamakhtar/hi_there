module HiThere
  class Email < ActiveRecord::Base
    belongs_to :course
    acts_as_list scope: :course, column: 'issue_number'
    
    validates :subject, :body, :course_id, presence: true
    validates :interval, numericality: { only_integer: true, minimum_value: 1 }
  end
end
