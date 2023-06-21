require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
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
      it 'バリデーションが通る'
      expect(task).to be_valid
    end
  end
end
