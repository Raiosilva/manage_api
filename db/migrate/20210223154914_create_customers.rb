class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :customerName
      t.string :companyName
      t.string :serviceType
      t.string :typeCustomer
      t.string :cpfCnpj
      t.string :image

      t.timestamps
    end
  end
end
