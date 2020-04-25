class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :user_type, presence: true

    def self.authenticate(email, password)
        user = find_by_email(email)
        if user && user.password == password
            return user
        end
        nil
      end
    
end
