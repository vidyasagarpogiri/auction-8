class User < ActiveRecord::Base

  after_initialize :ensure_session_token

  validates :username, presence: true, uniqueness: true

  has_many :bids

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  

end
