class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :product_id
      t.string :payment_xid

      t.timestamps
    end
  end
end
