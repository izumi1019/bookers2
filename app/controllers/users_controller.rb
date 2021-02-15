class UsersController < ApplicationController
  
   def show
    @book = Book.new
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
  
   private
    def book_params
      params.require(:book).permit(:title, :body)
    end
  
end


