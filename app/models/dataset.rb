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
end

