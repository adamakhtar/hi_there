require_dependency "hi_there/application_controller"

module HiThere
  class EmailsController < ApplicationController
    def index
    end

    def show
      load_course
      @email = find_email
    end

    def new
        load_course
        @email = build_email
    end

    def create
      load_course
      @email = build_email(email_params)

      if @email.save
        flash[:success] = t('hi_there.emails.created')
        redirect_to course_path(@course)
      else
        render :new
      end
    end

    def edit
      load_course
      @email = find_email
    end

    def update
      load_course
      @email = find_email

      if @email.update_attributes(email_params)
        flash[:success] = t('hi_there.emails.updated')
        redirect_to course_email_path(@course, @email)
      else
        render :edit
      end
    end

    protected

    def load_course
      @course ||= Course.find(params[:course_id])
    end

    def find_email
      @course.emails.find(params[:id])
    end

    def build_email(args={})
      @course.emails.build(args)
    end

    def email_params
      params.require(:email).permit(:subject, :body, :interval)
    end
  end
end
