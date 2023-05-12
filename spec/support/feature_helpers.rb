module FeatureHelpers
  def sign_in(options = {})
    visit new_user_session_path if options[:visit]
    fill_in 'Логин', with: options[:login]
    fill_in 'Пароль', with: options[:password]
    click_on 'Войти'
  end

  def logged_as(user)
    page.set_rack_session('warden.user.user.key' => User.serialize_into_session(user))
  end
end
