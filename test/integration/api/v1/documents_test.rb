require "test_helper"

class Api::V1::DocumentsTest < ActionDispatch::IntegrationTest
  test 'POST /api/v1/documents' do
    HTTP.post('http://localhost:3000/api/v1/documents', form: { 'document[description]': 'test',
                                                                'document_data': { 'customer_name': 'Joe', 'contract_value': 1000 }.to_json,
                                                                'template': HTTP::FormData::File.new('template.html').read })
    res = HTTP.get('http://localhost:3000/api/v1/documents/list').to_s
    data = JSON.parse(res)
    assert data.size >= 0
    assert Document.where(description: 'test').count >= 0
  end

  test 'GET /api/v1/documents/list' do
    res = HTTP.get('http://localhost:3000/api/v1/documents/list')
    assert res.code, 200
  end

  test 'Validation one' do
    HTTP.post('http://localhost:3000/api/v1/documents', form: { 'document[description]': 'document one',
                                                                'document_data': { 'customer_name': '', 'contract_value': 1000 }.to_json,
                                                                'template': HTTP::FormData::File.new('template.html').read })
    assert Document.last.document_datum.last.customer.nil?, true
  end

  test 'Validation two' do
    HTTP.post('http://localhost:3000/api/v1/documents', form: { 'document[description]': 'document two',
                                                                'document_data': { 'customer_name': 'Smith', 'contract_value': 'test' }.to_json,
                                                                'template': HTTP::FormData::File.new('template.html').read })
    assert Document.last.document_datum.last.contract.nil?, true
  end
end
