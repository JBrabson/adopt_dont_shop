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
    @application = Application.create(application_params)
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :status)
  end
end
