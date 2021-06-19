FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    expired_at { "2021-05-18 18:00:00" }
    status { '着手中' }
    priority { '高' }
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    expired_at { "2021-05-19 15:00:00" }
    status { '完了' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    expired_at { "2021-05-20 11:00:00" }
    status { '未着手' }
    priority { '低' }
  end

end
