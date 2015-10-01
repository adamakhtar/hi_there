class AddNextIssueNumberAndNextDeliveryAtToHiThereSubscriptions < ActiveRecord::Migration
  def change
    add_column :hi_there_subscriptions, :next_issue_number, :integer
    add_column :hi_there_subscriptions, :next_delivery_at, :datetime
  end
end
