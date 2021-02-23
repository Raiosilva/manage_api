class Api::V1::CustomersController < Api::V1::ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all.paginate(page: params[:page], per_page: 10)

    if @customers.length >= 1
      render json: {
                    status: 'SUCCESS', 
                    message: 'Customers loaded successfully', 
                    data: @customers, 
                    per_page: per_page, 
                    total_data: @customers.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: @customers.total_pages
                  }
    else
      per_page = 0
      total_pages = 0
      render json: {
                    status: 'SUCCESS', 
                    message: 'There are no customers registered on this page', 
                    data: [], 
                    per_page: per_page, 
                    total_data: @customers.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: total_pages
                  }
    end
  end

  # GET /customers/1
  def show
    if @customer
      render json: @customer
    else 
      render json: {
                    error: 'Error 404 Not Found', 
                    message: 'Customer Not Found', 
                    data: {}
                  }, status: :unprocessable_entity
    end
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id]) rescue nil
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:customerName, :companyName, :serviceType, :typeCustomer, :cpfCnpj, :image)
    end
end
