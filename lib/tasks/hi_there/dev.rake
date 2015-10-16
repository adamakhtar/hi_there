namespace :hi_there do
  namespace :dev do

    desc "Create basic models for development" 
    task :prime do
      unless Rails.env.development?
        raise 'This task can only be run in the development environment'
      end

      create_courses
      create_emails
      create_subscriptions
    end

    def create_courses
      @course_a = HiThere::Course.create!(name: 'course_1', title: 'How to invest 101')
      @course_b = HiThere::Course.create!(workflow_state: :opened, name: 'course_2', title: 'How to play bingo 101')
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
      # opted in subscriptions
      [@course_a, @course_b].each do |course| 
        # opted in
        3.times do 
          HiThere::Subscription.create!(workflow_state: :opted_in, course: course, email: "adam#{rand(10000)}@example.com")
        end

        # activated
        3.times do 
          subscription = HiThere::Subscription.create!(workflow_state: :opted_in, course: course, email: "adam#{rand(10000)}@example.com")
          HiThere::ActivateSubscription.new(subscription).perform
        end

        # ongoing
        3.times do 
          subscription = HiThere::Subscription.create!(workflow_state: :opted_in, course: course, email: "adam#{rand(10000)}@example.com")
          HiThere::ActivateSubscription.new(subscription).perform
          rand(3).times do 
            HiThere::AdvanceSubscription.new(subscription).perform
          end
        end

        #completed
        3.times do 
          last_email = course.emails.last
          subscription = HiThere::Subscription.create!(workflow_state: :completed, previous_email: last_email, course: course, email: "adam#{rand(10000)}@example.com")          
        end

        #unsubscribed
        emails = course.emails
        3.times do 
          last_email = emails.shuffle.pop
          subscription = HiThere::Subscription.create!(workflow_state: :unsubscribed, previous_email: last_email, next_email: last_email.next_in_line, course: course, email: "adam#{rand(10000)}@example.com")          
        end
      end
    end
  end
end