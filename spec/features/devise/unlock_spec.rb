require 'rails_helper'

describe 'Разблокировка аккаунта' do
  before do
    visit root_path
    click_on 'Аккаунт заблокирован?'
  end

  context 'Зарегистрированный пользователь' do
    let(:user) { create(:user, :simple_user, locked_at: nil) }
    let(:locked_user) { create(:user, :simple_user, locked_at: Time.zone.now) }

    it 'разблокирует заблокированный аккаунт' do
      fill_in 'Email', with: locked_user.email
      click_on 'Отправить'
      expect(page).to have_content I18n.t('devise.unlocks.send_instructions')

      utoken = last_email.body.match(/unlock_token=[^"]*/)
      visit "/users/unlock?#{utoken}"
      expect(page).to have_content I18n.t('devise.unlocks.unlocked')
    end

    it 'разблокирует незаблокированный аккаунт' do
      fill_in 'Email', with: user.email
      click_on 'Отправить'
      expect(page).to have_content I18n.t('errors.messages.not_locked')
    end
  end

  context 'Незарегистрированный пользователь' do
    it 'разблокирует аккаунт' do
      fill_in 'Email', with: Faker::Internet.unique.email
      click_on 'Отправить'
      expect(page).to have_content 'Email не найден'
    end
  end
end
