class AddTweetIdToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :tweet_id, :integer
  end
end
