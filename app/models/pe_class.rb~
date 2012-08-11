class PeClass < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :school_id, :teacher_id, :name
  
  # dependencies
  has_many :pe_classmembers
  has_many :users
  belongs_to :school
  belongs_to :teacher

  # functions
  # find_news
  #   INPUT: user_id (value)
  #   OUTPUT: activities (Music.object + MusicLike.object + Userfun.object)
  def self.find_news(user_id)
    @musics = Music.find_musics_by_user(user_id)
    @music_likes = MusicLike.find_music_likes_by_user(user_id)
    @user_funs = UserFun.find_by_user1(user_id)
    @activities = @musics + @music_likes + @user_funs

    return activities = @activities.sort_by {|a| a.created_at}
  end
end
