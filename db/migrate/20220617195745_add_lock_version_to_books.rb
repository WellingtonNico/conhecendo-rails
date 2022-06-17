class AddLockVersionToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :lock_version, :integer, default: 0
  end
end
