require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user, task_name: "task", status: "未着手")}
    let!(:second_task) { FactoryBot.create(:second_task, user: user, task_name: "sample", status: "完了") }
    before do
      visit new_session_path
      fill_in 'session_email', with: 'dpro@mail.com'
      fill_in 'session_password', with: 'dpro@mail.com'
      click_on 'Log in'
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'task_task_name', with: 'ta'
        
        # 検索ボタンを押す
        click_on "検索"
        sleep(1)
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        select"未着手", from: "task_status"
        
        click_on "検索"
        # プルダウンを選択する「select」について調べてみること
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit tasks_path
        sleep(1)
        fill_in 'task_task_name', with: 'sa' 
        select"完了", from: "task_status"
        
        click_on "検索"
        
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
      end
    end
  end

  describe 'ラベル機能' do
    let!(:label) { FactoryBot.create(:label, name: "label3") }
    let!(:user) { FactoryBot.create(:user) }
    
    before do
      visit new_session_path
      fill_in 'session_email', with: 'dpro@mail.com'
      fill_in 'session_password', with: 'dpro@mail.com'
      click_on 'Log in'
    end
    context 'タスク作成画面でラベルを選択すると' do
      it '詳細画面に選択したラベルが表示される' do
        visit new_task_path
        sleep(1)
        fill_in 'task_task_name', with: 'テスト'
        fill_in 'task_content', with: 'テストコンテント'
        check "label3"
        select"完了", from: "task_status"
        select"高", from: "task_priority"
        
        click_on '登録する'
        # binding.pry
        
        sleep(1)
        click_on '一覧に戻る'
        expect(page).to have_content "label3"
      end
    end
  end
  
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user, task_name: "task", status: "未着手")}
    let!(:second_task) { FactoryBot.create(:second_task, user: user, task_name: "sample", status: "完了") }
    before do
      visit new_session_path
      fill_in 'session_email', with: 'dpro@mail.com'
      fill_in 'session_password', with: 'dpro@mail.com'
      click_on 'Log in'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
      
        fill_in 'task_task_name', with: 'yarukoto'
        fill_in 'task_content', with: 'kontento'
        select"完了", from: "task_status"
        select"高", from: "task_priority"
        click_on '登録する'
        click_on '一覧に戻る'
        
        expect(page).to have_content 'yarukoto'
        expect(page).to have_content 'kontento'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
      end
    end
  end
  
  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user, task_name: "task", status: "未着手")}
    let!(:second_task) { FactoryBot.create(:second_task, user: user, task_name: "sample", status: "完了") }
    before do
      visit new_session_path
      fill_in 'session_email', with: 'dpro@mail.com'
      fill_in 'session_password', with: 'dpro@mail.com'
      click_on 'Log in'
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task', user: user)
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
      end
    end
    
    context 'タスクが作成日時の降順に並んでいる場合' do
      before do
        Task.create(task_name: "name1", content: "content1", created_at: Time.zone.now, status: "未着手", priority: "高", user: user)
        Task.create(task_name: "name2", content: "content2", created_at: 1.day.from_now, status: "着手中", priority: "高", user: user)
        Task.create(task_name: "name3", content: "content3", created_at: 1.day.ago, status: "完了", priority: "高", user: user)
      end
      it '新しいタスクが一番上に表示される' do
          visit tasks_path
          sleep(1)
          task_list = all('.task_row')
            expect(task_list.first).to have_content "name2"
      end
    end

    context 'タスクが終了期限順に並んでいる場合' do
      before do
        Task.create(task_name: "name1", content: "content1", end_date: '2023-6-30', status: "未着手", priority: "高", user: user)
        Task.create(task_name: "name2", content: "content2", end_date: '2023-6-28', status: "着手中", priority: "高", user: user)
        Task.create(task_name: "name3", content: "content3", end_date: '2023-7-5', status: "完了", priority: "高", user: user)
      end
      it '期限が近いタスクが一番上に表示される' do
        visit tasks_path
        click_on "終了期限でソートする"
        sleep(1)
        task_list = all('.task_row')
        expect(task_list.first).to have_content "name2"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        
      end
    end
  end
end