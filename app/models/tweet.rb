class Tweet < ApplicationRecord
  
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  has_many :likes, dependent: :destroy
  has_many :tweets
end
