require_dependency "hi_there/application_controller"

module HiThere
  module Courses
    class EmailsController < ApplicationController    
      def index
        @course = find_course
        @emails = @course.emails
      end

      def show
        @course = find_course
        @email = find_email
        @body = RenderEmail.new(@email).perform
      end

      def new
        with_editable_course do |course|
          @course = course 
          @email = build_email
        end
      end

      def create
        with_editable_course do |course|
          @course = course 
          @email = build_email(email_params)

          if @email.save
            flash[:success] = t('hi_there.emails.created')
            redirect_to course_emails_path(@course)
          else
            render :new
          end
        end
      end

      def edit
        with_editable_course do |course|
          @course = course 
          @email = find_email
        end
      end

      def update
        with_editable_course do |course|
          @course = course 
          @email = find_email

          if @email.update_attributes(email_params)
            flash[:success] = t('hi_there.emails.updated')
            redirect_to course_email_path(@course, @email)
          else
            render :edit
          end
        end
      end

      def reorder
        with_editable_course do |course|
          @course = course
          email = find_email

          case params[:direction]
          when 'higher' then email.move_higher
          when 'lower' then email.move_lower
          end
          
          redirect_to course_path(@course)
        end
      end

      protected

      def find_course
        Course.find(params[:course_id])
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
end
