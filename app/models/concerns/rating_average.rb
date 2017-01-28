module RatingAverage
  extend ActiveSupport::Concern

  def rating_average
    self.ratings.average(:score)
  end

end