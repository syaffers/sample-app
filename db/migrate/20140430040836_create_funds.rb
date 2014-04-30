class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.float :needed
      t.float :collected

      t.timestamps
    end
  end
end
