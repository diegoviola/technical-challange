class DocumentDatum < ApplicationRecord
  belongs_to :document
  has_one :customer
  has_one :contract
end
