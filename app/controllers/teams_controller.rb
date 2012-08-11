
class TeamsController < ApplicationController
  layout 'dashboard'
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  # create
  #   INPUT: user_id (session value)
  #   OUTPUT: SAVE team (Team.object), teammember (Teammember.object)
  #   FROM: views/teams/team_register
  #   TO:
  #   2012.7.6, 2012.7.11 Yueying
  def create
    # get event_id params
    hash = params[:register]
    if hash != nil
      hash_invert = hash.invert
      event_id = hash_invert.values_at("register").first.to_i
    end
    
    # if he/she has already created an event, but on one else join the event
    # destroy the old location, event firstly
    if Event.find_by_user_id(session[:user_id]) != nil
      event = Event.find_by_user_id(session[:user_id])
      location = event.location
      location.destroy
      event.destroy
    end

    # if he/she has already created a team, but no one else join the team
    # destroy the old team, teammember firstly
    if Team.find_by_user_id(session[:user_id]) != nil
      team = Team.find_by_user_id(session[:user_id])
      teammember = Teammember.find_by_team_id(team.id)
      teammember.destroy
      team.destroy
    end

    # if he/she is the 1st teammember, would like to create a team
    if Team.find_by_event_id(event_id) == nil 

      # create team
      @team = Team.new(params[:team])
      @team.user_id = session[:user_id]
      @team.event_id = event_id
      @team.save

      # create teammember
      teammember = Teammember.new
      teammember.team_id = @team.id
      teammember.user_id = session[:user_id]
      teammember.save

      flash[:notice] = "Create a team to be an owner!"
      flash.keep(:notice)
      redirect_to '/admin/home', :notice => 'Team was successfully created.'
    # if he/she is the 2nd teammember, would like to join the team
    else 
      # create teammember
      team = Team.find_by_event_id(event_id)
      teammember = Teammember.new
      teammember.team_id = team.id
      teammember.user_id = session[:user_id]
      teammember.save
      
      # modify teammembers' active_code = 2
      teammember1 = User.find(session[:user_id])
      teammember2 = team.user
      teammember1.update_attribute(:active_code, 2)
      teammember2.update_attribute(:active_code, 2)

      # modify event.is_available = 1
      event = Event.find(event_id)
      event.update_attribute(:is_available, 1)

      redirect_to '/admin/home', :notice => 'Team was successfully joined.'
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, :notice => 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  # destroy
  #   INPUT:
  #   OUTPUT: DELETE
  #   FROM: controllers/teams_controller/create
  #   2012.7.11 Yueying
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  # team_information
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW team.name, teammate.firstname&lastname, user.firstname$lastname
  #   FROM: views/teams/home
  #   TO: views/teams/team_information 
  #   2012.6.29 Yueying
  def team_information
    @team = Team.find_by_user1(session[:user_id])
    @teammate = Team.find_teammate(session[:user_id])
    @user = User.find(session[:user_id])

    flash.now[:notice] = "You need a teammember!"
    render :controller => 'teams', :action => 'team_information'
  end

  # teamowner_information
  #   INPUT: event_id (value)
  #   OUTPUT: SHOW team (User.object), teamowner (User.object)
  #   FROM: views/events/datetime_list
  #   TO: views/teams/teamowner_information
  #   2012.6.26 Yueying
  def teamowner_information   
    team = Team.find_by_event_id(params[:event_id])
    if team != nil
      @teamowner = Team.find_teamowner(team.id)
      @initial_level = team.initial_level
    else
      flash[:notice] = "Create a team to be an owner!"
      flash.now
      redirect_to :controller => 'teams', :action => 'teamowner_information', :notice => "Create a team to be an owner!"
    end

  end

  # team_information_list
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW team (Team.object), sport (Sport.object), sport_level (SportLevel.object)
  #   FROM: views/classes/home
  #   TO: views/teams/teams_information
  #   2012.7.3 Yueying
  def team_information_list
    @teams = Team.find_teams_by_user(session[:user_id])
    
  end

  # levelup
  #   INPUT: user_id (session value)
  #   OUTPUT: SAVE sport_level
  #   FROM: /views/events/my_event_information
  #   TO:
  #   2012.7.16 Yueying
  def levelup
    # update team.sport_level_id
    team = Team.find_by_user1(session[:user_id])
    sport_level = SportLevel.first(:conditions => ['id > ?', team.sport_level_id], :order => 'id ASC')
    team.update_attribute(:sport_level_id, sport_level.id)

    # save user_point
    user_point = UserPoint.new
    user_point.add_point(session[:user_id], 25000, 'event')
   
    # save team_point 
    team_point = TeamPoint.new
    team = Team.find_by_user1(session[:user_id])
    team_point.add_point(team.id, 50000)

    redirect_to '/admin/home'
  end
end
