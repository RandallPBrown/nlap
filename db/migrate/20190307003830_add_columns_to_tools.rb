class AddColumnsToTools < ActiveRecord::Migration[5.1]
  def change
    add_column :tools, :caller_name, :string
    add_column :tools, :service_provider, :string
    add_column :tools, :model_number, :string
    add_column :tools, :serial_number, :string
    add_column :tools, :failure_cause, :text
    add_column :tools, :warranty_link, :string
    add_column :tools, :sku, :string
    add_column :tools, :opp, :float
    add_column :tools, :ppc, :float
    add_column :tools, :lol, :float
    add_column :tools, :distributor, :string
    add_column :tools, :total_parts, :float
    add_column :tools, :total_labor, :float
    add_column :tools, :total_tax, :float
    add_column :tools, :total_mileage, :float
    add_column :tools, :total_misc, :float
    add_column :tools, :total_deductible, :float
    add_column :tools, :total_estimate, :float
    add_column :tools, :approved, :string
    add_column :tools, :diagnostic, :float
  end
end
