require 'rails_helper'

describe "New Application display page" do

  it "can be accessed via link on pet index page" do
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
