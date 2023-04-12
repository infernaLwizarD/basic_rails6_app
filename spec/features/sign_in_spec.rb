require 'rails_helper'

feature 'Пользователь входит в систему' do
  given(:user) { create(:user, :simple_user) }

  background do
    visit new_user_session_path
  end

  scenario 'Зарегистрированный пользователь входит в систему' do
    fill_in 'Логин', with: user.username
    fill_in 'Пароль', with: user.password
    click_on 'Войти'

    expect(page).to have_content 'Вход в систему выполнен'
  end

  scenario 'Незарегистрированный пользователь входит в систему' do
    fill_in 'Логин', with: 'unregistered_user'
    fill_in 'Пароль', with: '123456'
    click_on 'Войти'

    expect(page).to have_content 'Неверный Login или пароль'
  end
end