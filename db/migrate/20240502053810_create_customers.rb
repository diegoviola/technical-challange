class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.references :document_datum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
