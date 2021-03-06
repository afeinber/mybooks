class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    unless params[:only_follow]
      @users = User.search(params[:search_user])
      if !@users.present? && params[:search_user].present?

        flash[:alert] = "Your search did not match any users. Please try again."
      end
    else
      @users = current_user.followees
    end
  end

  def show
    @user = User.find(params[:id])
    @comment = Comment.new
    @user_read_books = @user.books_with_recommendations(is_read: true)
    @user_unread_books = @user.books_with_recommendations(is_read: false)
  end
end
