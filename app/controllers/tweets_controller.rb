class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(user_tweet_params)
    @tweet.user = User.find_by(id: params[:user_id])
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet.user, notice: 'Tweet was successfully added.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tweet = Tweet.find_by(params[:id])
    respond_to do |format|
      if @tweet.update(user_tweet_params)
        format.html { redirect_to @tweet.user, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @tweet = Tweet.find_by(id: params[:id])
    @user = @tweet.user
  end

  def destroy
    @tweet = Tweet.find_by(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to @tweet.user }
      format.json { head :no_content }
    end
  end

  private
  def user_tweet_params
    params.require(:tweet).permit(:content)
  end
end
