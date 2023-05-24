require 'rails_helper'

RSpec.shared_examples 'lock_self_profile' do
  it 'не может заблокировать свой профиль' do
    find(:css, '#users-table').click_link(user.username)
    expect(page).not_to have_content 'Заблокировать'
  end
end

RSpec.describe 'Блокировка пользователя', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path
    find('li p', text: 'Пользователи').click
  end

  context 'Администратор' do
    let(:user) { create(:user, :admin) }
    let!(:locking_user) { create(:user, :simple_user) }
    let!(:locked_user) { create(:user, :simple_user, locked_at: Time.zone.now) }

    it 'блокирует пользователя' do
      find(:css, '#users-table').click_link(locking_user.username)

      click_on 'Заблокировать'

      expect(page).to have_content 'Пользователь заблокирован'
    end

    it 'восстанавливает пользователя' do
      find(:css, '#users-table').click_link(locked_user.username)

      click_on 'Разблокировать'

      expect(page).to have_content 'Пользователь разблокирован'
    end

    include_examples 'lock_self_profile'
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user, :simple_user) }
    let!(:some_user) { create(:user, :simple_user) }

    it 'не может заблокировать других пользователей' do
      find(:css, '#users-table').click_link(some_user.username)
      expect(page).not_to have_content 'Заблокировать'
    end

    include_examples 'lock_self_profile'
  end
end
