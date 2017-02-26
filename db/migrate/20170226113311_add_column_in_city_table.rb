class AddColumnInCityTable < ActiveRecord::Migration
  def change
  	add_column :cities, :latitude, :float
  	add_column :cities, :longitude, :float
  	add_column :states, :country_id, :integer
  end
end
