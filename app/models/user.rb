class User < ActiveRecord::Base
  attr_accessible :image, :name, :nickname, :uid

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true
end
