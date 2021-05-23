class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state
  validates :zip, presence: true, numericality: true

  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications

  after_initialize  :default

  enum status: {"In Progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3}

  def default
    self.home_bio = " "
    self.status = 0
  end
end
