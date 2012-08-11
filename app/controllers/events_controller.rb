
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:event_id])
    @sport = @event.sport
    @location = @event.location

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  # new
  #   INPUT: 
  #   OUTPUT:
  #   FROM: views/locations/location_list_selected
  #   TO: views/events/new -> views/events/_form
  #   2012.7.6 Yueying 
  def new
    @event = Event.new
    @sports = Sport.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  # new
  #   INPUT: user_id (session value), sport_id (value), datetime (value), location (value)
  #   OUTPUT: SAVE event (Event.object), Location (Location.object)
  #   FROM: views/events/_form
  #   TO: views/admin/home
  #   2012.7.6 Yueying
  def create
    # if he/she has already created an event, but on one else join the event
    # destroy the old location, event firstly
    if Event.find_by_user_id(session[:user_id]) != nil
      event = Event.find_by_user_id(session[:user_id])
      location = event.location
      location = Location.destroy(location.id)
      event.destroy
    end

    # create event
    @event = Event.new(params[:event])
    @event.user_id = session[:user_id]
    user = User.find(session[:user_id])

    # transfer: dateofweek -> date in week (initial week = next week)
    dateofweek = params[:dateofweek]
    date_in_current_week = Date.parse(dateofweek)
    delta = date_in_current_week > Date.today ? 0 : 7
    date_in_initial_week = date_in_current_week + delta

    # datetime = date_in_initial_week + datetime
    require 'time'
    current = @event.datetime
    datetime = Time.mktime(date_in_initial_week.year, date_in_initial_week.month, date_in_initial_week.day, current.hour, current.min)
    @event.datetime = datetime
    @event.pe_class_id = user.pe_class.id
    @event.save

    # create location
    location = Location.new(:address => params[:location_address] )
    location.save
    @event.update_attribute(:location_id, location.id)

    # register this new event
    # if he/she has already created a team, but no one else has joined the team
    # destroy the old team, teammember firstly
    if Team.find_by_user_id(session[:user_id]) != nil
      team = Team.find_by_user_id(session[:user_id])
      teammember = Teammember.find_by_team_id(team.id)
      teammember.destroy
      team.destroy
    end

    # must be the 1st teammember, would like to create a team
    # create team
    @team = Team.new(params[:team])
    @team.user_id = session[:user_id]
    @team.event_id = @event.id
    @team.save

    # create teammember
    teammember = Teammember.new
    teammember.team_id = @team.id
    teammember.user_id = session[:user_id]
    teammember.save

    flash[:notice] = "Create a team to be an owner!"
    flash.keep(:notice)
    redirect_to '/admin/home', :notice => 'Team was successfully created.'
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  # destroy
  #   INPUT:
  #   OUTPUT: DELETE
  #   FROM: controllers/teams_controller/create
  #   2012.7.11 Yueying
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  # datetime_list
  #   INPUT: location_id (value), user_id (value)
  #   OUTPUT: SHOW events (Event.object)
  #   FROM: views/locations/location_list
  #   TO: views/events/datetime_list
  #   2012.6.26 Yueying
  def datetime_list
    @events = Event.find_by_sport_location_peclass(params[:location_id], session[:user_id])
    @team = Team.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @locations }
    end
  end

  # event_information
  #   INPUT: event_id (value)
  #   OUTPUT: SHOW event (Event.object), sport (Sport.object), location (Location.object)
  #   FROM: views/events/datetime_list
  #   TO: views/events/event_information
  #   2012.6.26, 2012.7.8 Yueying
  def event_information
    @event = Event.find(params[:event_id])
    @sport = @event.sport
    @location = @event.location

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end

  # my_event_information
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW event (Event.object), sport (Sport.object) location (Location.object)
  #   FROM: views/teams/home
  #   TO: views/events/my_event_information
  #   2012.6.30 Yueying
  def my_event_information
    @event = Event.find_by_user(session[:user_id])
    @sport = @event.sport
    @location = @event.location

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end
end
