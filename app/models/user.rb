class User < ActiveRecord::Base

  #This concern can be used to initiate and use methods of Twitter Social client (Singleton pattern applied, to reduce requests to the client)
  include Twitterable
  #--------------Attributes---------------
  alias_attribute :screen_name, :nickname
  #--------------Methods------------------
  
  #**************Public methods***********
  ###############Class Methods############
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid).permit!).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.profile_image_url = auth.info.image
      user.nickname = auth.info.nickname
      user.description = auth.info.description
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end
end
