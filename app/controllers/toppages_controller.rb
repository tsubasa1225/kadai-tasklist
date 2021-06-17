class ToppagesController < ApplicationController
  include SessionsHelper
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc)
    else
      redirect_to login_url
    end
  end
end
