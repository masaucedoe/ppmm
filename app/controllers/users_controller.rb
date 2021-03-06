#encoding: utf-8
class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:show, :index, :destroy, :edit, :update]
	before_filter :correct_user, only: [:show, :edit, :update]
	before_filter :admin_user, only: [:index, :destroy]

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "¡Bienvenido a la aplicación Logykopt-PPMM en línea!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Perfil actualizado"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 20)
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Usuario eliminado."
		redirect_to users_url
	end

	private

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to iniciar_sesion_url, notice: "Por favor, inicie sesión."
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) && flash[:error] = "Acción inválida." unless (current_user?(@user) || current_user.admin?)
		end

		def admin_user
			redirect_to(root_path) && flash[:error] = "Acción inválida." unless current_user.admin?
		end

end

