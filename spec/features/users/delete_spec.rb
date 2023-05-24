require 'rails_helper'

RSpec.shared_examples 'delete_self_profile' do
  it 'не может удалить свой профиль' do
    find(:css, '#users-table').click_link(user.username)
    expect(page).not_to have_content 'Удалить'
  end
end

RSpec.describe 'Удаление пользователя', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path
    find('li p', text: 'Пользователи').click
  end

  context 'Администратор' do
    let(:user) { create(:user, :admin) }
    let!(:deleting_user) { create(:user, :simple_user) }
    let!(:deleted_user) { create(:user, :simple_user, discarded_at: Time.zone.now) }

    it 'удаляет пользователя' do
      find(:css, '#users-table').click_link(deleting_user.username)

      accept_confirm do
        click_on 'Удалить'
      end

      expect(page).to have_content 'Пользователь удалён'
    end

    it 'восстанавливает пользователя' do
      find(:css, '#users-table').click_link(deleted_user.username)

      click_on 'Восстановить'

      expect(page).to have_content 'Пользователь восстановлен'
    end

    include_examples 'delete_self_profile'
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user, :simple_user) }
    let!(:some_user) { create(:user, :simple_user) }

    it 'не может удалять других пользователей' do
      find(:css, '#users-table').click_link(some_user.username)
      expect(page).not_to have_content 'Удалить'
    end

    include_examples 'delete_self_profile'
  end
end
