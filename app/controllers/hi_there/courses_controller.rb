require_dependency "hi_there/application_controller"

module HiThere
  class CoursesController < ApplicationController
    def index
      @courses = Course.all
    end

    def show
      @course = find_course
      @emails = @course.emails.soonest_first
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        flash[:success] = t('hi_there.courses.created')
        redirect_to course_path(@course)
      else
        render :new
      end
    end

    def edit
      @course = find_course
    end

    def update
      @course = find_course

      if @course.update_attributes(course_params)
        flash[:success] = t('hi_there.courses.updated')
        redirect_to course_path(@course)
      else
        render :edit
      end
    end

    protected

    def course_params
      params.require(:course).permit(:title)
    end

    def find_course
      Course.find(params[:id])
    end
  end
end
