module HiThere
  class Course < ActiveRecord::Base
    validates :title, presence: true
  end
end
