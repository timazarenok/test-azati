class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :events, dependent: :destroy
end
