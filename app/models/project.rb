class Project < ActiveRecord::Base
  belongs_to :users
  has_many :images, dependent: :destroy

end
