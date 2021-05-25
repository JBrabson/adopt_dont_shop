require 'rails_helper'

RSpec.describe "Applications Show page" do
  before(:each) do
    Shelter.destroy_all
    Application.destroy_all
    @dumb_friends = Shelter.create(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: false, rank: 7)
    @jennifer = Application.create!(name: "Jennifer Brabson", street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003, status: 0, home_bio: "Old dogs need love, too.")
    @jefferson = Application.create!(name: "Jefferson Thomas", street_address: "4321 Michigan St.", city: "Morrison", state: "CO", zip: 80002, status: 1, home_bio: "Animals are the worlds' angels.")
    @dog_1 = @dumb_friends.pets.create!(adoptable: true, age: 1, breed: 'Pit Bull Mix', name: 'Nala', shelter_id: @dumb_friends.id)
    @cat_1 = @dumb_friends.pets.create!(adoptable: true, age: 3, breed: 'DSH', name: 'Goose', shelter_id: @dumb_friends.id)
    @dog_2 = @dumb_friends.pets.create!(adoptable: true, age: 5, breed: 'Lab Mix', name: 'Bee', shelter_id: @dumb_friends.id)
    @dog_3 = @dumb_friends.pets.create!(adoptable: true, age: 7, breed: 'Shepherd Mix', name: 'Tag', shelter_id: @dumb_friends.id)
    #
    # PetApplication.create!(pet_id: @dog_1.id, application_id: @jennifer.id)
    # PetApplication.create!(pet_id: @cat_1.id, application_id: @jennifer.id)
    # PetApplication.create!(pet_id: @dog_2.id, application_id: @jennifer.id)
    # PetApplication.create!(pet_id: @dog_3.id, application_id: @jefferson.id)
    visit "/applications/#{@jennifer.id}"
  end

  it "displays applicant name, full address, bio and status" do
    expect(page).to have_content(@jennifer.name)
    expect(page).to have_content(@jennifer.street_address)
    expect(page).to have_content(@jennifer.city)
    expect(page).to have_content(@jennifer.state)
    expect(page).to have_content(@jennifer.zip)
    expect(page).to have_content(@jennifer.status)
    expect(page).to have_content(@jennifer.home_bio)
  end

  # it "names all the pets the applicant wishes to apply for" do
  #   expect(page).to have_content(@dog_1.name)
  #   expect(page).to have_content(@cat_1.name)
  #   expect(page).to have_content(@dog_2.name)
  # end

  describe "if an application has not yet been submitted" do
    it "has feature to search for pets by name and add to application" do
    aspca = Shelter.create(name: 'ASPCA', city: 'Denver, CO', foster_program: false, rank: 7)
    jen = Application.create!(name: "Jen", street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003)
    jeff = Application.create!(name: "Jeff", street_address: "4321 Somewhere Lane", city: "Not Denver", state: "Not CO", zip: 30008, status: "Pending")
    dog1 = aspca.pets.create!(adoptable: true, age: 1, breed: 'Pit Bull Mix', name: 'Nala', shelter_id: @dumb_friends.id)
    cat1 = aspca.pets.create!(adoptable: true, age: 3, breed: 'DSH', name: 'Goose', shelter_id: @dumb_friends.id)
    dog2 = aspca.pets.create!(adoptable: true, age: 5, breed: 'Lab Mix', name: 'Bee', shelter_id: @dumb_friends.id)
      expect(page).to have_content("In Progress")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("Search")
      fill_in "Search", with: "Nala"
      click_button "Search"
      expect(page).to have_content("Nala")
      expect(page).to_not have_content("Goose")
      
      visit "/applications/#{jeff.id}"
      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Add a Pet to this Application")
    end
  end

end
