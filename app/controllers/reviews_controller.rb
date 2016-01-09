class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_user,     only: [:new, :edit, :create, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to @review
    else
      render 'new'
    end
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @review
    else
      render 'edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_path
  end

  private
    def review_params
      params.require(:review).permit(:title, :text)
    end

end
