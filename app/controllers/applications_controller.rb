class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:adopt] && !@application.pets.include?(Pet.find(params[:adopt]))
      @adopted_pets = @application.adopted_pets(Pet.find(params[:adopt]))

    elsif params[:search]
      @pet_search = Pet.partial_search(params[:search])

    elsif @application.status == "Pending"
      @pets = @application.pets
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      #why are no conditions specified here for nil
      flash[:notice] = "ERROR: Missing required information."
      render :new
    end
  end

  def update
    application = Application.find(params[:id])
    application.status = params[:status]
    application.home_bio = params[:reason]
    application.save!
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :home_bio, :status)
  end
end
