class UsersController < ApplicationController
  layout 'form'
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # confirm_information
  #   INPUT: user_id (session value)
  #   OUTPUT: user (User.object)
  #   FROM: /controllers/sessions_controller/create
  #   TO: /views/users/confirm_information
  #   2012.7.10 Yueying
  def confirm_information
    @user = User.find(session[:user_id])
  end

  # render_reset_password
  #   INPUT: 
  #   OUTPUT:
  #   FROM: /views/users/cofirm_information
  #   TO: /views/users/reset_information
  #   2012.7.10 Yueying
  def render_reset_password
    render :file => '/users/reset_password'
  end

  # reset_password
  #   INPUT: user_id (session value)
  #   OUTPUT: UPDATE user.password
  #   FROM: /views/users/reset_password
  #   TO: /views/sports/index
  #   2012.7.10 Yueying
  def reset_password
    user = User.find(session[:user_id])
    if user == User.authenticate(user.username, params[:old_password])
      user.password = (params[:new_password])
 
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE users SET users.salt = '" + user.salt + "', users.hashed_password = '" + user.hashed_password + "', users.active_code = 1 WHERE users.id = " + user.id.to_s)
      Notifier.parental_consent_confirmation.deliver
    end

    respond_to do |format|
      format.html { redirect_to '/sports' }
      format.json { head :no_content }
    end
  end

  # render_confirm_parental_consent
  #   INPUT: 
  #   OUTPUT:
  #   FROM: /views/users/cofirm_information
  #   TO: /views/users/render_confirm_parental_consent
  #   2012.7.11 Yueying
  def render_confirm_parental_consent
    render :file => '/users/confirm_parental_consent'
  end

  # parental_consent
  #   INPUT: check_box_tag == yes? (value)
  #   OUTPUT: send an email to parents' email address
  #   FROM: views/users/parental_consent
  #   TO: views/users/render_reset_password
  #   2012.7.11 Yueying
  def confirm_parental_consent
    if params[:parental_consent] == 'yes'
      Notifier.parental_consent_confirmation.deliver
      redirect_to '/users/render_reset_password'
    else
      redirect_to '/login'
    end
  end
end
