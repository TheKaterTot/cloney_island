class PasswordToken < ActiveRecord::Base
  belongs_to :user
end
