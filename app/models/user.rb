class User < ActiveRecord::Base
  rolify
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         # , password_length: 4..30
  
  has_one :profile, dependent: :destroy  
  has_many :projects, dependent: :destroy
  has_many :tokens, dependent: :destroy

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
  end

  def after_password_reset
    self.clear_reset_password_token unless self.reset_password_token.nil? and self.reset_password_sent_at.nil?
  end

  def token(user_id)
    tokens = Token.find_by_user_id(user_id) 

    unless tokens.nil?
      if !tokens.before_expired?
        tokens.set_expiration
        tokens.save  
      end
    else
      tokens = Token.create(user_id: user_id)
      tokens.set_expiration
      tokens.save
    end
    return tokens
    # return false if !signed_tokens || !signed_tokens.before_expired?
    # return !self.find(signed_tokens.user_id).nil?
  end

  def self.token_expired?(token)
    tokens = Token.find_by_token(token)
    return false if !tokens || !tokens.before_expired?
  end

  # private
  #  def api_key
  #     @api_key ||= ApiKey.find_by_user_id(self.id)
  #   end

end
