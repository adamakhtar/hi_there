class AddNextAndPreviousEmailIdToHiThereSubscriptions < ActiveRecord::Migration
  def up
    remove_column :hi_there_subscriptions, :next_issue_number
    add_column :hi_there_subscriptions, :next_email_id, :integer
    add_column :hi_there_subscriptions, :previous_email_id, :integer

    add_index :hi_there_subscriptions, :next_email_id
    add_index :hi_there_subscriptions, :previous_email_id
  end

  def down
    add_column :hi_there_subscriptions, :next_issue_number, :integer 
    remove_column :hi_there_subscriptions, :next_email_id
    remove_column :hi_there_subscriptions, :previous_email_id
  end
end
