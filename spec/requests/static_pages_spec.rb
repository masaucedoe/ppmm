#encoding: utf-8
require 'spec_helper'

describe "Static pages" do
	subject { page }
	let(:base_title) { "Aplicación PPMM" }

	describe "Inicio page" do
		before { visit root_path }
			it { should have_selector('h1', text: 'Aplicación PPMM') } # Page should have the content 'Aplicación PPMM'.
			it { should have_selector('title', text: "#{base_title} | Inicio") } # Page should have the title 'Inicio'.
	end

	describe "Ayuda page" do
		before { visit ayuda_path }
			it { should have_selector('h1', text: 'Ayuda') } # Page should have the content 'Ayuda'.
			it { should have_selector('title', text: "#{base_title} | Ayuda") } # Page should have the title 'Ayuda'.
	end

	describe "Empresa page" do
		before { visit empresa_path }
			it { should have_selector('h1', text: 'Nuestra Empresa') } # Page should have the content 'Nuestra Empresa'.
			it { should have_selector('title', text: "#{base_title} | Acerca de nosotros") } # Page should have the title 'Acerca de nosotros'.
	end

	describe "Contacto page" do
		before { visit contacto_path }
			it { should have_selector('h1', text: 'Contáctanos') } # Page should have the content 'Contáctanos'.
			it { should have_selector('title', text: "#{base_title} | Contacto") } # Page should have the title 'Contacto'.
	end
end

