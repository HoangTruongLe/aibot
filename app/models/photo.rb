class Photo < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :photo_group
  has_attached_file :photo, path: "app/images/:id/:filename"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  attr_accessor :image_url

  def image_url
    photo.expiring_url
  end
end
