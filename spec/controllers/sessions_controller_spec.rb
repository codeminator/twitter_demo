require 'spec_helper'

describe SessionsController do

  # describe "GET 'new'" do
  #   it "returns http success" do
  #     get 'new'
  #     response.should be_success
  #   end
  # end

  describe "GET 'create'" do
    it "returns http success" do
      result = {}
      result['omniauth.auth'] = {}
      result['omniauth.auth']['credentials'] = {}
      result['omniauth.auth']['credentials']['token'] = 'abc'
      result['omniauth.auth']['credentials']['secret'] = '123'
      request.env["omniauth.auth"] = result['omniauth.auth']
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      get 'create'
      #response.should be_success
      expect(response).to redirect_to(my_tweets_user_path)
    end
  end

  # describe "GET 'destroy'" do
  #   it "returns http success" do
  #     get 'destroy'
  #     response.should be_success
  #   end
  # end

end
