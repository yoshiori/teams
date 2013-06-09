class User < ActiveRecord::Base
  attr_accessible :image, :name, :nickname, :uid

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.image = auth["info"]["image"]
    end
  end
end
