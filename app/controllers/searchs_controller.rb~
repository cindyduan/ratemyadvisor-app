class SearchsController < ApplicationController
  def new
  end

  def create
    # only searching with department for now for simplicity
    @professors = Professor.where("department = ?", params[:search][:department])
    if @professors
      render 'index'  # try redirect_to if render doesn't work
    else
      flash.now[:danger] = 'No professors match your criteria!'
      render 'new'
    end
  end

  def index
    # need to add something here if search results doesn't work
    # need to pass params from create if that's the case
  end

end
