class AddTokenToHiThereSubscriptions < ActiveRecord::Migration
  def change
    add_column :hi_there_subscriptions, :token, :string
    add_index :hi_there_subscriptions, :token
  end
end
