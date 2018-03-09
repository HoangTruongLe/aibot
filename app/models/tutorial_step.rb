class TutorialStep < ApplicationRecord
  belongs_to :tutorial
  has_attached_file :image, path: "app/images/:id/:filename",
                    default_url: ->(attachment) { ActionController::Base.helpers.asset_path("missing_tutorial_image.png") }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, length: { maximum: 100 }
  validates :content, length: { maximum: 200 }
  validates :button_wording, length: { maximum: 100 }

  attr_accessor :image_url

  def image_url
    image.expiring_url
  end
end
