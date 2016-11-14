class User < ActiveRecord::Base
  rolify
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # , password_length: 4..30
  
  has_one :profile, dependent: :destroy  
  has_many :projects, dependent: :destroy
end
