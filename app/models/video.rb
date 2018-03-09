class Video < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :video_group
  has_attached_file :video, styles: {
        :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10}
    }, :processors => [:transcoder]
  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
