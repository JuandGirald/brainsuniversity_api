class AddTypeToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :coupon_type, :string, default: '1'
  end
end
