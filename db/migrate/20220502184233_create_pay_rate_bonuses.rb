class CreatePayRateBonuses < ActiveRecord::Migration[7.0]
  def up
    create_table :pay_rate_bonuses do |t|
      t.references :pay_rate, foreign_key: true, null: false
      t.float :rate_per_client, null: false
      t.integer :min_client_count
      t.integer :max_client_count

      t.check_constraint("COALESCE(min_client_count, max_client_count) IS NOT NULL")

      t.timestamps
    end

    # add_constraints
  end

  def down
    drop_table :pay_rate_bonuses
  end

  private

  # tried this method first, but SQLite doesn't accept alter table constraints
  # leaving here in case to a change to Postgres or MySQL
  def add_constraints
    execute <<~SQL
      ALTER TABLE pay_rates
        ADD CONSTRAINT client_count_limitation
        CHECK (COALESCE(min_client_count, max_client_count) IS NOT NULL )
    SQL
  end
end
