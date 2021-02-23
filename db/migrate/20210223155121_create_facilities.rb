class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :address
      t.string :number
      t.string :complement
      t.string :state
      t.string :country
      t.string :city
      t.string :zipCode
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
