require 'rails_helper'

describe 'Отправка инструкций по подтверждению' do
  before do
    visit root_path
    click_on 'Аккаунт не подтверждён?'
  end

  context 'Зарегистрированный пользователь' do
    let(:user) { create(:user, :simple_user) }
    let(:new_user) { create(:user, :simple_user, confirmed_at: nil) }

    it 'отправляет запрос на инструкцию с неподтверждённым аккаунтом' do
      fill_in 'Email', with: new_user.email
      click_on 'Отправить'
      expect(page).to have_content I18n.t('devise.confirmations.send_instructions')
    end

    it 'отправляет запрос на инструкцию с подтверждённым аккаунтом' do
      fill_in 'Email', with: user.email
      click_on 'Отправить'
      expect(page).to have_content I18n.t('errors.messages.already_confirmed')
    end
  end

  context 'Незарегистрированный пользователь' do
    it 'отправляет запрос на инструкцию' do
      fill_in 'Email', with: Faker::Internet.unique.email
      click_on 'Отправить'
      expect(page).to have_content 'Email не найден'
    end
  end
end