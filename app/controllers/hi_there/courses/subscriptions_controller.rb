require_dependency "hi_there/application_controller"

module HiThere
  module Courses
    class SubscriptionsController < ApplicationController
      def index
        @course = find_course
        @subscriptions = @course.subscriptions.page(params[:page]).per(40)

        respond_to do |format|
          format.html
          format.csv { send_data @subscriptions.to_csv }
        end
      end

      private

      def find_course
        Course.find(params[:course_id])
      end
    end
  end
end 