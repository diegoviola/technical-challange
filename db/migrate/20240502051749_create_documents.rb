class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :uuid
      t.string :pdf_url
      t.string :description

      t.timestamps
    end
  end
end
