class BooksController < ApplicationController
  before_action :authenticate_user!
 
   def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
    @user = User.find(@book_detail.user.id)
   end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
      @user = current_user
      @books = Book.all
      @book.title = nil
      render "books/index"
       @book = Book.new
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
       redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    @book_detail = Book.find(params[:id])
    if @book_detail.destroy
      redirect_to books_path
    else
      render "/books/show"
    end
  end
  
   private
    def book_params
      params.require(:book).permit(:title, :body)
    end

end
















