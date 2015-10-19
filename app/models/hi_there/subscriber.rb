module HiThere
  class Subscriber < ActiveRecord::Base
    has_many :subscriptions

    validates :email, email: true                     
  end
end
