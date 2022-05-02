class CreatePayRates < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_rates do |t|
      t.string :rate_name_char, null: false, limit: 50, index: true
      t.float :base_rate_per_client

      t.timestamps
    end
  end
end
