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
end

