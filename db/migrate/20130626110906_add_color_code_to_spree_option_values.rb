class AddColorCodeToSpreeOptionValues < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :color_code, :string
  end
end
