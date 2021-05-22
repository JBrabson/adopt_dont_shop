require 'rails_helper'

RSpec.describe "Applications Index page" do
  it "lists all applications" do

    @jennifer = Application.create!(name: "Jennifer Brabson",
      street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003)
    @jefferson = Application.create!(name: "Jefferson Thomas",
      street_address: "4321 Michigan St.", city: "Morrison", state: "CO", zip: 80002)

    visit '/applications'
    expect(page).to have_content(@jennifer.name)
    expect(page).to have_content(@jennifer.status)
    # expect(page).to_not have_content(@jennifer.street_address)
    # expect(page).to_not have_content(@jennifer.home_bio)
    expect(page).to have_content(@jefferson.name)
    expect(page).to have_content(@jefferson.status)
    # expect(page).to_not have_content(@jefferson.street_address)
    # expect(page).to_not have_content(@jefferson.home_bio)
  end
end
