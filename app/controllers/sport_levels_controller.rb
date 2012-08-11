
class SportLevelsController < ApplicationController
  # GET /sport_levels
  # GET /sport_levels.json
  def index
    @sport_levels = SportLevel.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sport_levels }
    end
  end

  # GET /sport_levels/1
  # GET /sport_levels/1.json
  def show
    @sport_level = SportLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @sport_level }
    end
  end

  # GET /sport_levels/new
  # GET /sport_levels/new.json
  def new
    @sport_level = SportLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @sport_level }
    end
  end

  # GET /sport_levels/1/edit
  def edit
    @sport_level = SportLevel.find(params[:id])
  end

  # POST /sport_levels
  # POST /sport_levels.json
  def create
    @sport_level = SportLevel.new(params[:sport_level])

    respond_to do |format|
      if @sport_level.save
        format.html { redirect_to @sport_level, :notice => 'Sport level was successfully created.' }
        format.json { render :json => @sport_level, :status => :created, :location => @sport_level }
      else
        format.html { render :action => "new" }
        format.json { render :json => @sport_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sport_levels/1
  # PUT /sport_levels/1.json
  def update
    @sport_level = SportLevel.find(params[:id])

    respond_to do |format|
      if @sport_level.update_attributes(params[:sport_level])
        format.html { redirect_to @sport_level, :notice => 'Sport level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @sport_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_levels/1
  # DELETE /sport_levels/1.json
  def destroy
    @sport_level = SportLevel.find(params[:id])
    @sport_level.destroy

    respond_to do |format|
      format.html { redirect_to sport_levels_url }
      format.json { head :no_content }
    end
  end

  # sport_level_list
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW sport_levels (SportLevel.object) list
  #   FROM: views/teams/home
  #   TO: views/sport_levels/sport_level_list
  #   2012.7.11 Yueying
  def sport_level_list
    @sport_levels = SportLevel.find_by_user(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @sport_levels }
    end
  end

  # home
  #   INPUT: sport_level_id (value)
  #   OUTPUT: PASS PARAMS sport_level_id (value) 
  #   FROM: views/sport_levels/sport_level_list
  #   TO: views/sport_levels/home
  #   2012.6.30 Yueying
  def home
    @sport_level_id = params[:sport_level_id]
  end
  
  # guidence
  #   INPUT: sport_level_id (value)
  #   OUTPUT: SHOW sport_level (SportLevel.object)
  #   FROM: views/sport_levels/home
  #   TO: views/sport_levels/guidence
  #   2012.6.30 Yueying
  def guidence
    @sport_level = SportLevel.find(params[:sport_level_id])
  end
end
