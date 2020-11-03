class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :token
      t.string :refresh_token
      t.timestamps
    end
  end
end
