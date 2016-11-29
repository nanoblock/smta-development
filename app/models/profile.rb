class Profile < ActiveRecord::Base
  belongs_to :users
    
  Paperclip.interpolates :id_sha1  do |attachment, style|
    Digest::SHA1.hexdigest(attachment.instance.id.to_s)
  end

  has_attached_file :avatar, 
  styles: { original: ["80x80!", :png], thumb: ["80x80!", :png] }, #, thumb: "400x650!"
  path: ":rails_root/public/images/:id_sha1/:style.:extension",
  # public/images/:id_sha1/:style.:extension", #upload server image path,
  default_url: "profile/avatar_logo.svg",
  url: "/images/:id_sha1/:style.:extension",
  less_than: 3.megabytes

end
