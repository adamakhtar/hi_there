# Credit where credit is due - blatanly copied from radar/forem and plataformatec/devise
require 'rails/generators'
module HiThere
  module Generators
    class MailerViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views/hi_there", __FILE__)
      desc "Used to copy hi_there's mailer views to your application's views."

      def copy_views
        view_directory :subscription_mailer
      end

      protected

      def view_directory(name)
        directory name.to_s, "app/views/hi_there/#{name}"
      end
    end
  end
end
