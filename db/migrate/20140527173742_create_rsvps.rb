class CreateRsvps < ActiveRecord::Migration
  def up
    create_table :rsvps do |t|
    	t.integer :user_id
    	t.integer :meetup_id
    end

    add_index(:rsvps, [:user_id, :meetup_id])
  end

  def down
  	drop_index :rsvps
  end
end
