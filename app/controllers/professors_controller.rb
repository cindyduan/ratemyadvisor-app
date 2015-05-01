class ProfessorsController < ApplicationController
  
  def show
    @professor = Professor.find(params[:id])
    @reviews = @professor.reviews.paginate(page: params[:page])
  end

  def new
    @professor = Professor.new
  end
  
  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      flash[:success] = "Advisor added!"
      downcaseNetid = @professor.netid.downcase
      @professor.update_attribute(:netid, downcaseNetid)
      capitalizeFirstName = @professor.first_name.downcase.capitalize
      @professor.update_attribute(:first_name, capitalizeFirstName)
      capitalizeLastName = @professor.last_name.downcase.capitalize
      @professor.update_attribute(:last_name, capitalizeLastName)
      fullName = @professor.first_name + " " + @professor.last_name
      @professor.update_attribute(:full_name, fullName)
      redirect_to @professor
    else
      render 'new'
    end
  end

  def index
    if params[:query].present?
      # split query into 4 fields
      search_strings = params[:query].split
      if search_strings.length == 4
        @professors = Professor.search(search_strings[0], 
                                       fields: [:first_name],
                                       page: params[:page])
        @professors = @professors.select { |professor| professor.last_name.downcase == search_strings[1].downcase }
        @professors = @professors.select { |professor| professor.netid.downcase == search_strings[2].downcase }
        @professors = @professors.select { |professor| professor.department.downcase == search_strings[3].downcase }
      elsif search_strings.length == 2
        @professors = Professor.search(search_strings[0], 
                                       fields: [:first_name],
                                       page: params[:page])
        @professors = @professors.select { |professor| professor.last_name.downcase == search_strings[1].downcase }
      else
        @professors = Professor.search(params[:query],
                                       fields: [:first_name, :last_name, :netid, :department],
                                       page: params[:page])
      end
      if @professors.length == 0
        @professors = Professor.search(params[:query],
                                       fields: [:first_name, :last_name, :netid, :department],
                                       page: params[:page])
      end
    else
      @professors = nil
    end
  end

  def autocomplete
    render json: Professor.search(params[:query],
                 autocomplete: true,
                 fields: [:first_name, :last_name, :netid, :department, :full_name],
                 limit: 10).map { |professor|
                   professor.first_name + " " + professor.last_name + " " + professor.netid + " " + professor.department
                 }
  end


  private

    def professor_params
      params.require(:professor).permit(:first_name, :last_name, :netid,
                                   :department)
    end

end
