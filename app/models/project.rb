class Project < ActiveRecord::Base
  belongs_to :users
  has_many :images, dependent: :destroy
  has_one :video, dependent: :destroy

  def type project_id
    return true if Image.find_by_project_id project_id
    return false if Video.find_by_project_id project_id

  end

end
