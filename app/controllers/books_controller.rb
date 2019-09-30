class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    
  	@booker = Book.find(params[:id])
  	@book = Book.new
    @user = User.find(@booker.user_id)

  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
    redirect_to books_path
    end  
  	
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path, notice:"successfully"
    else
      flash[:notice] = "error"
      render :edit
  	end
  end

  def create
  	@book = Book.new(book_params)

    @book.user_id = current_user.id
  	if @book.save
  		redirect_to book_path(@book.id), notice: "successfully"
    else
      flash[:notice] = "error"
      @books = Book.page(params[:page]).reverse_order
      @user = User.find(current_user.id)
      
     
      render :index

  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private 
  def book_params
  	params.require(:book).permit(:title, :body)
  end 

end
