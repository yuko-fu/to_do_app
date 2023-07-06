require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user, task_name: "task", status: "未着手")}
    let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample", status: "完了") }
    context 'scopeメソッドでタイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        expect(Task.task_name_search('task')).to include(task)
        expect(Task.task_name_search('task')).not_to include(second_task)
        expect(Task.task_name_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('未着手')).to include (task)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.task_name_search("task") && Task.status_search("未着手")).to include(task)
      end
    end
  end
  describe 'バリデーションのテスト'do
    context 'タスクのタイトルがからの場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name:'', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細がからの場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name:'失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name:'失敗テスト', content: '失敗テスト')
        expect(task).to be_valid
      end
    end
  end
end
