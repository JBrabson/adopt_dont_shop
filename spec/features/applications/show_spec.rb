require 'rails_helper'

RSpec.describe "Applications Show page" do
  before(:each) do
    Shelter.destroy_all
    Application.destroy_all
    @dumb_friends = Shelter.create(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: false, rank: 7)
    @jennifer = Application.create!(name: "Jennifer Brabson", street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003, status: "Pending", home_bio: "Old dogs need love, too.")
    @jefferson = Application.create!(name: "Jefferson Thomas", street_address: "4321 Michigan St.", city: "Morrison", state: "CO", zip: 80002, status: "Pending", home_bio: "Animals are the worlds' angels.")
    @dog_1 = @dumb_friends.pets.create!(adoptable: true, age: 1, breed: 'Pit Bull Mix', name: 'Nala', shelter_id: @dumb_friends.id)
    @cat_1 = @dumb_friends.pets.create!(adoptable: true, age: 3, breed: 'DSH', name: 'Goose', shelter_id: @dumb_friends.id)
    @dog_2 = @dumb_friends.pets.create!(adoptable: true, age: 5, breed: 'Lab Mix', name: 'Bee', shelter_id: @dumb_friends.id)
    @dog_3 = @dumb_friends.pets.create!(adoptable: true, age: 7, breed: 'Shepherd Mix', name: 'Tag', shelter_id: @dumb_friends.id)

    PetApplication.create!(pet_id: @dog_1.id, application_id: @jennifer.id)
    PetApplication.create!(pet_id: @cat_1.id, application_id: @jennifer.id)
    PetApplication.create!(pet_id: @dog_2.id, application_id: @jennifer.id)
    PetApplication.create!(pet_id: @dog_3.id, application_id: @jefferson.id)
  end

  it "displays applicant name, full address, bio and status" do
    visit "/applications/#{@jennifer.id}"
    expect(page).to have_content(@jennifer.name)
    expect(page).to have_content(@jennifer.street_address)
    expect(page).to have_content(@jennifer.city)
    expect(page).to have_content(@jennifer.state)
    expect(page).to have_content(@jennifer.zip)
    expect(page).to have_content(@jennifer.status)
    expect(page).to have_content(@jennifer.home_bio)

    visit "/applications/#{@jefferson.id}"
    expect(page).to have_content(@jefferson.name)
    expect(page).to have_content(@jefferson.street_address)
    expect(page).to have_content(@jefferson.city)
    expect(page).to have_content(@jefferson.state)
    expect(page).to have_content(@jefferson.zip)
    expect(page).to have_content(@jefferson.status)
    expect(page).to have_content(@jefferson.home_bio)
  end

  it "names all the pets the applicant wishes to apply for" do
    visit "/applications/#{@jennifer.id}"
    expect(page).to have_content(@dog_1.name)
    expect(page).to have_content(@cat_1.name)
    expect(page).to have_content(@dog_2.name)
    visit "/applications/#{@jefferson.id}"
    expect(page).to have_content(@dog_3.name)
  end

end
