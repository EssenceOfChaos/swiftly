class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    if params[:search]
    @friends = current_user.friends.find(:conditions => ['name LIKE?', "%#{params[:search]}%"])
    else
      @friends = current_user.friends.all
    end

  end

  def destroy
    current_user.remove_friend(@friend)
    flash[:notice]= "Friend successfully removed"
    redirect_to friends_path

  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
