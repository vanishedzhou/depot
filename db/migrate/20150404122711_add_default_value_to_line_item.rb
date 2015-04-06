class AddDefaultValueToLineItem < ActiveRecord::Migration
  def change
    change_column_default :line_items, :quantity, 1
  end
end
