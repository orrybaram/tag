class Fun < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :location, :name, :sport_id

  # dependencies
  has_many :user_funs
  belongs_to :game

  # functions
  # find_funs_by_game_peclass(user_id)
  #   INPUT: user_id (session value)  
  #   OUTPUT: funs (Fun.object)
  #   FROM: controllers/funs_controller/list_selected
  #   2012.7.6 Yueying
  def self.find_funs_by_game_peclass(user_id)
      fun_ids = Fun.find_by_sql("SELECT funs.id FROM user_game_preferences, games, funs, users WHERE user_game_preferences.user_id = " + user_id.to_s + " AND games.id = user_game_preferences.game_id AND funs.game_id = games.id AND funs.pe_class_id = users.pe_class_id")
      return funs = Fun.find_all_by_id(fun_ids)
  end
  
end
