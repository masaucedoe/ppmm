#encoding: utf-8
require 'spec_helper'

describe "Data pages" do
	subject { page }
	let(:base_title) { "Aplicación PPMM" }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }
	let(:dataset) { FactoryGirl.create(:dataset, user: user) }

	describe "create page" do
		before { visit carga_de_datos_path }
			it { should have_selector('h1', text: 'Cargar datos') }
			it { should have_selector('title', text: "#{base_title} | #{user.name} | Carga de datos") }
	end

	describe "data profile page" do
		before { visit user_path(user) }

		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

	describe "creation" do
		before { visit carga_de_datos_path }
		let(:submit) { "Crear conjunto de datos" }

		describe "with invalid information" do
			it "should not create a dataset" do
				expect { click_button submit }.not_to change(Dataset, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: 'Carga de datos') }
				it { should have_selector('div.alert.alert-error', text: 'incompleta') }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Tamaño de instancia", with: "1"
				fill_in "Número de cavidades", with: "1"
				fill_in "Tiempo de lote", with: "1"
				fill_in "Composición de productos", with: "1"
				fill_in "Tiempo de instalación de moldes", with: "1"
				fill_in "Velocidad de procesamiento", with: "1"
				fill_in "Demanda de productos", with: "1"
				fill_in "Tiempo máquina disponible", with: "1"
			end

			it "should create a dataset" do
				expect { click_button submit }.to change(Dataset, :count).by(1)
			end

			describe "after saving the dataset" do
				before { click_button submit }

				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Conjunto de datos creado.') }
			end
		end
	end
end

