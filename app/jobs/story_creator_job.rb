class StoryCreatorJob < ApplicationJob
  queue_as :default

  def perform(*args)
  	jobs = ConversationStatus.unscoped.job_pending
  	jobs.each do |job|
      story = find_story_exist(job.status)
      session = SessionStatistic.unscoped { job.session_statistic }
      if story
        # update display_number story
        story.increment(:display_number)
        # calculate average staying time
        story.average_staying_time = find_avg_stay_time(story)
        # increment click closing of story
        story.increment(:click_closing, job.click_closing)
        story.save
      else
        # insert_story
        first_message = Message.unscoped.find_by_id(job.status.first)
        last_message = Message.unscoped.find_by_id(job.status.last)
        Story.unscoped.create!(start_keyword_id: first_message.try(:keyword_id),
                               end_keyword_id: last_message.try(:keyword_id),
                               display_number: 1,
                               messages_list: job.status,
                               average_staying_time: staying_time(session),
                               site_id: first_message.site_id)
      end
      job.update(story_job: true)
  	end
  end

  private

  def find_story_exist job_status
    story = Story.unscoped.all.detect { |s| s.messages_list == job_status }
    story || false
  end

  def staying_time(session)
    session.end_time - session.start_time
  end

  def find_avg_stay_time story
    conversations = ConversationStatus.unscoped.all.select { |c| c.status == story.messages_list }
    avg_stay_time = 0
    unless conversations.blank?
      staying_time = 0
      conversations.each do |c|
        session = SessionStatistic.unscoped { c.session_statistic }
        staying_time += staying_time(session)
      end
      avg_stay_time = staying_time / conversations.size
    end
    avg_stay_time
  end
end
