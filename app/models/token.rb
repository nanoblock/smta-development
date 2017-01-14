class Token < ActiveRecord::Base
  before_create :generate_token, :set_expiration
  belongs_to :user
 
  def before_expired?
    # DateTime.now < self.expires_at
    return true;
  end
 
  def set_expiration
    self.expires_at = DateTime.now + 1
  end
 
  private

    def generate_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?(token: token)
    end

end
