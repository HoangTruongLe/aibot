class VideosController < ApplicationController
  def create
    @video = nil
    if params[:video_type] == 'upload'
      @video = Video.new(video_params)
    else
      @video = Video.new(video: nil,
      message_id: params[:message_id],
      video_type: params[:video_type],
      youtube_url: params[:youtube_url],
      video_group_id: params[:content_group_id] )
    end
    if @video.save
      add_updated_user(params[:message_id])
      render json: { message: 'success', uploadId: @video.id }
    else
      render json: { message: @video.errors.full_message , status: :unprocessable_entity }
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      add_updated_user(@video.message_id)
      render json: { message: "the file has been deleted from server" }
    else
      render json: { message: @video.errors.full_message }
    end
  end

  def destroy_video_group
    @videos = Video.where(message_id: params[:id], video_group_id: params[:content_id])
    @content_id =  params[:content_id]
    respond_to do |format|
      add_updated_user(@videos.first.message_id)
      if @videos.destroy_all
        format.html
        format.js
      end
    end
  end

  def message_video
    @video = Video.where(message_id: params[:message_id], video_group_id: params[:content_group_id]).compact.last
    if @video
      render json: { video_id: @video.id,
        video_file_name: @video.video_file_name,
        video_content_type: @video.video_content_type,
        video_file_size: @video.video_file_size,
        video_url: @video.video.url }
    else
      render json: 'no video'
    end
  end

  def message_video_group
    @message_video_group = VideoGroup.new(message_id: params[:message_id])
    if @message_video_group.save
      render partial: 'messages/video', locals: { content_id: @message_video_group.id,
        message_id: params[:message_id],
        new_record: true,
        msg_content: @message_video_group.message_content,
        video:nil,
        preview: false }
    else
      render json: { message: @message_video_group.errors.full_message }
    end
  end

  private

  def video_params
    params.require(:message_video).permit(:video).
    merge(message_id: params[:message_id]).
    merge(video_type: params[:video_type]).
    merge(video_group_id: params[:content_group_id]).
    merge(youtube_url: params[:youtube_url]) if params[:message_video]
  end
end
