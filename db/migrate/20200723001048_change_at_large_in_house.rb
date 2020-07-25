class ChangeAtLargeInHouse < ActiveRecord::Migration[5.1]
  def change
    remove_column :house_members, :at_large, :string
    add_column :house_members, :at_large, :boolean
  end
end
