class SearchsController < ApplicationController
  def new
  end

  def create
    @professors = Professor.all
    all_fields_empty = true
    if params[:search][:netid] != ''
      @professors = @professors.select {|professor| professor.netid == params[:search][:netid]}
      all_fields_empty = false
    end
    if params[:search][:department] != ''
      @professors = @professors.select {|professor| professor.department == params[:search][:department]}
      all_fields_empty = false
    end
    if params[:search][:first_name] != ''
      @professors = @professors.select {|professor| professor.first_name == params[:search][:first_name]}
      all_fields_empty = false
    end
    if params[:search][:last_name] != ''
      @professors = @professors.select {|professor| professor.last_name == params[:search][:last_name]}
      all_fields_empty = false
    end

    if all_fields_empty
      flash[:danger] = 'Must fill in at least one criteria!'
      redirect_to find_url
      return
    end

    if @professors.count >= 1
      render 'index'  # try redirect_to if render doesn't work
    else
      flash.now[:danger] = 'No professors match your criteria!'
      render 'new'
    end
  end

  def index
  end

end
