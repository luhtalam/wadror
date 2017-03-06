json.array!(@breweries) do |b|
  json.extract! b, :id, :name
  json.year b.year
  json.beers b.beers.count
end