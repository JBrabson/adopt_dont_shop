class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state
  validates_presence_of :zip, numericality: true
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy
  after_initialize  :default

  def default
    self.home_bio = " "
    self.status = "Pending"
  end
end
