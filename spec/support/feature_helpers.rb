module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Логин', with: user.username
    fill_in 'Пароль', with: user.password
    click_on 'Войти'
  end
end
