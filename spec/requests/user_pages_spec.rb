#encoding: utf-8
require 'spec_helper'

describe "User pages" do
	subject { page }
	let(:base_title) { "Aplicación PPMM" }

	describe "signup page" do
		before { visit registrarse_path }
			it { should have_selector('h1', text: 'Registrarse') }
			it { should have_selector('title', text: "#{base_title} | Registro") }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			visit user_path(user)
		end

		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

	describe "signup" do
		before { visit registrarse_path }
		let(:submit) { "Crear usuario" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: 'Registro') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				visit registrarse_path
				fill_in "Nombre", with: "Usuario Prueba"
				fill_in "Correo electrónico", with: "prueba@prueba.com"
				fill_in "Teléfono",	with: "83110022"
				fill_in "Compañía",	with: "Compañía"
				fill_in "Contraseña", with: "contrasena"
				fill_in "Confirmar contraseña", with: "contrasena"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }

				it { should have_selector('title', text: "Usuario Prueba") }
				it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
				it { should have_link('Cerrar sesión') }
			end
		end
	end
end

