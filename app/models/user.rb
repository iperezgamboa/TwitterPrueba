class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes, dependent: :destroy
  paginates_per 50
  

     def followers(user)
       
     end

     def profile_picture
     end
  end
