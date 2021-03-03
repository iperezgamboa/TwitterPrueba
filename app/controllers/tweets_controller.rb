class TweetsController < ApplicationController
  #this keep those who are not signed in-out of our app for the most part.
  before_action :authenticate_user!, except: [:index]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  

  # GET /tweets
  # GET /tweets.json
  def index
    #@tweets = Tweet.order(params[:page]).order_by(:id)
    @tweets = Tweet.order("created_at desc").page(params[:page])
    #@tweeet = Tweet.new   
    @tweeet = Tweet.all   #new 23/03
    #Book.order('published_at').page(3).per(10) 
    @tweet = Tweet.new
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
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
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

  #lo hice hoy 22
  
  def retweet
    origin =  Tweet.find(params[:id])
   
 

    @retweet = current_user.tweets.new(tweet_id: @tweet.id) 
   
    if @retweet.save
      redirect_to root_path, notice: 'Has retuiteado exitosamente'
    else
      redirect_to root_path, notice: 'Ya lo has retuiteado!'
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
