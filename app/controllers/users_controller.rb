class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show, :destroy]
  before_action :authenticate_admin
  before_action :add_user_index_path

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(:id).page(params[:page])
  end

  def edit
    add_breadcrumb @user.id
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_path, notice: t('.destroy_user_successfully') }
      else
        format.html { render :show }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    add_breadcrumb @user.id
  end

  def new
    @user = User.new
    @user.add_role(:manager)
  end

  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true
    raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
    @user.reset_password_token = hashed_token
    @user.reset_password_sent_at = Time.now.utc
    respond_to do |format|
      if @user.save
        ChatbotMailer.set_password(@user, raw_token).deliver
        format.html { redirect_to @user, notice: t('.create_user_successfully') }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: t('.update_user_successfully') }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    if params[:user][:password] && params[:user][:password].empty?
      params.require(:user).permit(:name, :email, :activity, :site_ids => [], role_ids: [])
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :activity, :site_ids => [], role_ids: [])
    end
  end

  def add_user_index_path
    add_breadcrumb t('.user_management'), users_path
  end

end
