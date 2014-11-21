require_relative '../config'

class AddTypeToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :type, :string
  end
end