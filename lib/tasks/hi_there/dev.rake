namespace :hi_there do
  namespace :dev do

    desc "Create basic models for development" 
    task prime: ['db:setup']  do
      unless Rails.env.development?
        raise 'This task can only be run in the development environment'
      end
      
      require 'factory_girl_rails'
      require 'hi_there/testing_support/factories'
      include FactoryGirl::Syntax::Methods

      create_admin
      create_courses
      create_emails
      create_subscriptions
    end

    def create_admin
      create(:admin, email: 'admin@example.com')  
    end

    def create_courses
      @course_a = create(:course, name: 'course_1', title: 'How to invest 101', deliver_at: DateTime.parse("09:00"))
      @course_b = create(:course, workflow_state: :opened, name: 'course_2', title: 'How to play bingo 101', deliver_at: DateTime.parse("09:00"))
    end

    def create_emails
      5.times do |x|
        HiThere::Email.create!(course: @course_a, subject: "Email No. #{x}", body: "blah blah blah")
      end

      5.times do |x|
        HiThere::Email.create!(course: @course_b, subject: "Email No. #{x}", body: "blah blah blah")
      end
    end

    def create_subscriptions
      # subscriptions for opened course
      create(:subscription, :opted_in, course: @course_a, created_at: 1.week.ago)
      create(:subscription, :activated, course: @course_a, created_at: 1.week.ago)
      create(:subscription, :completed, course: @course_a, created_at: 1.week.ago)
      create(:subscription, :unsubscribed, course: @course_a, created_at: 1.week.ago)                
    end
  end
end