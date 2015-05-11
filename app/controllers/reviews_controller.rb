class ReviewsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter

  def new
    @review = Review.new
  end

  def create
    if params[:review][:professor_netid] == ""
      session[:student_class] = params[:review][:student_class]
        session[:professor_netid] = params[:review][:professor_netid]
        session[:relationship] = params[:review][:relationship]
        session[:availability] = params[:review][:availability]
        session[:responsiveness] = params[:review][:responsiveness]
        session[:knowledge] = params[:review][:knowledge]
        session[:friendliness] = params[:review][:friendliness]
        session[:helpfulness] = params[:review][:helpfulness]
        session[:comments] = params[:review][:comments]
      flash[:danger] = "All fields are required!"
      redirect_to new_review_path
    else
      @professor = Professor.find_by(netid: params[:review][:professor_netid].downcase)
      if @professor
        session[:new_professor_netid] = nil
        @review = @professor.reviews.build(review_params)
        if @review.save
          flash[:success] = "Review created!"
          redirect_to @professor
        else
          render 'new'
        end
      else
        session[:student_class] = params[:review][:student_class]
        session[:professor_netid] = params[:review][:professor_netid]
        session[:relationship] = params[:review][:relationship]
        session[:availability] = params[:review][:availability]
        session[:responsiveness] = params[:review][:responsiveness]
        session[:knowledge] = params[:review][:knowledge]
        session[:friendliness] = params[:review][:friendliness]
        session[:helpfulness] = params[:review][:helpfulness]
        session[:comments] = params[:review][:comments]
        flash[:danger] = render_to_string(:partial => "shared/new_professor_message")
        redirect_to new_review_path
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
