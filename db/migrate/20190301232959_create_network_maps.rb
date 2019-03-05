class CreateNetworkMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :network_maps do |t|

      t.timestamps
    end
  end
end
