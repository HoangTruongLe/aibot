class TutorialsController < ApplicationController
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy, :tutorial_steps, :destroy]

  def new
    @tutorial = Tutorial.find_or_initialize_by(chatbot_id: params[:chatbot_id])
    @tutorial.tutorial_steps = new_tutorial_steps if @tutorial.new_record?
    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to edit_tutorial_path(@tutorial) }
      end
    end
  end

  def show
    add_breadcrumb t('tutorials.management')
    add_breadcrumb @tutorial.id
    @tutorial_steps = tutorial_steps
  end

  def edit
    add_breadcrumb t('tutorials.management')
    add_breadcrumb @tutorial.id
    add_breadcrumb t('tutorials.edit')
    @tutorial_steps = tutorial_steps
  end

  def update
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        format.html { redirect_to @tutorial, notice: t('.tutorial_update_successfully') }
        format.json { render :show, status: :ok, location: @tutorial }
      else
        @tutorial_steps = tutorial_steps
        format.html { render :edit }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @tutorial.destroy
        format.html { redirect_to chatbots_path, notice: t('.destroy_tutorial_successfully') }
      end
    end
  end

  private
    def new_tutorial_steps
      tutorial_steps = []
      3.times do
        tutorial_steps << TutorialStep.new
      end
      return tutorial_steps
    end

    def tutorial_steps
      if @tutorial.tutorial_steps.count > 0
        chatbot_tutorial = @tutorial.tutorial_steps.order(:id)
      else
        chatbot_tutorial = new_tutorial_steps
      end
      return chatbot_tutorial
    end

    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    def tutorial_params
      params.require(:tutorial).permit(:id, :updated_user_id, :activity, tutorial_steps_attributes: [:id, :image, :title, :content, :button_wording]).
      merge(updated_user: current_user)
    end

    def add_tutorials_index_path
      add_breadcrumb t('tutorials.breadcrumb_title'), tutorials_path
    end
end
