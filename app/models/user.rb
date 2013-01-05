# == Schema Information
#
# Table name: users
#
#  id              :integer         primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  #before_save { |user| user.email = email.downcase }
  before_save { self.email.downcase! }
  # the exclamation '!' should be there at the end
  # saving remember_token attribute as well by calling a private method
  before_save :create_remember_token
 
  validates(:name, presence: true, length: {maximum: 50 } )
  validates(:password, presence: true, length: {minimum: 6, maximum: 50 } )
  validates(:password_confirmation, presence: true )
### validates_confirmation i.e. if pwd and pwd_conf match, need not be put.. as we have### has_secure_password#### method up there. that method checks this too
#  validates_confirmation_of :password


VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } )

  private
      def create_remember_token
	self.remember_token = SecureRandom.urlsafe_base64
      end
end
