module MessageStatisticReportConcern
  def self.msg_statistic(message_id)
    stories = Story.where('? = ANY(messages_list)', message_id)
    msg_display_number = stories.sum(:display_number)
    digestion_number = stories.where("array_position(messages_list, ?) != array_length(messages_list, 1)", message_id).count
    return stories, msg_display_number, digestion_number
  end

  def self.average_stay_time message
    return 0 if message.nil? || message.message_contents.blank?
    c_statuses = ConversationStatus.all.select { |c| c.status.include? message.id }
    first_message = message.message_contents.first.content_id.to_s + "*" + message.message_contents.first.content_type
    last_message = message.message_contents.last.content_id.to_s + "*" + message.message_contents.last.content_type
    stay_time = 0
    c_statuses.each do |c_status|
      first_index = c_status.chatting.index { |s| s.include?(first_message) }
      last_index = c_status.chatting.index { |s| s.include?(last_message) }
      if first_index != nil && last_index != nil
        start_time = c_status.chatting[first_index].split('*')[2]
        last_index += 1 if c_status.chatting[last_index + 1] && c_status.chatting[last_index + 1].include?('Answer')
        end_time = c_status.chatting[last_index].split('*')[2]
        stay_time += (end_time.to_time - start_time.to_time).to_f
      end
    end
    stay_time.round
  end

  def self.average_number_messages_digest stories, msg_id
    number_messages_digest, number_messages_digest_before, number_messages_digest_after = 0, 0, 0
    stories.each do |story|
      # normal
      number_messages_digest += story.messages_list.size - 1
      # before
      number_messages_digest_before += story.messages_list.index(msg_id)
      # after
      number_after = story.messages_list.size - story.messages_list.index(msg_id) - 2
      number_after = number_after >= 0 ? number_after : 0
      number_messages_digest_after += number_after
    end
    number_messages_digest = stories.count != 0 ? (number_messages_digest.to_f / stories.count).round(2) : 0
    number_messages_digest_before = stories.count != 0 ? (number_messages_digest_before.to_f / stories.count).round(2) : 0
    number_messages_digest_after = stories.count != 0 ? (number_messages_digest_after.to_f / stories.count).round(2) : 0
    return number_messages_digest, number_messages_digest_before, number_messages_digest_after
  end

  def self.average_reach_cpc stories
    count, reach_cpc = 0, 0
    stories.each do |story|
      next if story.messages_list.size <= 1
      count += 1
      cpc = Message.find_by_id(story.messages_list[-2]).try(:keyword).try(:cpc) || 0
      reach_cpc += cpc
    end
    count == 0 ? 0 : (reach_cpc / count).round(2)
  end

  def self.conversion_tags_number message_id, conversation_statuses
    c_statuses = conversation_statuses.select { |c| c.status.include? message_id }
    conversion_tags_number = 0
    c_statuses.each do |c_status|
      number = c_status&.session_statistic&.conversion_tags
      conversion_tags_number += number.count if number
    end
    conversion_tags_number
  end
end
