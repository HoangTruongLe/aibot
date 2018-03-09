class MessageJob < ApplicationJob
  def perform(cur_message_id, new_message_id, site_id)
    @message = Message.unscoped.find_by_id_and_site_id(cur_message_id, site_id)
    @message.message_contents.order(:row_order).each do |msg_cnt|
      case msg_cnt.content_type
      when 'TextMessage'
        content = TextMessage.find_by_id(msg_cnt.content_id)
        copy_data(content, new_message_id)
      when 'Question'
        content = Question.find_by_id(msg_cnt.content_id)
        new_question = copy_data(content, new_message_id)
        copy_answer(content.id, new_question.id)
      when 'LinkCard'
        content = LinkCard.find_by_id(msg_cnt.content_id)
        copy_data(content, new_message_id)
      when 'ProductMessage'
        content = ProductMessage.find_by_id(msg_cnt.content_id)
        copy_data(content, new_message_id)
      when 'PhotoGroup'
        content = PhotoGroup.find_by_id(msg_cnt.content_id)
        new_photo_group = copy_data(content, new_message_id)
        copy_photo(new_message_id, content.id, new_photo_group.id)
      when 'VideoGroup'
        content = VideoGroup.find_by_id(msg_cnt.content_id)
        new_photo_group = copy_data(content, new_message_id)
        copy_video(new_message_id, content.id, new_photo_group.id)
      when 'Quote'
        content = Quote.find_by_id(msg_cnt.content_id)
        copy_data(content, new_message_id)
      end
    end
  end

  def copy_data(content, new_msg_id)
    new_content = content.dup
    new_content.message_id = new_msg_id
    new_content.save
    new_content
  end

  def copy_answer(cur_question_id, new_question_id)
    current_question = Question.find_by_id(cur_question_id)
    if current_question.answers.size > 0
      current_question.answers.each do |answer|
        new_ans = answer.dup
        new_ans.question_id = new_question_id
        new_ans.save
      end
    end
  end

  def copy_photo(new_msg_id, cur_photo_group_id, new_photo_group_id)
    message_photos = Photo.where(photo_group_id: cur_photo_group_id)
    if message_photos.size > 0
      message_photos.each do |photo|
        new_photo = photo.dup
        new_photo.photo_group_id = new_photo_group_id
        new_photo.message_id = new_msg_id
        new_photo.photo = photo.photo
        new_photo.save
      end
    end
  end

  def copy_video(new_msg_id, cur_video_group_id, new_video_group_id)
    message_videos = Video.where(video_group_id: cur_video_group_id)
    if message_videos.size > 0
      message_videos.each do |video|
        new_video = video.dup
        new_video.video_group_id = new_video_group_id
        new_video.message_id = new_msg_id
        new_video.video = video.video if video.video
        new_video.save
      end
    end
  end

end
