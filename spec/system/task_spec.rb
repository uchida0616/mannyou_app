require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session_email', with:'test_user_01@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # binding.irb
        visit new_task_path
        fill_in "Title", with: "task_title"
        fill_in "Content", with: "task_content"
        select "未着手", from: "Status"
        select "高", from: "Priority"
        click_on "追加する" #新規作成画面用
        click_on "追加する" #確認画面用
        expect(page).to have_content 'task_title'
      end
    end
  end

  describe '一覧機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # task = FactoryBot.create(:task, title: 'task', user: @user)
        # task = FactoryBot.create(:second_task, title: 'task2', user: @user)
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # binding.irb
        # task = FactoryBot.create(:task, title: 'task')
        # task = FactoryBot.create(:second_task, title: 'task2')
        # task = FactoryBot.create(:third_task, title: 'task3')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル2'
      end
    end
    context '終了期限でソートされた場合' do
      it '終了期限がはやいタスクが一番上に表示される' do
        # task = FactoryBot.create(:task, title: 'task', user: @user)
        # task = FactoryBot.create(:second_task, title: 'task2', user: @user)
        # task = FactoryBot.create(:third_task, title: 'task3', user: @user)
        visit tasks_path
        click_on "終了期限"
        click_on "終了期限でソートする"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end

  describe '検索機能' do
    # before do
    #   FactoryBot.create(:task, title: "task", user: @user)
    #   FactoryBot.create(:second_task, title:"task2")
    #   FactoryBot.create(:third_task, title: "task3")
    # end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'title', with: 'タイトル１'
        click_on 'search'
        expect(page).to have_content 'タイトル１'
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
        fill_in 'title', with: 'タイトル2'
        select "未着手", from: "status"
        click_on 'search'
        expect(page).to have_content 'タイトル2'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = create(:task, title: 'task', user: @user)
         visit task_path(task)
         expect(page).to have_content 'task'
       end
    end
  end
end
