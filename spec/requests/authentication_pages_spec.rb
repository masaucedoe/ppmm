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
			before { sign_in user }

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

	describe "authorization" do
		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Correo electrónico", with: user.email.upcase
					fill_in "Contraseña", with: user.password
					click_button "Iniciar sesión"
				end

				describe "after signing in" do
					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edición del usuario')
					end
				end
			end

			describe "in the Users controller" do
				describe "visiting the user page" do
					before { visit user_path(user) }
					it { should have_selector('title', text: 'Iniciar sesión') }
				end

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_selector('title', text: 'Iniciar sesión') }
				end

				describe "submitting to the update action" do
					before { put user_path(user) }
					specify { response.should redirect_to(iniciar_sesion_path) }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "usuario2@ejemplo.com") }
			before { sign_in user }

			describe "visiting User#show page" do
				before { visit user_path(wrong_user) }
				it { should_not have_selector('title', text: user.name) }
			end

			describe "visiting Users#edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_selector('title', text: "Edición del usuario") }
			end

			describe "submitting a PUT request to the Users#update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end

