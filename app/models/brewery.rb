class Brewery < ActiveRecord::Base
  include RatingAverage

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    validates :name , length: {minimum: 1}
    validates :year, numericality: {greater_than_or_equal_to:  1042, only_integer: true}
    validate :year_cannot_be_in_the_future


  def year_cannot_be_in_the_future
    if year > Date.today().year
      errors.add(:year, "year can't be in the future")
    end

  end

    def to_s
        return self.name
    end


end
