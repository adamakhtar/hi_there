require "hi_there/engine"
require "kaminari"
require "simple_form"

module HiThere
  mattr_accessor :authorization_method, 
                 :current_user_method,
                 :per_page,
                 :redirect_unauthorized_path, 
                 :user_class

  class << self
    def authorization_method      
      @@authorization_method ||= :can_access_hi_there?
    end

    def current_user_method
      @@current_user_method ||= :current_user
    end

    def per_page
      @@per_page || 20
    end

    def redirect_unauthorized_path
      @@redirect_unauthorized_path ||= '/'
    end

    # Inspired by Forem gem
    def user_class
      if @@user_class.is_a?(Class)
        raise "You can not set HiThere.user_class to be a class. Please use a string instead.\n\n"
      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end
  end
end
