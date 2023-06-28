FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    end_date { '2023-07-07' }
    status { '完了' }
    priority { '中' }
  end

  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    end_date { '2023-07-10' }
    status { '未着手' }
    priority { '高' }
  end
end
