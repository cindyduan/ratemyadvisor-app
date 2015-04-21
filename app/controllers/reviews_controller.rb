class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @professor = Professor.find_by(netid: params[:review][:professor_netid])

    # need to handle case where professor is not in database yet or
    # @professor is nil

    @review = @professor.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to root_url  # change this to professor's page
    else
      render 'new'
    end
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
