require_dependency "hi_there/application_controller"

module HiThere
  class EmailsController < ApplicationController
    def index
    end

    def show
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
    end

    protected

    def load_course
      @course ||= Course.find(params[:course_id])
    end

    def build_email(args={})
      @course.emails.build(args)
    end

    def email_params
      params.require(:email).permit(:subject, :body, :interval)
    end
  end
end
