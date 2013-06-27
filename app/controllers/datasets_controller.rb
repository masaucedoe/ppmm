#encoding: utf-8
class DatasetsController < ApplicationController

	def new
		@dataset = current_user.build_dataset
	end

	def create
		@result = Dataset.import(params[:file], current_user)
		if @result == 1
			flash[:success] = "Conjunto de datos creado."
			redirect_to dataset_path(current_user)
		else
			flash[:error] = "La información está incompleta. No es posible crear el conjunto de datos."
			redirect_to carga_de_datos_path
		end
	end

	def show
		@instance_size = current_user.dataset.instance_size.split(",").map(&:to_i)
		@cavities = current_user.dataset.cavities.split(",").map(&:to_i)
		@batch_time = current_user.dataset.batch_time.split(",").map(&:to_f)
		@products_composition = current_user.dataset.products_composition.split(",").map(&:to_i)
		@install_time = current_user.dataset.install_time.split(",").map(&:to_f)
		@velocity = current_user.dataset.velocity.split(",").map(&:to_f)
		@demand = current_user.dataset.demand.split(",").map(&:to_i)
		@machine_time = current_user.dataset.machine_time.split(",").map(&:to_f)
		gon.instance = @instance_size
		if current_user.admin?
			@user = User.find(params[:id])
			@dataset = @user.dataset
		else
			@user = current_user
			@dataset = @user.dataset
		end
	end

	def edit
		@user = current_user
		@dataset = @user.dataset
	end

	def update
		@user = current_user
		@dataset = @user.dataset
		if @dataset.update_attributes(params[:dataset])
			flash[:success] = "Conjunto de datos actualizado."
			redirect_to dataset_path(current_user)
		else
			flash[:error] = "La información está incompleta. No es posible actualizar el conjunto de datos."
			render 'edit'
		end
	end
end

