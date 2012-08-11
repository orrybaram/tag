class Trainer < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :sex, :telephone
end
