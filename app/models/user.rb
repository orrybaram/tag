require 'digest/sha2'

class User < ActiveRecord::Base
  # dependencies
  has_many :usersports_preferences, :dependent => :destroy 
  has_many :userevents, :dependent => :destroy  
  has_many :teammembers, :dependent => :destroy  
  has_many :pe_classmembers, :dependent => :destroy  
  has_many :musics, :dependent => :destroy  
  has_many :music_likes, :dependent => :destroy  
  has_many :user_funs, :dependent => :destroy  
  has_many :teams
  belongs_to :pe_class

  # attr_accessible :URL variable changeable
  attr_accessible :username, :firstname, :lastname, :email, :password, :password_confirmation, :email_parent, :gender, :hashed_password, :pe_class_id, :created_at, :id, :active_code, :salt, :updated_at

  # username validates: exist, unique
  validates :username, :presence => true, :uniqueness => true

  # password validates: reenter match, exist
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  # functions
  # 2012.6.21 Yueying
  # return user object
  class << self
    def User.authenticate(username, password)
      if user = find_by_username(username)
        $a = encrypt_password(password, user.salt)
        if user.hashed_password == encrypt_password(password, user.salt)[0,30] #!!!
          user
        end
      end
    end

    # encrypt password
    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end
  end

  # def password (password is a virtual attribute）
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)[0,30] 
    end
  end

  private
    def password_must_be_present
      errors.add(:password, "Missing password" ) unless hashed_password.present?
    end

    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

end
