class AddSubscriberIdToHiThereSubscriptions < ActiveRecord::Migration
  def change
    add_column :hi_there_subscriptions, :subscriber_id, :integer
    add_index :hi_there_subscriptions, :subscriber_id
  end
end
