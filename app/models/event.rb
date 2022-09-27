class Event < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, :date, presence: true
end
