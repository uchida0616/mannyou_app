require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "task_title"
        fill_in "内容", with: "task_content"
        select "未着手", from: "ステータス"
        select "高", from: "優先度"
        click_on "追加する"
        expect(page).to have_content 'task_title'
      end
    end
  end

  describe '一覧機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        task = FactoryBot.create(:second_task, title: 'task2')
        expect(page).to have_content 'タイトル'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'task')
        task = FactoryBot.create(:second_task, title: 'task2')
        task = FactoryBot.create(:third_task, title: 'task3')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task'
      end
    end
    context '終了期限でソートされた場合' do
      it '終了期限が遅いタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'task')
        task = FactoryBot.create(:second_task, title: 'task2')
        task = FactoryBot.create(:third_task, title: 'task3')
        visit tasks_path
        click_on "終了期限でソートする"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task'
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title:"task2")
      FactoryBot.create(:third_task, title: "task3")
    end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'title', with: 'task'
        click_on 'search'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "未着手", from: "status"
        click_on 'search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task'
        select "未着手", from: "status"
        click_on 'search'
        expect(page).to have_content 'task'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = create(:task, title: 'task')
         visit task_path(task)
         expect(page).to have_content 'task'
       end
    end
  end
end
