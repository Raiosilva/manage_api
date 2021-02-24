class Customer < ApplicationRecord
	has_many :contacts, dependent: :destroy
	has_many :facilities, dependent: :destroy

	attribute :customerName, :string

	scope :search_filter, -> customerName { where('"customers"."customerName" LIKE ?', "#{sanitize_sql_like(customerName)}%") }
	# scope :filter_by_starts_with, -> (customerName) { where("name like ?", "#{name}%") }
	# scope :filter_by_starts_with, -> (customerName) { where customerName: customerName }
	# scope :filter_by_starts_with, -> (name) { where("name like ?", "#{name}%")}
end
