class AddStockToBook < ActiveRecord::Migration[5.2]
  def up
    add_column :books, :stock, :integer
    Book.reset_column_information
    Book.update_all(stock:1)
  end

  def down
    remove_column :books, :stock
  end
end
