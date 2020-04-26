class User <  ActiveRecord::Base

	before_save { self.email = email.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :articles, dependent: :destroy

	validates :name, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }

	validates :email, presence: true, length: { maximum: 105 },
		uniqueness: { case_sensitive: false },
		format: { with: VALID_EMAIL_REGEX }

	has_secure_password

	has_one_time_password length: 4

end