class Dataset < ActiveRecord::Base
	attr_accessible :instance_size, :cavities, :batch_time, :products_composition, :install_time, :velocity, :demand, :machine_time
	belongs_to :user

	validates :user_id, presence: true
	validates :instance_size, presence: true
	validates :cavities, presence: true
	validates :batch_time, presence: true
	validates :products_composition, presence: true
	validates :install_time, presence: true
	validates :velocity, presence: true
	validates :demand, presence: true
	validates :machine_time, presence: true

	private

		def self.import(file,current_user)
			@user = current_user
			@dataset = @user.build_dataset
			@nil_flag = 0
			CSV.foreach(file.path, headers: false) do |row|
				if (row[0].blank? || row[1].blank? || row[2].blank? || row[3].blank? || row[4].blank? || row[5].blank? || row[6].blank? || row[7].blank?)
					@nil_flag = 0
				else
					@dataset.instance_size = row[0]
					@dataset.cavities = row[1]
					@dataset.batch_time = row[2]
					@dataset.products_composition = row[3]
					@dataset.install_time = row[4]
					@dataset.velocity = row[5]
					@dataset.demand = row[6]
					@dataset.machine_time = row[7]
					@dataset.save
					@nil_flag = 1
				end
				return @nil_flag
			end
		end
end

