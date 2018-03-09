class Master::TagsController < Master::MasterController
  before_action :set_tag

  def index
    add_breadcrumb t('tag_title'), :master_tags_path
    @q = Tag.ransack(params[:q])
    @tags = @q.result.page(params[:page]).order(:id)
    @lasted_tags = Tag.all.reorder(updated_at: :desc).first
    @lasted_update_user = @lasted_tags.try(:updated_user).try(:name)
    @lasted_update_time = @lasted_tags.try(:updated_at)
  end

  def new
    @tag = Tag.new
    render 'new', format: :js
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.updated_user = current_user
    if @tag.save
      render js: "window.location.reload('#{master_tags_path}')"
      flash[:notice] = t('.tag_create_successfully')
      return
    end
    render 'form', format: :js
  end

  def edit
    render 'edit', format: :js
  end

  def update
    if @tag.update_attributes(tag_params)
      @tag.updated_user = current_user
      @tag.save
      render js: "window.location.reload('#{request.path}')"
      flash[:notice] = t('.tag_update_successfully')
      return
    end

    render 'form', format: :js
  end

  def destroy
    respond_to do |format|
      if @tag.destroy
        format.js
      else
        format.js
      end
    end
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :activity)
  end
end
