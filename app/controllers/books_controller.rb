class BooksController < ApplicationController
  before_action :authenticate_user!
 
   def show
    @book = Book.new
    @user = User.find(params[:id])
    @book_detail = Book.find(params[:id])
   end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(current_user), notice: "Book was successfully created."
    else
      @books = Book.where(user: current_user)
      render "/users/show"
      @book = Book.new(book_params)
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
       redirect_to user_path(current_user)
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to "/users/show", notice: "Book was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    @book_detail = Book.find(params[:id])
    if @book_detail.destroy
      redirect_to "/users/show"
    else
      render "/books/show"
    end
  end
  
   private
    def book_params
      params.require(:book).permit(:title, :body)
    end

end


