class CreateHiThereSubscribers < ActiveRecord::Migration
  def change
    create_table :hi_there_subscribers do |t|
      t.string   :email
      t.timestamps null: false
    end
  end
end
