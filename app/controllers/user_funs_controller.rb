
class UserFunsController < ApplicationController
  # GET /user_funs
  # GET /user_funs.json
  def index
    @user_funs = UserFun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user_funs }
    end
  end

  # GET /user_funs/1
  # GET /user_funs/1.json
  def show
    @user_fun = UserFun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user_fun }
    end
  end

  # GET /user_funs/new
  # GET /user_funs/new.json
  def new
    @user_fun = UserFun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_fun }
    end
  end

  # GET /user_funs/1/edit
  def edit
    @user_fun = UserFun.find(params[:id])
  end

  # POST /user_funs
  # POST /user_funs.json
  #   INPUT: fun_id (value)
  #   OUTPUT: SAVE user_fun (UserFun.object), fun.popularity +1
  #   FROM: views/funs/list_selected
  #   TO: 
  #   2012.7.6 Yueying
  def create
    hash = params[:register]

    if  hash != nil
      user_fun = UserFun.new
      user_fun.user_id = session[:user_id]
      hash_invert = hash.invert
      user_fun.fun_id = hash_invert.values_at("register").first.to_i
      user_fun.save

      fun = user_fun.fun
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE funs SET funs.popularity = funs.popularity + 1 WHERE funs.id = " + fun.id.to_s)
    end

    respond_to do |format|
      format.html { redirect_to '/admin/home' }
    end
  end

  # PUT /user_funs/1
  # PUT /user_funs/1.json
  def update
    @user_fun = UserFun.find(params[:id])

    respond_to do |format|
      if @user_fun.update_attributes(params[:user_fun])
        format.html { redirect_to @user_fun, :notice => 'User fun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_fun.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_funs/1
  # DELETE /user_funs/1.json
  def destroy
    @user_fun = UserFun.find(params[:id])
    @user_fun.destroy

    respond_to do |format|
      format.html { redirect_to user_funs_url }
      format.json { head :no_content }
    end
  end
end
