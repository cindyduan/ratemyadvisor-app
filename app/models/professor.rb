class Professor < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  before_save { self.netid = netid.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :netid, presence: true, uniqueness: true
  validates :department, presence: true

  # methods for averages


end
