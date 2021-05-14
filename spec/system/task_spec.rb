require 'rails_helper'
describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task, title: 'task_1')
    FactoryBot.create(:task, title: 'task_2')
    FactoryBot.create(:task, title: 'task_3')
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "task_title"
        fill_in "内容", with: "task_content"
        click_on "追加する"
        expect(page).to have_content 'task_title'
      end
    end
  end
  describe '一覧機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'new_title')
        visit tasks_path
        expect(all('.task')[0].text).to have_content 'new_title'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task')
         visit task_path(task)
         expect(page).to have_content 'task'
       end
     end
  end
end
