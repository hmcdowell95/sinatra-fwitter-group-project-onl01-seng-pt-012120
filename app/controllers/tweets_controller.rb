class TweetsController < ApplicationController
get '/tweets' do 
    @tweets = Tweet.all
    #binding.pry
    if session[:user_id]
      erb :"/tweets/index"
    else 
      redirect "/login"
    end
  end
  
  get '/tweets/new' do
    if session[:user_id]
      erb :"/tweets/new"
    end
  end
  
  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.user = User.find(session[:user_id])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id]
      erb :"/tweets/show"
    else 
      redirect "/login"
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if User.find(session[:user_id]) == @tweet.user
      erb :"/tweets/edit"
    else
      redirect "/login"
    end 
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    erb :"/tweets/show"
  end
      
  delete '/tweets/:id/delete' do 
    Tweet.destroy(params[:id])
    erb :"/tweets/index"
  end


end
