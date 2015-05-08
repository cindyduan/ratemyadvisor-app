class Review < ActiveRecord::Base
  belongs_to :professor
  default_scope -> { order(created_at: :desc) }
  validates :professor_id, presence: true
  validates :student_netid, presence: true
  validates :student_class, numericality: { only_integer: true, greater_than: 1746, less_than: 2018}
  validates :professor_netid, presence: true
  validates :relationship, presence: true
  validates :availability, presence: true
  validates :responsiveness, presence: true
  validates :knowledge, presence: true
  validates :organization, presence: true
  validates :friendliness, presence: true
  validates :helpfulness, presence: true
  validates :comments, presence: true
end
