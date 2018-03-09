class AnswerHasNextMessageJob < ApplicationJob
  queue_as :default

  def perform
    Message.published.each do |mess|
      mess.questions.each do |question|
        question.answers.each do |answer|
          if Message.joins(:keyword).exists?(["keywords.id IN (?)", answer.keyword])
            answer.has_next_msg = true
          else
            answer.has_next_msg = false
          end
          answer.save
        end
      end
    end
  end
end
