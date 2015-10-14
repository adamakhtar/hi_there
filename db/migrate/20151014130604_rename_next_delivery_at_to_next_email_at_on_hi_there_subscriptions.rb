class RenameNextDeliveryAtToNextEmailAtOnHiThereSubscriptions < ActiveRecord::Migration
  def change
    rename_column :hi_there_subscriptions, :next_delivery_at, :next_email_at 
  end
end
