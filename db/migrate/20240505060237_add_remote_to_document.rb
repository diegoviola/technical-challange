class AddRemoteToDocument < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :remote, :boolean, default: false
  end
end
