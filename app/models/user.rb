class User < ActiveRecord::Base
  attr_accessible :image, :location, :name, :oauth_expires_at, :oauth_token, :provider, :timezone, :uid

  has_one :score

  def self.from_omniauth(auth)

    oauth = Koala::Facebook::OAuth.new(ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"])
    new_access_info = oauth.exchange_access_token_info auth.credentials.token

    new_access_token = new_access_info["access_token"]
    new_access_expires_at = DateTime.now + new_access_info["expires"].to_i.seconds

    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.location = auth.info.location
      user.timezone = auth.extra.timezone
      user.oauth_token = new_access_token
      user.oauth_expires_at = new_access_expires_at
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

end
