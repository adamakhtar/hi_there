class AddIssueNumberToHiThereEmails < ActiveRecord::Migration
  def change
    add_column :hi_there_emails, :issue_number, :integer
    add_index :hi_there_emails, :issue_number
  end
end
