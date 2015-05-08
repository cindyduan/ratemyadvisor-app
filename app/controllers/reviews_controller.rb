class ReviewsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter

  def new
    @review = Review.new
  end

  def create
    if params[:review][:professor_netid] == ""
      flash[:danger] = "Professor NetID cannot be blank!"
      redirect_to new_review_path
    else
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
        flash[:danger] = "Advisor does not exist! Please add him/her to the database!"
        redirect_to new_professor_path
      end  
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
