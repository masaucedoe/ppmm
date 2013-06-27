#encoding: utf-8

def sign_in(user)
	visit iniciar_sesion_path
	fill_in "Correo electrónico", with: user.email
	fill_in "Contraseña", with: user.password
	click_button "Iniciar sesión"
	# Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end

