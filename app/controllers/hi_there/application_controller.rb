module HiThere
  class ApplicationController < ::ApplicationController 
    before_filter :ensure_authorized

    def engine_user
      send(HiThere.current_user_method)
    end

    def engine_authorized?
      ( engine_user.present? and engine_user.send(HiThere.authorization_method) )
    end

    def ensure_authorized
      redirect_unauthorized unless engine_authorized?
    end

    def redirect_unauthorized
      flash[:alert] = t('hi_there.unauthorized')
      redirect_to HiThere.redirect_unauthorized_path
    end

    def with_editable_course
      course = find_course
      if course.draft?
        yield course
      else
        redirect_unauthorized
      end
    end
  end
end
