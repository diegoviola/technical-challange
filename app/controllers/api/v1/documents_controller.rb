class Api::V1::DocumentsController < ApplicationController
  def list
    render json: Document.all.to_json(include: [document_datum: { include: [:customer, :contract] }])
  end

  def create
    document = Document.new(document_params)
    document.uuid = SecureRandom.uuid
    document.pdf_url = 'http://localhost:3000/contract.pdf'
    document.document_datum.build
    document.remote = true if params['remote']

    if document.save && document.create_customer_and_contract(params['document_data'], params['template'])
      render json: document.to_json(include: [document_datum: { include: [:customer, :contract] }])
    else
      render json: 400
    end
  end

  private

  def document_params
    params.require(:document).permit(:description)
  end
end
