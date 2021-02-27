class Api::V1::ContactsController < Api::V1::ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    customer_id = params[:customer_id]
    puts 'customer_id'
    puts customer_id.inspect
    @contacts = Contact.where(customer_id: "#{customer_id}").exists?

    if @contacts
      render json: {data: @contacts}
    else
      render json: { message: 'Customer not exist' }
    end

    # @contacts = Contact.all

    # render json: @contacts, include: :customer
  end

  # GET /contacts/1
  def show
    render json: @contact, include: :customer
  end

  # POST /contacts
  def create
    if @contact.valid?
      render json: {
                    error: 'Register Duplicated', 
                    message: 'Contact already exists', 
                    data: @contact
                  }, status: :unprocessable_entity
    else 
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, status: :created, location: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id]) rescue nil
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :customer_id)
    end
end
