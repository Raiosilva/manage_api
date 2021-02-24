namespace :dev do
  desc "Config environment to development"
  task setup: :environment do

    puts "Register Customer..."
    10.times do |i|
      Customer.create!(
        customerName: Faker::Company.bs,
        companyName: Faker::Company.bs,
        serviceType: Faker::Company.industry,
        typeCustomer: Faker::Company.type,
        cpfCnpj: Faker::Number.number(digits: 14),
        image: Faker::Company.logo
      )
    end
    puts "Register Customer with success!"
  
    puts "Register Contact..."
    10.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        phone: Faker::Number.number(digits: 14),
        customer_id: Customer.all.sample
      )
    end
    puts "Register Contact success!"

    puts "Register Facility..."
    10.times do |i|
      Facility.create!(
        address: Faker::Address.street_name,
        number: Faker::Address.building_number,
        complement: Faker::Address.secondary_address,
        state: Faker::Address.state,
        country: Faker::Address.country,
        city: Faker::Address.city,
        zipCode: Faker::Address.zip_code,
        customer_id: Customer.all.sample
      )
    end
    puts "Register Facility with success!"

  end
end