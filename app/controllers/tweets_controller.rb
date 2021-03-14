class TweetsController < ApplicationController
  #this keep those who are not signed in-out of our app for the most part.
  before_action :authenticate_user!, except: [:index, :news, :date]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]  
  before_action :verify_authenticity_token, only:[:create_api_tweet]
  
  #http_basic_authenticate_with name: "desafio", password: "12345", except: :index
  #before_action :authenticate_user!, except: [:index :create_api_tweet]

  # GET /tweets
  # GET /tweets.json
  def index
    
    @tweet = Tweet.new   
    
    if params[:q]
      @tweets = Tweet.where("content LIKE ?", "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
      elsif current_user.nil?
        @tweets = Tweet.order(created_at: :desc).page(params[:page])
      else
      @tweets = Tweet.tweets_for_me(current_user.friends).or(Tweet.where("user_id = ?", current_user.id)).order(created_at: :desc).page(params[:page])
    end
  end  

  #@tweets = Tweet.tweets_for_me(current_user.friends).or(Tweet.where("user_id = ?", current_user.id)).order(created_at: :desc).page(params[:page])

  def news
      tweets = Tweet.last(50)
      pretty_tweets = helpers.transform_to_hash(tweets)
      render json: pretty_tweets
  end

  def date
      date1 = params[:fecha1].to_date
      date2 = params[:fecha2].to_date.end_of_day
      date_tweets = Tweet.created_between(date1, date2)
      pretty_tweets = helpers.transform_to_hash_with_date(date_tweets)
      render json: pretty_tweets
  end 


  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  # GET /tweets/1/edit
  def edit
    if @tweet.user_id != current_user.id
      redirect_to root_path, notice: 'You are not allowed to Edit a tweet that is not yours :)'
    end
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { redirect_to root_path, notice: ' Remember to write something in your tweet' }
        
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

    def create_api_tweet
        @tweet = Tweet.new(
        content: params[:content],
        user_id: current_user.id
    )
    
  respond_to do |format|
    if @tweet.save
        format.html { redirect_to root_path, notice: 'El Tweet fue creado exitosamente.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
    else
        format.html { redirect_to root_path, alert: 'El Tweet no pudo ser creado' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
    end
  end
  end 

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    origin =  Tweet.find(params[:tweet_id].to_i)
   
      @retweet = current_user.tweets.new(tweet_id: origin.id, content: origin.content) 
   
    if @retweet.save
      redirect_to root_path, notice: 'You have retweeted succesfully'
    else
      redirect_to root_path, notice: 'You have already retweet this tweet'
    end
  end  

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy     
    if @tweet.user_id != current_user.id
        redirect_to root_path, notice: 'You are not allowed to DESTROY a tweet that is not yours :)' 
        else
        @tweet.destroy
        respond_to do |format|
          format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
          format.json { head :no_content }
        end     
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end

    def image_url
      profile_picture.url || default_url
    end
end
