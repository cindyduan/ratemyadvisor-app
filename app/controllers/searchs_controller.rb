class SearchsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter

  def new
  end

  def create
    @professors = Professor.all
    all_fields_empty = true
    if params[:search][:netid] != ''
      @professors = @professors.select {|professor| professor.netid.downcase == params[:search][:netid].downcase}
      all_fields_empty = false
    end
    if params[:search][:department] != ''
      @professors = @professors.select {|professor| professor.department.downcase == params[:search][:department].downcase}
      all_fields_empty = false
    end
    if params[:search][:first_name] != ''
      @professors = @professors.select {|professor| professor.first_name.downcase == params[:search][:first_name].downcase}
      all_fields_empty = false
    end
    if params[:search][:last_name] != ''
      @professors = @professors.select {|professor| professor.last_name.downcase == params[:search][:last_name].downcase}
      all_fields_empty = false
    end
    if params[:search][:min_avail] != ''
      @professors = @professors.select {|professor| professor.avg_avail >= params[:search][:min_avail].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_resp] != ''
      @professors = @professors.select {|professor| professor.avg_resp >= params[:search][:min_resp].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_know] != ''
      @professors = @professors.select {|professor| professor.avg_know >= params[:search][:min_know].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_org] != ''
      @professors = @professors.select {|professor| professor.avg_org >= params[:search][:min_org].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_friend] != ''
      @professors = @professors.select {|professor| professor.avg_friend >= params[:search][:min_friend].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_help] != ''
      @professors = @professors.select {|professor| professor.avg_help >= params[:search][:min_help].to_i}
      all_fields_empty = false
    end
    if params[:search][:min_rev] != ''
      @professors = @professors.select {|professor| professor.num_rev >= params[:search][:min_rev].to_i}
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
      render 'index'
    end
  end

  def index
  end

end
