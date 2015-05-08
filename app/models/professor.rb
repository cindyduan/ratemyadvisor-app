class Professor < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  before_save { self.netid = netid.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :netid, presence: true, uniqueness: true
  validates :department, presence: true
  searchkick autocomplete: ['first_name', 'last_name', 'netid', 'department', 'full_name']

  # methods for averages
  def avg_avail
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.availability
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end

  def avg_resp
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.responsiveness
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end

  def avg_know
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.knowledge
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end

  def avg_org
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.organization
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end

  def avg_friend
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.friendliness
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end

  def avg_help
    reviews = self.reviews
    counter = 0
    sum = 0
    reviews.each do |review|
      sum += review.helpfulness
      counter += 1
    end 
    return Float(sum) / Float(counter)
  end
  
  def num_rev
    reviews = self.reviews
    counter = 0
    reviews.each do |review|
      counter += 1
    end
    return counter
  end
end
