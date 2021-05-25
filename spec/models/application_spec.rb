require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many(:pet_applications)}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_numericality_of(:zip)}
    it { should define_enum_for(:status)}
  end

  before :each do
    @dumb_friends = Shelter.create(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: false, rank: 7)
    @dpca = Shelter.create(name: 'Denver ASPCA', city: 'Denver, CO', foster_program: false, rank: 3)
    @max_fund = Shelter.create(name: 'Max Fund', city: 'Englewood, CO', foster_program: true, rank: 2)

    @nala = @dumb_friends.pets.create!(adoptable: true, age: 1, breed: 'Pit Bull Mix', name: 'Nala', shelter_id: @dumb_friends.id)
    @goose = @dumb_friends.pets.create!(adoptable: true, age: 3, breed: 'DSH', name: 'Goose', shelter_id: @dumb_friends.id)
    @bee = @max_fund.pets.create!(adoptable: true, age: 5, breed: 'Lab Mix', name: 'Bee', shelter_id: @max_fund.id)
    @tag = @max_fund.pets.create!(adoptable: true, age: 7, breed: 'Shepherd Mix', name: 'Tag', shelter_id: @max_fund.id)
    @sunni = @dpca.pets.create!(adoptable: true, age: 2, breed: 'Golden Retriever', name: 'Sunni', shelter_id: @dpca.id)
    @dooke = @dpca.pets.create!(adoptable: true, age: 4, breed: 'Husky Lab Mix', name: 'Dooke', shelter_id: @dpca.id)
    @sammie = @dpca.pets.create!(adoptable: true, age: 12, breed: 'Jack Russell Terrier', name: 'Sammie', shelter_id: @dpca.id)

    @jennifer = Application.create!(name: "Jennifer Smith", street_address: "1234 Oshtemo St.", city: "Denver", state: "CO", zip: 80003)
    @jefferson = Application.create!(name: "Jefferson Thomas", street_address: "4321 Michigan St.", city: "Morrison", state: "CO", zip: 18112)
    @haelyn = Application.create!(name: "Haelyn Brabson", street_address: "777 Happy Street.", city: "Arvada", state: "CO", zip: 80003)
  end

  describe "instance methods" do
    describe "#adopted_pets" do
      it "should add pet/s to an applicant" do
        expect(@jennifer.adopted_pets(@nala)).to eq([@nala])
      end
    end
  end
end
