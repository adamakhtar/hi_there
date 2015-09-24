require_dependency "hi_there/application_controller"

module HiThere
  class CoursesController < ApplicationController
    def index
    end

    def show
      @course = find_course
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
