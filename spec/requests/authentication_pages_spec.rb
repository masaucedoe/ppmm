#encoding: utf-8
require 'spec_helper'

describe "Authentication" do
	subject { page }

	describe "signin page" do
		before { visit iniciar_sesion_path }

		it { should have_selector('h1',	text: 'Inicio de sesión') }
		it { should have_selector('title', text: 'Iniciar sesión') }
	end

	describe "signin" do
		before { visit iniciar_sesion_path }

		describe "with invalid information" do
			before { click_button "Iniciar sesión" }

			it { should have_selector('title', text: 'Iniciar sesión') }
			it { should have_selector('div.alert.alert-error', text: 'incorrectos') }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				fill_in "Correo electrónico", with: user.email.upcase
				fill_in "Contraseña", with: user.password
				click_button "Iniciar sesión"
			end

			it { should have_selector('title', text: user.name) }
			it { should have_link('Perfil', href: user_path(user)) }
			it { should have_link('Cerrar sesión', href: cerrar_sesion_path) }
			it { should_not have_link('Iniciar sesión', href: iniciar_sesion_path) }

			describe "followed by signout" do
				before { click_link "Cerrar sesión" }
				it { should have_link('Iniciar sesión') }
			end
		end
	end
end

