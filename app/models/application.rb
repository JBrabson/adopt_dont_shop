class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state
  validates :zip, presence: true, numericality: true

  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications

  enum status: {"In Progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3}

  def adopted_pets(pet)
    pets << pet
  end

  def pet_count
    pets.count
  end
end
