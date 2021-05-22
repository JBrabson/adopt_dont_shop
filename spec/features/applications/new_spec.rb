require 'rails_helper'

RSpec.describe "New Application display page" do
  it "When I visit the pet index page, I can click a link to be taken to new application" do
    visit '/pets'
    expect(page).to have_link("Start an Application")
    click_link("Start an Application")
    expect(page).to have_current_path("/applications/new")
    expect(find('form')).to have_content("Name")
    expect(find('form')).to have_content("Street address")
    expect(find('form')).to have_content("City")
    expect(find('form')).to have_content("State")
    expect(find('form')).to have_content("Zip")
    expect(find('form')).to have_button("Submit")
  end
end
