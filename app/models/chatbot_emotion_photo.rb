class ChatbotEmotionPhoto < ApplicationRecord
  MAX_TIME = 604800
  belongs_to :chatbot
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                            path: "app/images/:id/:filename",
                            default_url: ->(attachment) { ActionController::Base.helpers.asset_path("missing.png") }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  attr_accessor :image_url

  def image_url
    avatar.expiring_url(MAX_TIME, :thumb)
  end
end
