class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin, default: false, nil: false
      t.timestamps null: false
    end
  end
end
