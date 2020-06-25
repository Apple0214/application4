class FollowersController < ApplicationController

  def index
  	@users = current_user.follower
  end
end
