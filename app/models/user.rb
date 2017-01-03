class User < ActiveRecord::Base
  rolify
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # , password_length: 4..30
  
  has_one :profile, dependent: :destroy  
  has_many :projects, dependent: :destroy

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end

  def after_password_reset
    self.clear_reset_password_token unless self.reset_password_token.nil? and self.reset_password_sent_at.nil?
  end
end
