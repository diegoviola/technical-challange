class Document < ApplicationRecord
  has_many :document_datum
  validates :description, presence: true

  def create_customer_and_contract(document, template)
    customer = JSON.parse(document)
    Document.transaction do
      begin
        document_datum.first.create_customer!(name: customer['customer_name'])
        document_datum.first.create_contract!(value: customer['contract_value'])
        doc = prepare_doc(customer, template)
        generate_pdf(doc)
      rescue ActiveRecord::RecordInvalid
        false
      end
    end
  end

  private

  def prepare_doc(customer, template)
    template.gsub!("\{\{customer_name\}\}", customer['customer_name'])
    template.gsub!("\{\{contract_value\}\}", "#{customer['contract_value']}")
    Nokogiri::HTML(template)
  end

  def generate_pdf(doc)
    texdoc = build_latex_template(doc)
    file = Tempfile.new('doc.')
    file.write(texdoc)
    file.close
    system("xelatex -jobname=contract -output-directory=#{Rails.root}/public/ #{file.path} &")
    sleep(2)
    send_to_remote if self.remote == true
    file.unlink
  end

  def build_latex_template(doc)
    root = doc.root
    latex = '\\documentclass{article}\\begin{document}'

    root.elements.last.children.each do |e|
      case e.name
      when 'h1'
        latex += "\\huge{\\textbf{ #{e.text} }}"
        latex += "\n\n"
      when 'h2'
        latex += "\\large{\\textbf{ #{e.text} }}"
        latex += "\n\n"
      when 'p'
        latex += "\n\n"
        latex += "#{e.text} \\\\"
        latex += "\n\n"
      end
    end

    latex += '\\end{document}'
    latex
  end

  def send_to_remote
    res = HTTP.post('http://0x0.st', form: { file: HTTP::FormData::File.new("#{Rails.root}/public/contract.pdf"),
                                             expires: 24 })
    url = res.to_s.strip
    self.pdf_url = url
    self.save
  end
end
