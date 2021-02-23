class Customer < ApplicationRecord
	has_many :contacts, dependent: :destroy
	has_many :facilities, dependent: :destroy
end
