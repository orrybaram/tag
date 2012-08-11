class Sport < ActiveRecord::Base
  attr_accessible :name

  # dependencies
  has_many :events, :dependent => :destroy

  belongs_to :uersports_preference


end
