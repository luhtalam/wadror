class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 30}
  validates :password, length: {minimum: 4}, format: { with: /(\w*[A-Z]\w*[0-9]\w*)|(\w*[0-9]\w*[A-Z]\w*)/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password

end
