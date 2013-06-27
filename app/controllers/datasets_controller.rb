#encoding: utf-8
class DatasetsController < ApplicationController

	def new
		@dataset = current_user.build_dataset
	end

	def create
		@dataset = current_user.build_dataset(params[:dataset])
		if @dataset.save
			flash[:success] = "Conjunto de datos creado."
			redirect_to dataset_path(current_user)
		else
			flash[:error] = "La información está incompleta. No es posible crear el conjunto de datos."
			redirect_to carga_de_datos_path
		end
	end

	def show
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

