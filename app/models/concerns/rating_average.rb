module RatingAverage
  extend ActiveSupport::Concern

  def rating_average
    return 0 if ratings.empty?
    ratings.average(:score)
  end

end