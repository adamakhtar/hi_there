require_dependency "hi_there/application_controller"

module HiThere
  class CoursesController < ApplicationController
    def index
      @courses = Course.all
    end

    def show
      @course = find_course
      @dashboard = CourseDashboard.new(@course)
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
      with_editable_course do |course|
        @course = course
      end
    end

    def update
      with_editable_course do |course|
        @course = course
        if @course.update_attributes(course_params)
          flash[:success] = t('hi_there.courses.updated')
          redirect_to course_path(@course)
        else
          render :edit
        end
      end
    end

    def open
      course = find_course
      course.open!
      flash[:success] = t('hi_there.courses.opened')
      redirect_to course_path(course)    
    end

    def close
      course = find_course
      course.close!
      flash[:success] = t('hi_there.courses.closed')
      redirect_to course_path(course)
    end

    def terminate
      course = find_course
      operation = TerminateCourse.new(course)
      operation.perform
      flash[:success] = t('hi_there.courses.terminated')
      redirect_to course_path(course)
    end

    protected

    def course_params
      params.require(:course).permit(:description, :name, :title)
    end

    def find_course
      Course.find(params[:id])
    end

    def redirect_not_authorized
      flash[:error] = t('hi_there.common.not_authorized')
      redirect_to root_path
    end
  end
end
