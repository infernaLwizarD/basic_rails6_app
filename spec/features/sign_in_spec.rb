require 'rails_helper'

describe 'Пользователь входит в систему' do
  let(:user) { create(:user, :simple_user) }

  before do
    visit new_user_session_path
  end

  it 'Зарегистрированный пользователь входит в систему' do
    fill_in 'Логин', with: user.username
    fill_in 'Пароль', with: user.password
    click_on 'Войти'

    expect(page).to have_content 'Вход в систему выполнен'
  end

  it 'Незарегистрированный пользователь входит в систему' do
    fill_in 'Логин', with: 'unregistered_user'
    fill_in 'Пароль', with: '123456'
    click_on 'Войти'

    expect(page).to have_content 'Неверный Login или пароль'
  end
end
