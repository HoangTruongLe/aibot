class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :messages_report]
  def index
    add_breadcrumb 'ストーリー管理'
    @q = Story.ransack(params[:q])
    @stories = @q.result.includes(:start_keyword, :end_keyword).order(:id).page(params[:page])
  end

  def show
    add_breadcrumb 'ストーリー管理', stories_path
    add_breadcrumb @story.id
    @messages = Message.where('messages.id IN (?)', @story.messages_list)
  end

  def story_report
    respond_to do |format|
      format.csv { send_data Story.to_csv,
                              filename: "story-report-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end

  def messages_report
    @messages_report = @story.messages_csv_report
    respond_to do |format|
      format.csv { send_data @messages_report,
                            filename: "messages-story-#{@story.id}-report-#{Date.today}.csv",
                            type: 'text/csv; charset=shift_jis' }
    end
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end
end
