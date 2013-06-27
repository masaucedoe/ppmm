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
end

