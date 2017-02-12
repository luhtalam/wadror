require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.rating_average).to eq(15.0)
  end

  it "when ratings are given, are listed at ratings page" do
    create_beers_with_ratings(user, 12, 13,14,15,16)
    visit  ratings_path
    expect(page).to have_content('List of ratings')
    expect(page).to have_content('Number of ratings: 5')
  end

  it "when ratings are given, are listed at user page" do
    create_beers_with_ratings(user, 12, 13,14,15,16)
    visit  user_path(user)
    expect(page).to have_content('Pekka')
    expect(page).to have_content('Has made 5 ratings')
    expect(page).to have_content('Average rating: 14.0')
  end

  it "when ratings are deleted, they are removed from database" do
    create_beers_with_ratings(user, 12, 13,14,15,16)
    visit  user_path(user)
    expect{all('a', :text => 'delete')[1].click}.to change{Rating.count}.from(5).to(4)
  end

  it "has favorite brewery, beer and style, when has made at least one rating" do
    create_beers_with_ratings(user, 12, 13,14,15,16)
    visit user_path(user)
    expect(page).to have_content 'Favorite beer: anonymous'
    expect(page).to have_content 'Favorite brewery: anonymous'
    expect(page).to have_content 'Favorite beerstyle: Lager'
  end

end

def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end