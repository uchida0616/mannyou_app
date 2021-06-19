class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 80 }
  # scope :search_title_status, -> (title, status) { where("title LIKE ?", "%#{title}%") && where(status: status)}
	scope :search_status, -> (status) { where(status: status) }
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  enum status:{  未着手: 0, 着手中: 1, 完了: 2 }
	enum priority:{ 高: 0, 中: 1, 低: 2 }
end
