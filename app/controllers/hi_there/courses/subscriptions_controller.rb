module HiThere
  module Courses
    class SubscriptionsController < ApplicationController
      def index
        @course = find_course
        @subscriptions = @course.subscriptions
      end

      private

      def find_course
        Course.find(params[:course_id])
      end
    end
  end
end 