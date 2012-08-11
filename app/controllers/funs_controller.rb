class FunsController < ApplicationController
  layout 'dashboard'
  # GET /funs
  # GET /funs.json
  def index
    @funs = Fun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @funs }
    end
  end

  # GET /funs/1
  # GET /funs/1.json
  def show
    @fun = Fun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @fun }
    end
  end

  # GET /funs/new
  # GET /funs/new.json
  def new
    @fun = Fun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @fun }
    end
  end

  # GET /funs/1/edit
  def edit
    @fun = Fun.find(params[:id])
  end

  # POST /funs
  # POST /funs.json
  def create
    @fun = Fun.new(params[:fun])

    respond_to do |format|
      if @fun.save
        format.html { redirect_to @fun, :notice => 'Fun was successfully created.' }
        format.json { render :json => @fun, :status => :created, :location => @fun }
      else
        format.html { render :action => "new" }
        format.json { render :json => @fun.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funs/1
  # PUT /funs/1.json
  def update
    @fun = Fun.find(params[:id])

    respond_to do |format|
      if @fun.update_attributes(params[:fun])
        format.html { redirect_to @fun, :notice => 'Fun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fun.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funs/1
  # DELETE /funs/1.json
  def destroy
    @fun = Fun.find(params[:id])
    @fun.destroy

    respond_to do |format|
      format.html { redirect_to funs_url }
      format.json { head :no_content }
    end
  end

  # fun_list
  #   INPUT: game_ids (value)
  #   OUTPUT: funs (Fun.objects)
  #   FROM: views/games/index
  #   TO: views/funs/list_selected
  #   2012.7.6 Yueying
  def fun_list
    @funs = Fun.find_funs_by_game_peclass(session[:user_id])
    @user_fun = UserFun.new
  end

  # my_fun_list
  #   INPUT: user_ids (value)
  #   OUTPUT: funs (Fun.object)
  #   FROM: views/funs/home
  #   TO: views/funs/list_by_user
  #   2012.7.6 Yueying
  def my_fun_list
    user_funs = UserFun.find_all_by_user_id(session[:user_id])
    @user_funs = UserFun.find_all_by_user_id(session[:user_id])
  end
end
