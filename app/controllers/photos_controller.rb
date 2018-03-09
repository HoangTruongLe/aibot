class PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      add_updated_user(photo_params[:message_id])
      render json: { message: 'success', uploadId: @photo.id }
    else
      render json: { message: @photo.errors.full_message , status: :unprocessable_entity }
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      add_updated_user(@photo.message_id)
      render json: { message: "the file has been deleted from server" }
    else
      render json: { message: @photo.errors.full_message }
    end
  end

  def destroy_photo_group
    @photos = Photo.where(message_id: params[:id], photo_group_id: params[:content_id])
    pg = PhotoGroup.where(photo_group_id: params[:content_id])
    @content_id =  params[:content_id]
    respond_to do |format|
      add_updated_user(@photos.first.message_id)
      if @photos.destroy_all && pg.destroy_all
        format.html
        format.js
      end
    end
  end

  def message_photos
    @photos = Photo.where(message_id: params[:message_id], photo_group_id: params[:content_group_id])
    if @photos.count > 0
      render json: { photos: @photos.map { |e| {id: e.id,
        photo_file_name: e.photo_file_name,
        photo_content_type: e.photo_content_type,
        photo_file_size: e.photo_file_size,
        image_url: e.image_url}  }}
    else
      render json: 'no photo'
    end
  end

  def message_photo_group
    @message_photo_group = PhotoGroup.new(message_id: params[:message_id])
    if @message_photo_group.save
      render partial: 'messages/photo', locals: { content_id: @message_photo_group.id, message_id: params[:message_id],
                          new_record: true, msg_content: @message_photo_group.message_content, photos:nil, preview: false }
    else
      render json: { message: @message_photo_group.errors.full_message }
    end
  end

  private

  def photo_params
	   params.require(:message_photo).permit(:photo).
     merge(photo_group_id: params[:content_group_id]).
     merge(message_id: params[:message_id]) if params[:message_photo]
  end
end
