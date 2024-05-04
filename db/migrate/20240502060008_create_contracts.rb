class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.decimal :value
      t.references :document_datum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
