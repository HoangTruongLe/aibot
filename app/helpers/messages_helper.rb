module MessagesHelper
  def answers_by_question(question)
    question.answers.map(&:content).join("<br>")
  end

  def has_next_message(msg_id)
    Message.has_next_message(msg_id)
  end
end
