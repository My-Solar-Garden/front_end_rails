class AddPrivateToGardens < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :private, :boolean
  end
end
