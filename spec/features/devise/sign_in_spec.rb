require 'rails_helper'

RSpec.describe 'Пользователь входит в систему', type: :system do
  before do
    visit new_user_session_path
  end

  context 'Зарегистрированный пользователь' do
    let(:user) { create(:user, :simple_user) }

    it 'входит в систему' do
      fill_in 'Логин', with: user.username
      fill_in 'Пароль', with: user.password
      click_on 'Войти'

      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end
  end

  context 'Незарегистрированный пользователь' do
    it 'входит в систему' do
      fill_in 'Логин', with: Faker::Internet.unique.username(separators: %w[_])
      fill_in 'Пароль', with: Faker::Internet.unique.password(min_length: 6)
      click_on 'Войти'

      expect(page).to have_content 'Неверный Login или пароль'
    end
  end
end
