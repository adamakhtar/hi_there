require 'rails/generators'
module HiThere
  module Generators
    # Big thank you to Forem gem for this install generator.
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "current-user-method", :type => :string
      # class_option "no-migrate", :type => :boolean

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install HiThere"

      def install_migrations
        puts "Copying over HiThere migrations..."
        Dir.chdir(Rails.root) do
          `rake hi_there:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end

      def determine_current_user_method
        @current_user_method = options["current-user-method"].presence ||
                              ask("What is the current_user method called in your app? [current_user]").presence ||
                              :current_user
      end

      def add_hi_there_initializer
        path = "#{Rails.root}/config/initializers/hi_there.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/hi_there.rb creation, as file already exists!"
        else
          puts "Adding hi_there initializer (config/initializers/hi_there.rb)..."
          template "initializer.rb", path
          require path # Load the configuration per issue #415
        end
      end

      def create_stylesheet
        create_file Rails.root + "vendor/assets/stylesheets/hi-tower.scss"
      end

      def add_stylesheet_to_path
        puts "Adding hi-there.scss to assets precompile path in config/initializers/assets.rb..."
        append_to_file("#{Rails.root}/config/initializers/assets.rb") do
          %Q{Rails.application.config.assets.precompile += %w( hi-there.css )}
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def mount_engine
        puts "Mounting HiThere::Engine at \"/hi_there\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{mount HiThere::Engine, :at => '/hi_there'\n\n}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nSuccess! HiThere was installed.\n\n
Here's what happened:\n\n}

        output += step("HiThere's migrations were copied over into db/migrate.\n")
        output += step("A new file was created at config/initializers/hi_there.rb
   This is where you put HiThere's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")      
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount HiThere::Engine, :at => \"/hi_there\"

   If you want to change where HiThere's dashboard is located, just change the \"/hi_there\" path at the end of this line to whatever you want.\n\n")
        output += %Q{Currently any persisted user can access the dashboard. You will want to lock this down to certain users such as admin. To do that you should define a method in your user model which returns true for authorized users. E.g. is_admin? etc. Then configure HiThere to use this method in the initializer file we just copied over.\n\n}
        output += "\nIf you have any questions, comments or issues, please post them on the issues page: http://github.com/robodisco/hi_there/issues.\n\n"
        output += "Thanks for using HiThere!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def current_user_method
        @current_user_method
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
