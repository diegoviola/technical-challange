class Customer < ApplicationRecord
  belongs_to :document_datum
  validates :name, presence: true
end
