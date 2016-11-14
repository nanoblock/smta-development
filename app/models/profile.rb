class Profile < ActiveRecord::Base
  has_attached_file :avatar, 
  styles: { original: ["80x80!", :png], thumb: ["80x80!"], :png }, default_url: "/images/avatar/:style/missing.png",
  path: ":rails_root/public/images/avatar/:id_sha1/:style.:extension",
  url: "/images/avatar/:id_sha1/:style.:extension"

  Paperclip.interpolates :id_sha1  do |attachment, style|
    Digest::SHA1.hexdigest(attachment.instance.id.to_s)
  end 
  
  validates_attachment :avatar, 
    presence: true, #file save check
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] },
    less_than: 3.megabytes

end
