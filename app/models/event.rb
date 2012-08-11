class Event < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :location_id, :sport_id, :teacher_id, :trainer_id

  # dependencies
  has_many :userevents, :class_name => 'Userevent'
  has_many :teams, :class_name => 'Team'

  belongs_to :location
  belongs_to :sport
  belongs_to :user
  belongs_to :teacher
  belongs_to :trainer

  #functions
  # find_time_by_sport_location_peclass
  #   INPUT: user_id (session value), location_id (value)
  #   OUTPUT: event (Event.object)
  #   FROM: controllers/events_controller/datetime_list
  #   2012.6.26 Yueying
  def self.find_by_sport_location_peclass(location_id, user_id)
    event_ids = Event.find_by_sql("SELECT events.id FROM user_sport_preferences, users, events WHERE user_sport_preferences.user_id = " + user_id.to_s + " AND user_sport_preferences.sport_id = events.sport_id AND events.location_id = " + location_id.to_s)
    return events = Event.find_all_by_id(event_ids)
  end

  # find_by_user(user_id)
  #   from: controllers/events_controller/my_event_information
  #   input: user_id (value)
  #   output: event (Event.object)
  #   2012.6.30 Yueying
  def self.find_by_user(user_id)
    event_id = Event.find_by_sql("SELECT events.id FROM teammembers, teams, events WHERE teammembers.user_id = " + user_id.to_s + " AND teammembers.team_id = teams.id AND teams.event_id = events.id")
    return event = Event.find_by_id(event_id)
  end
end
