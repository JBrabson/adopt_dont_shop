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

  it "Creates application and redirects to application show page where attributes are displayed" do
    visit '/applications/new'
    fill_in "Name", with: "Haelyn"
    fill_in "Street address", with: "777 Good Luck Lane"
    fill_in "City", with: "Arvada"
    fill_in "State", with: "CO"
    fill_in "Zip", with: 80003
    click_button "Submit"
    expect(page).to have_content("Haelyn")
    expect(page).to have_content("In Progress")
  end
end
