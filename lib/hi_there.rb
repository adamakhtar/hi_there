require "hi_there/engine"
require "acts_as_list"
require "email_validator"
require 'jquery-rails'
require 'jquery-ui-rails'
require "kaminari"
require "simple_form"
require "workflow"

module HiThere
  mattr_accessor :app_domain,
                 :authorization_method, 
                 :current_user_method,
                 :from,
                 :per_page,
                 :redirect_unauthorized_path, 
                 :reply_to,
                 :user_class

  class << self
    def app_domain 
      @@app_domain ||= "example.com"
    end

    def authorization_method      
      @@authorization_method ||= :can_access_hi_there?
    end

    def current_user_method
      @@current_user_method ||= :current_user
    end

    def from
      @@from ||= 'Admin'
    end

    def per_page
      @@per_page || 20
    end

    def redirect_unauthorized_path
      @@redirect_unauthorized_path ||= '/'
    end

    def reply_to
      @@reply_to ||= 'you_need_to_set_the_hi_there_reply_to@see_initializer.com'
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
