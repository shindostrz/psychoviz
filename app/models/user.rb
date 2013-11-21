class User < ActiveRecord::Base
  attr_accessible :image, :location, :name, :oauth_expires_at, :oauth_token, :provider, :timezone, :uid

  has_one :score

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.location = auth.info.location
      user.timezone = auth.extra.timezone
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
