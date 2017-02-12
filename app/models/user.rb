class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 30}
  validates :password, length: {minimum: 4}, format: { with: /(\w*[A-Z]\w*[0-9]\w*)|(\w*[0-9]\w*[A-Z]\w*)/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.first.beer.style
  end

  def favorite_brewery
    return nil if ratings.empty?
    ratings.first.beer.brewery
  end

end
