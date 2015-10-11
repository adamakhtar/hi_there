require_dependency "hi_there/application_controller"
module HiThere
  module Courses
    class FormSetupsController < ApplicationController

      def index
        @course = find_course
      end

      private

      def find_course
        Course.find(params[:course_id])
      end
    end
  end
end 