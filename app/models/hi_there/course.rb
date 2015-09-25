module HiThere
  class Course < ActiveRecord::Base
    has_many :emails, -> { order(interval: :asc) }

    validates :title, presence: true, uniqueness: true
  end
end
