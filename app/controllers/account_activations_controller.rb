class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    return redirect if !@user || @user.activated? || !@user.authenticated?(:activation, params[:id])
    activate_and_login(@user)
  end

  def activate_and_login(user)
    user.activate
    log_in user
    flash[:success] = 'Account activated!'
    redirect_to user
  end

  def redirect
    flash[:danger] = 'Invalid activation link'
    redirect_to root_url
  end
end
