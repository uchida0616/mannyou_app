class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 80 }
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true
# scope :search_title_status, -> (title, status) { where("title LIKE ?", "%#{title}%") && where(status: status)}
	scope :search_status, -> (status) { where(status: status) }
  scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  enum status:{  未着手: 0, 着手中: 1, 完了: 2 }
	enum priority:{ 高: 0, 中: 1, 低: 2 }

  def has_label?(label)
    self.labels.find_by(id: label.id).present?
  end
end
