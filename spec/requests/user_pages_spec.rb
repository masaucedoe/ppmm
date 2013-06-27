#encoding: utf-8
require 'spec_helper'

describe "User pages" do
	subject { page }
	let(:base_title) { "Aplicación PPMM" }

	describe "index" do
		describe "as a non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			before { sign_in user }
			it { should_not have_link('Usuarios') }

			before { visit users_path }
			it { should_not have_selector('title', text: 'Lista de usuarios') }
			it { should_not have_selector('h1', text: 'Lista de usuarios') }
		end

		describe "as an admin user" do
			let(:admin) { FactoryGirl.create(:admin) }
			before { sign_in admin }
			it { should have_link('Usuarios') }

			before { visit users_path }
			it { should have_selector('title', text: 'Lista de usuarios') }
			it { should have_selector('h1', text: 'Lista de usuarios') }

			describe "pagination" do
				before(:all) { 30.times { FactoryGirl.create(:user) } }

				it { should have_selector('div.pagination') }
				it "should list each user" do
					User.all[1..5].each do |user|
						page.should have_selector('li', text: user.name)
					end
				end

				describe "delete links" do
					before { visit users_path }
					it { should have_link('Eliminar', href: user_path(User.first)) }
					it "should be able to delete another user" do
						expect { click_link('Eliminar') }.to change(User, :count).by(-1)
					end
					it { should_not have_link('Eliminar', href: user_path(admin)) }
					after(:all)	{ User.delete_all }
				end
			end
		end
	end

	describe "signup page" do
		before { visit registrarse_path }
			it { should have_selector('h1', text: 'Registrarse') }
			it { should have_selector('title', text: "#{base_title} | Registro") }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }

		before do
			sign_in user
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

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }

		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_selector('h1', text: "Editar usuario") }
			it { should have_selector('title', text: "Edición del usuario") }
			it { should have_link('Cambiar', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
			before { click_button "Guardar cambios" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_name) { "Nuevo Nombre" }
			let(:new_email) { "usuario2@ejemplo.com" }

			before do
				fill_in "Nombre", with: new_name
				fill_in "Correo electrónico", with: new_email
				fill_in "Contraseña", with: user.password
				fill_in "Confirmar contraseña", with: user.password
				click_button "Guardar cambios"
			end

			it { should have_selector('title', text: new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Cerrar sesión', href: cerrar_sesion_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end
end

