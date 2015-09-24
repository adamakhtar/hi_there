module HiThere
  class Course < ActiveRecord::Base
    validates :title, presence: true, uniqueness: true
  end
end
