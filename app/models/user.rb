class User < ActiveRecord::Base
	attr_accessible :company, :email, :name, :telephone, :password, :password_confirmation
	has_secure_password
	has_one :dataset, dependent: :destroy

	before_save { |user| user.email = email.downcase }
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :telephone, presence: true
	validates :company, presence: true
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end

