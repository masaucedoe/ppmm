#encoding: utf-8
FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Persona #{n}" }
		sequence(:email) { |n| "usuario_#{n}@ejemplo.com"}
		telephone "83001122"
		company "Organización"
		password "micontrasena"
		password_confirmation "micontrasena"

		factory :admin do
			admin true
		end
	end

	factory :dataset do
		instance_size "2,2,2,2"
		cavities "1,1,1,1,1,1,1"
		batch_time "1,1,1,1,1,1,1"
		products_composition "1,1,1,1"
		install_time "1,1,1,1"
		velocity "1,1"
		demand "1,1"
		machine_time "1,1"
		user
	end
end

