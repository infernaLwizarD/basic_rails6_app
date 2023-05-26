require 'rails_helper'

RSpec.shared_examples 'edit_user' do
  it 'успешно редактирует' do
    find(:css, '#users-table').click_link(edited_user.username)

    click_on 'Редактировать'

    new_name = Faker::Internet.unique.username(separators: %w[_])
    fill_in 'Имя пользователя', with: new_name

    click_on 'Сохранить'

    expect(page).to have_content 'Пользователь отредактирован'
    expect(page).to have_content new_name
  end

  it 'получает сообщение об ошибке не заполнив обязательных полей' do
    find(:css, '#users-table').click_link(edited_user.username)

    click_on 'Редактировать'

    fill_in 'Имя пользователя', with: ''

    click_on 'Сохранить'

    expect(page).to have_content 'не может быть пустым'
  end
end

RSpec.describe 'Редактирование пользователя', js: true, type: :system do
  before do
    logged_as(user)
    visit root_path
    find('li p', text: 'Пользователи').click
  end

  context 'Администратор' do
    let(:user) { create(:user, :admin) }
    let!(:some_user) { create(:user) }

    context 'свой профиль' do
      let(:edited_user) { user }

      include_examples 'edit_user'
    end

    context 'профиль другого пользователя' do
      let(:edited_user) { some_user }

      include_examples 'edit_user'
    end
  end

  context 'Обычный пользователь' do
    let(:user) { create(:user) }
    let!(:some_user) { create(:user) }

    it 'не может добавлять и редактировать других пользователей' do
      expect(page).not_to have_content 'Добавить'
      find(:css, '#users-table').click_link(some_user.username)
      expect(page).not_to have_content 'Редактировать'
    end

    context 'свой профиль' do
      let(:edited_user) { user }

      include_examples 'edit_user'
    end
  end
end
