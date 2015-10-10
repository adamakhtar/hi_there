# Credit where credit is due - blatanly copied from radar/forem and plataformatec/devise
require 'rails/generators'
module HiThere
  module Generators
    class SubscriptionViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views", __FILE__)
      desc "Used to copy hi_there's front facing subscription views and layout to your application's views."

      def copy_views
        view_directory :subscriptions
        view_layout 'subscriptions.html.erb'
      end

      protected

      def view_directory(name)
        directory "hi_there/#{name.to_s}", "app/views/hi_there/#{name}"
      end

      def view_layout(name)
        copy_file "layouts/hi_there/#{name.to_s}", "app/views/layouts/hi_there/#{name}"
      end
    end
  end
end
