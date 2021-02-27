require 'swagger_helper'

RSpec.describe 'Customers', type: :request do
	describe 'Customers API Get' do
	  path '/api/v1/customers' do
		get 'Retrieves all customers' do
		  consumes 'application/json'
		  produces 'application/json'
		  tags 'Customers'
		  parameter name: :page, in: :query, type: :number, description: '', required: false
		  parameter name: :per_page, in: :query, type: :number, description: '', required: false
		  response '200', :success do
			schema type: :object,
				properties: {
					data: {
						type: :array,
							items: {
								type: :object,
									properties: {
										id: { type: :integer },
										customerName: { type: :string },
										companyName: { type: :string },
										serviceType: { type: :string },
										typeCustomer: { type: :string },
										cpfCnpj: { type: :string },
										image: { type: :string },
										created_at: { type: :string },
										updated_at: { type: :string },
										contacts: {
											type: :array,
												items: {
													type: :object,
														properties: {
															id: { type: :integer },
															name: { type: :string },
															email: { type: :string },
															phone: { type: :string },
															customer_id: { type: :integer }
														}
												}
										},
										facilities: {
											type: :array,
												items: {
													type: :object,
														properties: {
															id: { type: :integer },
															number: { type: :number },
															zipCode: { type: :number },
															address: { type: :string },
															state: { type: :string },
															country: { type: :string },
															city: { type: :string },
															customer_id: { type: :integer }
														}
												}
										}
									}
							}
					}
				} 
				run_test!

				let!(:customers) do
					3.times do
					  create(:customers)
					end
				end

				response(200, description: 'Return all the available customers') do
					it 'Return 3 customers' do
					  body = JSON(response.body)
					  expect(body.count).to eq(3)
					end
				  end
			end
	
			response '404', 'Customers not found' do
				run_test!
			end
		end
	  end
	end

	describe 'Customers API Get id' do
		path '/api/v1/customers/{id}' do
		  get 'Retrieve one Customer' do
			consumes 'application/json'
			produces 'application/json'
			tags 'Customers'
			parameter name: :id, in: :path, type: :integer, description: '', required: true
			response '200', :success do
			  schema type: :object,
				  properties: {
					  data: {
						  type: :array,
							  items: {
								  type: :object,
									  properties: {
											id: { type: :integer },
											customerName: { type: :string },
											companyName: { type: :string },
											serviceType: { type: :string },
											typeCustomer: { type: :string },
											cpfCnpj: { type: :string },
											image: { type: :string },
											created_at: { type: :string },
											updated_at: { type: :string },
											contacts: {
											  type: :array,
												  items: {
													  type: :object,
														  properties: {
															  id: { type: :integer },
															  name: { type: :string },
															  email: { type: :string },
															  phone: { type: :string },
															  customer_id: { type: :integer }
														  }
												  }
										  },
										  facilities: {
											  type: :array,
												  items: {
													  type: :object,
														  properties: {
															  id: { type: :integer },
															  number: { type: :number },
															  zipCode: { type: :number },
															  address: { type: :string },
															  state: { type: :string },
															  country: { type: :string },
															  city: { type: :string },
															  customer_id: { type: :integer }
														  }
												  }
										  }
									  }
							  }
					  }
				  } 
				  run_test!
  
				  let!(:customers) do
					  1.times do
						create(:customers)
					  end
				  end
  
					response(200, description: 'Return one customer') do
						it 'Return one customers' do
						body = JSON(response.body)
						expect(body.count).to eq(3)
						end
					end
			  end
	  
			  response '404', 'Customers not found' do
				  run_test!
			  end
		  end
		end
	end

	describe 'Create a Customer' do 
		path '/api/v1/customers' do
			post 'Create new Cutomer' do
				tags 'Customers'
				consumes 'application/json'
				produces 'application/json'
				parameter name: :customer, in: :body,
					schema: {
						type: :object,
							properties: {
										customerName: { type: :string },
										companyName: { type: :string },
										serviceType: { type: :string },
										typeCustomer: { type: :string },
										cpfCnpj: { type: :string },
										image: { type: :string },
									},
									required: %w[customerName companyName serviceType typeCustomer cpfCnpj]
					}
		  
					response '201', 'Customer Created' do
						let!(:customer) { create(:customer) }
						run_test!
					end
			
					response '422', :invalid_request do
						let!(:customer) { create(:customer) }
						run_test!
					end
			end
		end
	end

	describe "Update a customer" do
		path '/api/v1/customers/{id}' do
			patch 'Update customers by id' do
				tags 'Customers'
				consumes 'application/json'
				produces 'application/json'
				parameter name: :id, in: :path, type: :integer
				parameter name: :customer, in: :body, 
				schema: {
					type: :object,
					properties: {
							customerName: { type: :string },
							companyName: { type: :string },
							serviceType: { type: :string },
							typeCustomer: { type: :string },
							cpfCnpj: { type: :string },
							image: { type: :string },
						}
				}
				response '200', :success do
					let!(:customer) { create(:customer) }
					run_test!
				end
		
				response '404', :not_found do
					let!(:customer) { create(:customer) }
					let(:customer) { { customerName: 'Title', companyName: 'Body' } }
					let!(:id) { 'invalid' }
					run_test!
				end
			end
		end
	end

	describe "Delete a customer" do
		path '/api/v1/customers/{id}' do
			delete 'Delete customers by id' do
				tags 'Customers'
				consumes 'application/json'
				produces 'application/json'
				parameter name: :id, in: :path, type: :integer

				response '204', :no_content do
					let!(:customer) { create(:customer) }
					let!(:id) { create(:customer, customer: customer).id }
					run_test!
				end

				response '404', :not_found do
					let!(:customer) { create(:customer) }
					let!(:id) { 'invalid' }
					run_test!
				end
			end
		end
	end
end