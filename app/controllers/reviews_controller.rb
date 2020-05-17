class ReviewsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_product, only: %i(create update)
  before_action :load_review, only: :update

  def create
    @review = @product.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t "flash.review_success"
      update_rank
    else
      flash[:fail] = t "flash.review_fail"
    end
    redirect_to @product
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "flash.review_success"
      update_rank
    else
      flash[:fail] = t "flash.review_fail"
    end
    redirect_to @product
  end

  private

  def load_product
    @product = Product.find_by(id: params[:review][:product_id])
  end

  def load_review
    @review = @product.reviews.find_by(id: params[:id])
    return if @review

    flash[:danger] = t "flash.nil_object", name: "review"
    redirect_to root_path
  end

  def update_rank
    total = Review.avg_score(@product.id).to_f
    @product.update_attribute(:rank, total.round(Settings.products.round))
  end

  def review_params
    params.require(:review).permit :score, :content
  end
end
