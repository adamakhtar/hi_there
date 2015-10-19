class RemoveEmailFromHiThereSubscriptions < ActiveRecord::Migration
  def up
    remove_column :hi_there_subscriptions, :email
  end

  def down
    add_column :hi_there_subscriptions, :email, :string
  end
end
