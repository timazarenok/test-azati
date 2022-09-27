class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.find(current_user.id)
  end
end
