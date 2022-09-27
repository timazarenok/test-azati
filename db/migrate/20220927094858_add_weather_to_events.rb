class AddWeatherToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :weather, :string
  end
end
