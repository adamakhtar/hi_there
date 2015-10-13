class AddActivatedAtToHiThereSubscriptions < ActiveRecord::Migration
  def change
    add_column :hi_there_subscriptions, :activated_at, :datetime
    add_index :hi_there_subscriptions, :activated_at
  end
end
