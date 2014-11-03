class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :password

      t.timestamps
    end
    add_index :users, :email
  end
end
