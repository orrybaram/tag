require 'digest/sha2'

class Teacher < ActiveRecord::Base
  # attr_accessible
  attr_accessible :email, :firstname, :lastname, :gender, :telephone, :password, :password_confirmation

  # dependencies
  belongs_to :school
  has_many :pe_classes

  # email validates: exist, unique
  validates :email, :presence => true, :uniqueness => true

  # password validates: reenter match, exist
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  # functions
  # authenticate(email, password)
  #   INPUT: email, password (values)
  #   OUTPUT: teacher (Teacher.object)
  #   FROM: /views/teachers/login
  #   TO: /views/teachers/home
  #   2012.7.10 Yueying
  class << self
    def Teacher.authenticate(email, password)
      if teacher = find_by_email(email)
        $a = encrypt_password(password, teacher.salt)
        if teacher.hashed_password == encrypt_password(password, teacher.salt)[0,30] #!!!
          teacher
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
