class Api::V1::CustomersController < Api::V1::ApplicationController
  before_action :set_customer, only: [:search, :show, :update, :destroy]


  def search
    search = params[:customerName]
    @customers = Customer.where('"customers"."customerName" ILIKE LOWER(?)', "%#{search}%").limit(100)
    @customers.paginate(page: params[:page], per_page: 10)

    if @customers.length >= 1
      per_page = 10
      total_pages = @customers.length > 10 ? @customers.total_pages : 0
      puts @customers.length > 10 ? @customers.total_pages : 0.inspect
      render json: { 
                    status: 'SUCCESS', 
                    message: 'Customers loaded successfully',
                    data: @customers,
                    per_page: per_page, 
                    total_data: @customers.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: total_pages
                  }, 
                  include: [
                    { contacts: { except: [:customer_id, :created_at, :updated_at] }}, 
                    { facilities: {except: [:customer_id, :created_at, :updated_at] }}
                  ]
    else
      per_page = 0
      render json: {
                    status: 'SUCCESS', 
                    message: 'Records not found', 
                    data: [], 
                    per_page: per_page, 
                    total_data: @customers.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: @customers.length > 10 ? @customers.total_pages : 0
                  }
    end
  end

  # GET /customers
  def index
    @customers = Customer.all.paginate(page: params[:page], per_page: 10)

    puts 'PAGE'
    puts params[:page].inspect

    if @customers.length >= 1
      per_page = 10
      render json: {
                    status: 'SUCCESS', 
                    message: 'Customers loaded successfully', 
                    data: @customers, 
                    per_page: per_page, 
                    total_data: @customers.count,
                    current_page: params[:page].to_i ? params[:page].to_i : 0,
                    total_pages: @customers.length > 10 ? @customers.total_pages : 0
                  }, 
                  include: [
                    { contacts: { except: [:customer_id, :created_at, :updated_at] }}, 
                    { facilities: {except: [:customer_id, :created_at, :updated_at] }}
                  ]
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
      render json: {
                    status: 'SUCCESS', 
                    message: 'Customers loaded successfully', 
                    data: @customer,
                  }, 
                  include: [
                    { contacts: { except: [:customer_id, :created_at, :updated_at] }}, 
                    { facilities: {except: [:customer_id, :created_at, :updated_at] }}
                  ]
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
    if @customer.valid?
      render json: {
                    error: 'Register Duplicated', 
                    message: 'Customer already exists', 
                    data: @customer
                  }, status: :unprocessable_entity
    else  
      @customer = Customer.new(customer_params)

      if @customer.save
        render json: @customer, status: :created, location: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
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
