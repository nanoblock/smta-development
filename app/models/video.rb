class Video < ActiveRecord::Base
  belongs_to :projects

  has_many :video_clickables, dependent: :destroy
end
