class AddColumnsToNetworkMap < ActiveRecord::Migration[5.1]
  def change
    add_column :network_maps, :servicerstatus, :string
    add_column :network_maps, :self_servicing, :string
    add_column :network_maps, :provider_number, :string
    add_column :network_maps, :name, :string
    add_column :network_maps, :address, :string
    add_column :network_maps, :phone, :string
    add_column :network_maps, :fax, :string
    add_column :network_maps, :contracted, :string
    add_column :network_maps, :sealed_system, :string
    add_column :network_maps, :rating, :string
  end
end
