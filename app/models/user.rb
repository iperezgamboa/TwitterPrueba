class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy #Los tweets se eliminan si la cuenta es eliminada
  has_many :likes, dependent: :destroy #Los likes se eliminan si la cuenta es eliminada
  has_many :friends, dependent: :destroy #Los friends se eliminan si la cuenta es eliminada
  paginates_per 50
 

     def followers(user)       
     end
    
     def like          
     end

     def retweets
     end 
end
