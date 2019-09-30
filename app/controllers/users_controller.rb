class UsersController < ApplicationController
	before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
    @post_images = @user.books.page(params[:page]).reverse_order
  	@book = Book.new
  end
  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @users = User.all

  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice:"successfully"
    else 
      flash[:notice] = "error"
      render action: :edit

    
  	end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
     
      @user = User.find(current_user.id)
      
      @books = Book.all
      render :index
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private 
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end 
end
