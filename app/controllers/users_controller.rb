class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    message = ''
    if user.save
      login(user)
      message, status = "User created and logged !!!", 'success'
    else

      message, status = user.errors.full_messages.join(', '), 'error'
    end

    render json: { status: status, message: message }
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
