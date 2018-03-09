namespace :message do
  task update_message_answer_has_next_message: :environment do
    AnswerHasNextMessageJob.perform_now
  end
end
