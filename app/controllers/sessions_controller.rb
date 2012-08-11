
class SessionsController < ApplicationController
  def new
  end

  # create
  #   INPUT: email, password (value)
  #   OUPUT:
  #   FROM: /views/login
  #   TO: /views/admin/index
  #   2012.6.21, Yueying
  def create 
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      if user.active_code == 0
        redirect_to '/users/confirm_information'
      elsif user.active_code == 1
        redirect_to '/sports'
      else
        redirect_to '/admin/home'
      end
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end


  # create_teacher
  #   INPUT: email, password (value)
  #   OUPUT:
  #   FROM: /views/teachers/login
  #   TO: /views/teachers/home
  #   2012.7.10, Yueying
  def create_teacher
    if teacher = Teacher.authenticate(params[:email], params[:password])
      session[:teacher_id] = teacher.id
      redirect_to '/teachers/home'
    else
      redirect_to 'teachers/login', :alert => "Invalid user/password combination"
    end
  end

  def destroy_teacher
    session[:teacher_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end
end
