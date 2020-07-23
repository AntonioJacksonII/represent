class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path
  end 

  private 

  def auth_hash
    request.env['omniauth.auth']
  end
end 