class User < ActiveRecord::Base

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}

  before_save { self.email = email.downcase}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    # If user exists AND password entered is correct.
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
