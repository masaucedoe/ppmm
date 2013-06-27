class CreateDatasets < ActiveRecord::Migration
	def change
		create_table :datasets do |t|
			t.text :instance_size
			t.text :cavities
			t.text :batch_time
			t.text :products_composition
			t.text :install_time
			t.text :velocity
			t.text :demand
			t.text :machine_time
			t.integer :user_id

			t.timestamps
		end
		add_index :datasets, :user_id
	end
end

