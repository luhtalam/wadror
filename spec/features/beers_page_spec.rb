require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:user){FactoryGirl.create(:user)}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is added with a name" do
    visit new_beer_path
    fill_in('beer[name]', with: "testiolut")
    select('Weizen', from: 'beer[style]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "is not added without a name" do
    visit new_beer_path
    select('Weizen', from: 'beer[style]')

    expect{
      click_button "Create Beer"
    }.to_not change{Beer.count}.from(0)

    expect(page).to have_content "Name can't be blank"
  end
end