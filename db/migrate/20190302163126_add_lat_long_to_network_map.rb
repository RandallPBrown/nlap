class AddLatLongToNetworkMap < ActiveRecord::Migration[5.1]
  def change
    add_column :network_maps, :latitude, :float
    add_column :network_maps, :longitude, :float
  end
end
