class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

  def today_events
    events.where('DATE(date) = ?', Date.today)
  end

  def comming_events
    events.where('date > ?', Date.today)
  end
end
