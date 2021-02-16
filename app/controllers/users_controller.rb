class UsersController < ApplicationController

   def show
    @book = Book.new
    @books = Book.where(user: current_user)
   end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(current_user)
    else
      render :show
    end
  end
  
  def index
      @users = User.all
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)  
  end

  private

    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def book_params
      params.require(:book).permit(:title, :body)
    end

end


