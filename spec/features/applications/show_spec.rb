require 'rails_helper'

describe "Applications Show page" do
  before(:each) do
    @dumb_friends = Shelter.create(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: false, rank: 7)
    @jennifer = Application.create!(name: "Jennifer Brabson", street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003)
    @jefferson = Application.create!(name: "Jefferson Thomas", street_address: "4321 Michigan St.", city: "Morrison", state: "CO", zip: 80002)
    @dog_1 = @dumb_friends.pets.create!(adoptable: true, age: 1, breed: 'Pit Bull Mix', name: 'Nala', shelter_id: @dumb_friends.id)
    @cat_1 = @dumb_friends.pets.create!(adoptable: true, age: 3, breed: 'DSH', name: 'Goose', shelter_id: @dumb_friends.id)
    @dog_2 = @dumb_friends.pets.create!(adoptable: true, age: 5, breed: 'Lab Mix', name: 'Bee', shelter_id: @dumb_friends.id)
    @dog_3 = @dumb_friends.pets.create!(adoptable: true, age: 7, breed: 'Shepherd Mix', name: 'Tag', shelter_id: @dumb_friends.id)
    @jennifer.pets.push(@dog_1)
    #  PetApplication.create!(application_id: @jennifer.id, pet_id: @dog_1.id)
    #  Line 13 akin to Line 12
    visit "/applications/#{@jennifer.id}"
  end

  it "displays applicant name, full address, bio and status" do
    expect(current_path).to eq("/applications/#{@jennifer.id}")
    expect(page).to have_content(@jennifer.name)
    expect(page).to have_content(@jennifer.street_address)
    expect(page).to have_content(@jennifer.city)
    expect(page).to have_content(@jennifer.state)
    expect(page).to have_content(@jennifer.zip)
    expect(page).to have_content(@jennifer.status)
    expect(page).to have_content(@jennifer.home_bio)
  end

  it "displays search pets feature if application not yet been submitted" do
    expect(current_path).to eq("/applications/#{@jennifer.id}")
    expect(page).to have_field(:search)
    fill_in "Search", with: "Nala"
    click_button "Search"

    expect(current_path).to eq("/applications/#{@jennifer.id}")
    expect(page).to have_content(@dog_1.name)
    expect(page).to have_content(@dog_1.age)
    expect(page).to have_content(@dog_1.breed)
    expect(page).to have_content(@dog_1.adoptable)
  end

  it "allows addition of pets to application with input for home bio and redirect to show page after submission" do
    expect(current_path).to eq("/applications/#{@jennifer.id}")
    fill_in "Search", with: "Nala"
    click_button "Search"
    click_button "Adopt this Pet"
    expect(page).to have_content("Nala")
    expect(page).to have_field("Reason")
    expect(page).to have_button("Submit Application")
    fill_in "Reason", with: "Look at that face!"
    click_button "Submit Application"
    expect(current_path).to eq("/applications/#{@jennifer.id}")
    expect(page).to have_content("#{@dog_1.name}")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("TBD")
    expect(page).to_not have_button("Search")
  end

end
