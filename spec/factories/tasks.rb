FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    end_date { 'Factoryで作ったデフォルトの終了期限１' }
    status { 'Factoryで作ったデフォルトのステータス１' }
  end

  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    end_date { 'Factoryで作ったデフォルトの終了期限２' }
    status { 'Factoryで作ったデフォルトのステータス２' }
  end
end
