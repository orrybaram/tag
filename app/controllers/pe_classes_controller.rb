class PeClassesController < ApplicationController
  layout 'dashboard'
  # GET /pe_classes
  # GET /pe_classes.json
  def index
    @pe_classes = PeClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pe_classes }
    end
  end

  # GET /pe_classes/1
  # GET /pe_classes/1.json
  def show
    @pe_class = PeClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @pe_class }
    end
  end

  # GET /pe_classes/new
  # GET /pe_classes/new.json
  def new
    @pe_class = PeClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @pe_class }
    end
  end

  # GET /pe_classes/1/edit
  def edit
    @pe_class = PeClass.find(params[:id])
  end

  # POST /pe_classes
  # POST /pe_classes.json
  def create
    @pe_class = PeClass.new(params[:pe_class])

    respond_to do |format|
      if @pe_class.save
        format.html { redirect_to @pe_class, :notice => 'Pe class was successfully created.' }
        format.json { render :json => @pe_class, :status => :created, :location => @pe_class }
      else
        format.html { render :action => "new" }
        format.json { render :json => @pe_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pe_classes/1
  # PUT /pe_classes/1.json
  def update
    @pe_class = PeClass.find(params[:id])

    respond_to do |format|
      if @pe_class.update_attributes(params[:pe_class])
        format.html { redirect_to @pe_class, :notice => 'Pe class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @pe_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pe_classes/1
  # DELETE /pe_classes/1.json
  def destroy
    @pe_class = PeClass.find(params[:id])
    @pe_class.destroy

    respond_to do |format|
      format.html { redirect_to pe_classes_url }
      format.json { head :no_content }
    end
  end

  # news_list
  #   INPUT: user_id (sesion value)
  #   OUTPUT: musics (Music.object), music_likes (MusicLike.object), user_funs (UserFun.object)
  #   FROM: /views/pe_classes/home
  #   TO: views/pe_classes/news_list
  #   2012.7.5 Yueying
  def news_list
    @activities = PeClass.find_news(session[:user_id])
    
  end
end
