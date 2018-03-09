class MessageUpdateAnswerJob < ApplicationJob
  queue_as :default

  def perform(keyword_id)
    Answer.where('? = ANY(keyword)', keyword_id.to_s).update_all(has_next_msg: true)
  end
end
