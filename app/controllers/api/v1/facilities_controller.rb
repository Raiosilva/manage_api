class Api::V1::FacilitiesController < Api::V1::ApplicationController
  before_action :set_facility, only: [:show, :update, :destroy]

  # GET /facilities
  def index
    @facilities = Facility.all.paginate(page: params[:page], per_page: 10)

    if @facilities.length >= 1
      per_page = 10
      render json: { 
                    status: 'SUCCESS', 
                    message: 'There are no facilities registered on this page',
                    data: @facilities,
                    per_page: per_page, 
                    total_data: @facilities.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: @facilities.length > 10 ? @facilities.total_pages : 0
                  }, include: :customer
    else 
      per_page = 0
      render json: { 
                    status: 'SUCCESS', 
                    message: 'There are no facilities registered on this page',
                    data: @facilities,
                    per_page: per_page, 
                    total_data: @facilities.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages:  @facilities.length > 10 ? @facilities.total_pages : 0 
                  }, include: :customer
    end
  end

  # GET /facilities/1
  def show
    if @facility
      render json: {  
                    status: 'SUCCESS', 
                    message: 'Facility loaded successfully',
                    data: @facility 
                  }, include: :customer
    else 
      render json: {
                    error: 'Error 404 Not Found', 
                    message: 'Facility Not Found', 
                    data: {}
                  }, status: :unprocessable_entity
    end
  end

  # POST /facilities
  def create
    if @facility.valid?
      render json: {
                    error: 'Register Duplicated', 
                    message: 'Facility already exists', 
                    data: @facility
                  }, status: :unprocessable_entity

    else
      @facility = Facility.new(facility_params)

      if @facility.save
        render json: @facility, status: :created, location: @facility
      else
        render json: @facility.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /facilities/1
  def update
    if @facility.update(facility_params)
      render json: @facility
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  # DELETE /facilities/1
  def destroy
    @facility.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id]) rescue nil
    end

    # Only allow a trusted parameter "white list" through.
    def facility_params
      params.require(:facility).permit(:address, :number, :complement, :state, :country, :city, :zipCode, :customer_id)
    end
end
