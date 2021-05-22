require 'rails_helper'

RSpec.describe "Create Application" do
  it "After submitting application it redirects to application show page
      where I see application, attributes, and 'In Progress' application status" do

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
end
