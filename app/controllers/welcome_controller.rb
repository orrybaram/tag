class WelcomeController < ApplicationController
  layout 'welcome'
  # create
  #   INPUT: email, password (value)
  #   OUPUT:
  #   FROM: /views/login
  #   TO: /views/admin/index
  #   2012.6.21, Yueying
  def index 
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      if user.active_code == 0
        redirect_to '/users/confirm_information'
      elsif user.active_code == 1
        redirect_to '/sports'
      else
        redirect_to '/home'
      end
    else
        flash.keep[:notice]="Invalid"
    end
  end
end
