class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:id])
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

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :status)
  end
end
