class Location < ActiveRecord::Base
  # attr_accessible
  attr_accessible :address, :latitude, :longitude, :name

  # dependencies
  has_many :events, :dependent => :destroy

  #functions
  # find_by_sport_and_pe_class
  #   INPUT: user_id (session value)
  #   OUTPUT: locations (Location.object)  
  #   FROM: controllers/locations_controller/location_list
  #   2012.6.26, 2012.7.10 Yueying
  def self.find_by_sport_peclass(user_id)
      location_ids = Location.find_by_sql("SELECT DISTINCT locations.id FROM user_sport_preferences, users, events, locations WHERE user_sport_preferences.user_id = " + user_id.to_s + " AND users.pe_class_id = events.pe_class_id AND events.sport_id = user_sport_preferences.sport_id AND events.location_id = locations.id")
      return locations = Location.find_all_by_id(location_ids)
  end

  # functions for gmaps4rails
  acts_as_gmappable
      def gmaps4rails_address
          address
      end
      
      def gmaps4rails_infowindow
      # add here whatever html content you desire, it will be displayed when users clicks on the marker
		
          event = Event.find_by_location_id(self.id)
          "#{self.name}"
      end
end
