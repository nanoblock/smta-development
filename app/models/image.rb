class Image < ActiveRecord::Base

  belongs_to :projects
  
  has_many :ocrs, dependent: :destroy
  has_many :clickables, dependent: :destroy

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "120x180!" }, default_url: "/images/:style/missing.png"

  Paperclip.interpolates :id_sha1  do |attachment, style|
    Digest::SHA1.hexdigest(attachment.instance.id.to_s)
  end

  has_attached_file :photo, 
  styles: { original: ["400x650!", :jpeg], medium: ["400x650!", :jpeg], thumb: ["120x180!", :jpeg] }, #, thumb: "400x650!"
  path: ":rails_root/public/images/:id_sha1/:style.:extension", #upload server image path
  url: "/images/:id_sha1/:style.:extension"
  

  validates_attachment :photo, 
    presence: true, #file save check
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
    less_than: 3.megabytes

  before_post_process :rename

  def rename
    attachment_file_name = self.photo.instance_read(:file_name).to_s
    attachment_file_name = attachment_file_name.to_s.split(".").first
    self.photo.instance_write(:file_name, attachment_file_name)
  end

end
