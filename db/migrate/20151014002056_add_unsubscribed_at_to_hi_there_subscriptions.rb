class AddUnsubscribedAtToHiThereSubscriptions < ActiveRecord::Migration
  def change
    add_column :hi_there_subscriptions, :unsubscribed_at, :datetime
    add_index :hi_there_subscriptions, :unsubscribed_at
  end
end
