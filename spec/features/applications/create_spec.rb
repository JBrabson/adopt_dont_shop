require 'rails_helper'

describe "Create Application" do

  it "creates application and redirects to show page where attributes and 'In Progress' status are displayed" do
    visit '/applications/new'
    fill_in "Name", with: "Jenny B"
    fill_in "Street address", with: "1234 Happy Lane"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: 12345
    click_button "Submit Application"

    expect(page).to have_content("Jenny B")
    expect(page).to have_content("1234 Happy Lane")
    expect(page).to have_content("In Progress")
  end

  it "displays error message if form submitted with incomplete fields" do
    visit '/applications/new'
    click_on 'Submit'

    expect(page).to have_content("ERROR: Missing required information.")
 end
end
