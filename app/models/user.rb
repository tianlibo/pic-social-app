class User < ActiveRecord::Base
  has_secure_password

  has_many :pictures

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false, message: "email has been used" }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i , message: 'format is incorrect'}

  before_create :generate_access_token


  def generate_access_token
    begin 
      self.access_token = SecureRandom.base64(64)
    end while User.find_by(access_token: access_token)
  end

  def reset_access_token
    generate_access_token
    save
  end


  class << self
    def rand_recerver_except(user_id)
      count = self.all.count
      begin 
        number = rand(count)
      end while (number == user_id || number == 0)
      return number
    end
  end
end