class Contract < ApplicationRecord
  belongs_to :document_datum
  validates :value, numericality: true
end
