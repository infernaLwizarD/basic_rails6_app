require 'rails_helper'

RSpec.shared_examples 'delete_self_profile' do
  it 'не может удалить свой профиль' do
    # find(:css, '#users-table').click_link(user.username)
    # expect(page).not_to have_content 'Удалить'

    within('#users-table') do
      click_link(user.username)
      expect(page).not_to have_content 'Удалить'
    end
  end
end

RSpec.describe 'Удаление пользователя', js: true, type: :system do
  before do
    logged_as(user)
    # sign_in(login: user.username, password: user.password, visit: true)
    visit root_path
    find('li p', text: 'Пользователи').click
  end

  context 'Администратор' do
    let(:user) { create(:user, :admin) }

    let!(:qwerty1) { create(:user, username: 'qwerty1') }
    let!(:qwerty2) { create(:user, :discarded_user, username: 'qwerty2') }
    let!(:qwerty3) { create(:user, username: 'qwerty3') }
    let!(:deleting_user) { create(:user, username: 'deleting_user') }
    let!(:deleted_user) { create(:user, :discarded_user, username: 'deleted_user') }
    let!(:qwerty4) { create(:user, username: 'qwerty4') }
    let!(:qwerty5) { create(:user, username: 'qwerty5') }
    let!(:qwerty6) { create(:user, :discarded_user, username: 'qwerty6') }
    let!(:qwerty7) { create(:user, :locked_user, username: 'qwerty7') }
    let!(:qwerty8) { create(:user, username: 'qwerty8') }
    let!(:qwerty9) { create(:user, :discarded_user, username: 'qwerty9') }


    # before do
    #   @deleting_user = create(:user, username: 'deleting_user')
    #   @deleted_user = create(:user, :discarded_user, username: 'deleted_user')
    # end

    it 'удаляет пользователя' do
      # puts "\n",Time.zone.now
      # sleep 10
      # puts "\n",Time.zone.now

      users = User.ransack(role_eq: 'user').result
      puts "\n\n\nудаляет пользователя",'всего пользователей (user) в базе: ' + users.size.to_s
      users.each do |u|
        puts "\nu_id: #{u.id}",u.username,u.confirmed_at,u.inspect
      end

      within('#users-table') do
        expect(page).to have_content(deleting_user.username)
        click_link(deleting_user.username)
      end

      # expect(find(:css, '#users-table')).to have_content deleting_user.username
      # find(:css, '#users-table').click_link(deleting_user.username)

      accept_confirm do
        click_on 'Удалить'
      end

      expect(page).to have_content 'Пользователь удалён'
    end

    it 'восстанавливает пользователя' do
      users = User.ransack(role_eq: 'user').result
      puts "\n\n\nвосстанавливает пользователя",'всего пользователей (user) в базе: ' + users.size.to_s
      users.each do |u|
        puts "\nu_id: #{u.id}",u.username
      end

      within('#users-table') do
        expect(page).to have_content(deleted_user.username)
        click_link(deleted_user.username)
      end

      # expect(find(:css, '#users-table')).to have_content deleted_user.username
      # find(:css, '#users-table').click_link(deleted_user.username)

      click_on 'Восстановить'

      expect(page).to have_content 'Пользователь восстановлен'
    end

    include_examples 'delete_self_profile'
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user) }
    let!(:some_user) { create(:user) }

    # before do
    #   @some_user = create(:user)
    # end

    it 'не может удалять других пользователей' do
      users = User.ransack(role_eq: 'user').result
      puts "\n\n\nне может удалять других пользователей",'пользователь: ' + some_user.username,'всего пользователей (user) в базе:' + users.size.to_s
      users.each do |u|
        puts "\nu_id: #{u.id}",u.username
      end

      within('#users-table') do
        expect(page).to have_content(some_user.username)
        click_link(some_user.username)
      end

      # expect(find(:css, '#users-table')).to have_content some_user.username
      # find(:css, '#users-table').click_link(some_user.username)
      expect(page).not_to have_content 'Удалить'
    end

    include_examples 'delete_self_profile'
  end
end
