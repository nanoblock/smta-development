class Profile < ActiveRecord::Base
  belongs_to :users
  
  validates_attachment :avatar, 
    presence: true, #file save check,
    default_url: "/images/:style/missing.png",
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
    less_than: 3.megabytes

  Paperclip.interpolates :id_sha1  do |attachment, style|
    Digest::SHA1.hexdigest(attachment.instance.id.to_s)
  end

  has_attached_file :avatar, 
  styles: { original: ["400x650!", :jpeg], medium: ["400x650!", :jpeg], thumb: ["120x180!", :jpeg] }, #, thumb: "400x650!"
  path: ":rails_root/public/images/:id_sha1/:style.:extension", #upload server image path
  url: "/images/:id_sha1/:style.:extension"
end
