require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    visit new_session_path
    fill_in 'session_email', with:'test_user_01@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
  end

  describe 'ラベル管理' do
    context'ラベルを作成した際' do
      it 'ラベルが作成できる' do
        # binding.irb
        visit new_label_path
        fill_in 'label_name', with: '開発'
        click_on 'Create Label'
        expect(page).to have_content '開発'
      end
    end

    context'タスクにラベルが付けられる' do
        it 'タスクを新規に作成' do
          # binding.irb
          visit new_task_path
          fill_in "Title", with: "test"
          fill_in "Content", with: "Factoryで作ったデフォルトのコンテント1"
          select "着手中", from: "Status"
          select "高", from: "Priority"
          check 'task[label_ids][]'
          click_on "追加する"
          click_on "追加する"
        end
      end

    context 'ラベルで絞り込んで検索した場合' do
      before do
        visit new_task_path
        fill_in "Title", with: "test"
        fill_in "Content", with: "Factoryで作ったデフォルトのコンテント1"
        select "着手中", from: "Status"
        select "高", from: "Priority"
        check 'task[label_ids][]'
        click_on "追加する"
        click_on "追加する"
      end
      it 'ラベルで検索が絞り込まれる' do
        visit tasks_path
        select 'test_label', from: 'label_id'
        click_on 'search'
        expect(page).to have_content 'test_label'
      end
    end
  end
end
