class ProfessorsController < ApplicationController
  
  def show
    @professor = Professor.find(params[:id])
  end

  def new
    @professor = Professor.new
  end
  
  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      flash[:success] = "Advisor added!"
      redirect_to @professor
    else
      render 'new'
    end
  end

  private

    def professor_params
      params.require(:professor).permit(:first_name, :last_name, :netid,
                                   :department)
    end

end
