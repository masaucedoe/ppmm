#encoding: utf-8
require 'spec_helper'

describe "Dataset" do
	let(:user) { FactoryGirl.create(:user) }
	before { @dataset = user.build_dataset(
		instance_size: "2,2,2,2",
		cavities: "1,1,1,1,1,1,1,1",
		batch_time: "1,1,1,1,1,1,1,1",
		products_composition: "1,1,1,1",
		install_time: "1,1,1,1",
		velocity: "1,1",
		demand: "1,1",
		machine_time: "1,1"
	) }

	subject { @dataset }

	it { should respond_to(:instance_size) }
	it { should respond_to(:cavities) }
	it { should respond_to(:batch_time) }
	it { should respond_to(:products_composition) }
	it { should respond_to(:velocity) }
	it { should respond_to(:demand) }
	it { should respond_to(:install_time) }
	it { should respond_to(:machine_time) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should == user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @dataset.user_id = nil }
		it { should_not be_valid }
	end

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Dataset.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "with blank instance size" do
		before { @dataset.instance_size = " " }
		it { should_not be_valid }
	end

	describe "with blank cavities" do
		before { @dataset.cavities = " " }
		it { should_not be_valid }
	end

	describe "with blank batch_time" do
		before { @dataset.batch_time = " " }
		it { should_not be_valid }
	end

	describe "with blank number of products_composition" do
		before { @dataset.products_composition = " " }
		it { should_not be_valid }
	end

	describe "with blank install times" do
		before { @dataset.install_time = " " }
		it { should_not be_valid }
	end

	describe "with blank velocities" do
		before { @dataset.velocity = " " }
		it { should_not be_valid }
	end

	describe "with blank demand of products" do
		before { @dataset.demand = " " }
		it { should_not be_valid }
	end

	describe "with blank machine times" do
		before { @dataset.machine_time = " " }
		it { should_not be_valid }
	end

	describe "when user_id is not present" do
		before { @dataset.user_id = nil }
		it { should_not be_valid }
	end
end

