class HomeController < ApplicationController
  def index
    
  end

  def landing_page
    @course = HiThere::Course.where(name: 'test_course').take
    @subscription = @course.subscriptions.build if @course
  end 
end
