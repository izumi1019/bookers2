class UsersController < ApplicationController
  before_action :authenticate_user!
  
   def show
    @book = Book.new
     @user = User.find(params[:id])
    @books = Book.where(user: @user)
   end


  
  def index
      @users = User.all
      @user = current_user
      @book = Book.new
  end
  
  def edit
      @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
       redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(current_user), notice: "User was successfully updated."
    else
      render :edit
    end
  end

  private

    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def book_params
      params.require(:book).permit(:title, :body)
    end
    
   
end



