class UsersController < ApplicationController
  def sign_up
    result = User::Operation::SignUp.({params: {user: sign_up_params[:user]}})
    if result.success?
      render json:({data: {auth_token: result[:token]},
                    message: "User created!"})
    else
      render json:({data: {}, message: result[:error]})
    end
  end

  def sign_in
    result = User::Operation::SignIn.({params: {
                            email: sign_in_params[:email],
                            password: sign_in_params[:password]}})
    if result.success?
      render json: ({data: {auth_token: result[:token]}, message: "Signed In"})
    else
      render json:({data: {}, message: result[:error]})
    end
  end

  private

  def sign_up_params
    params.permit(user: [:email, :password, :name, :mobile_number])
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end