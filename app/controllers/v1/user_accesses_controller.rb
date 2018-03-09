class V1::UserAccessesController < V1::BaseController

  def user_access
    ip_address = params[:ip_address]
    user_access = UserAccess.new(user_access_params)
    if user_access.save
      render json: { message: 'success', user_access: user_access }
    else
      render json: { message: user_access.errors.full_message , status: :unprocessable_entity }
    end
  end

  private 

  def user_access_params
    params.permit(:ip_address)
  end
end
