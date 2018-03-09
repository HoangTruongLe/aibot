class HomeController < ApplicationController

  def index
  end

  def user_profile
    add_breadcrumb t('profile'), :profile_path
    @user = current_user
  end

  def update_user
    add_breadcrumb t('profile'), :profile_path
    @user = current_user
    respond_to do |format|
      unless params[:user][:password].empty?
        if @user.valid_password?(params[:user][:current_password])
          update_info(@user, format)
        else
          @user.errors.add(:current_password, '現在のパスワードは無効です')
          format.html { render :user_profile }
        end
      else
        update_info(@user, format)
      end
    end
  end

  private

  def update_info(user, f)
    if user.update(user_params)
      f.html { redirect_to profile_path, notice: t('.profile_update_successfully') }
    else
      f.html { render :user_profile }
      f.json { render json: user.errors, status: :unprocessable_entity }
    end
  end

  def user_params
    if params[:user][:password].empty?
      params.require(:user).permit(:name, :email)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
