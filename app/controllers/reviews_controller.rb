class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @professor = Professor.find_by(netid: params[:review][:professor_netid].downcase)
    if @professor
      @review = @professor.reviews.build(review_params)
      if @review.save
        flash[:success] = "Review created!"
        redirect_to @professor
      else
        render 'new'
      end
    else
      flash[:danger] = "This advisor does not yet exist in our system! Please add him/her before posting your review!"
      redirect_to new_professor_path
    end  
  end

  def destroy
    review = Review.find(params[:id])
    @professor = review.professor
    review.destroy
    flash[:success] = "Review deleted"
    redirect_to @professor
  end

  private

    def review_params
      params.require(:review).permit(:student_netid, :student_class,
                                     :professor_netid, :relationship,
                                     :availability, :responsiveness, :knowledge,
                                     :organization, :friendliness, :helpfulness,
                                     :comments)
    end

end
