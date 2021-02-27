class Customer < ApplicationRecord
	has_many :contacts, dependent: :destroy
	has_many :facilities, dependent: :destroy

	attribute :customerName, :string

	validates :customerName, presence: true, length: { maximum: 100 }, uniqueness: {message: 'Must be unique'}
	validates :companyName, presence: true, length: { maximum: 100 }, uniqueness: {message: 'Must be unique'}
	validates :cpfCnpj, presence: true, length: { is: 14 }, uniqueness: {message: 'Must be unique'}

	scope :search_filter, -> customerName { where('"customers"."customerName" LIKE ?', "#{sanitize_sql_like(customerName)}%") }
end
