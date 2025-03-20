class AddColumnToConversations < ActiveRecord::Migration[8.0]
  def change
    add_column :conversations, :sender_seen, :datetime
    add_column :conversations, :receiver_seen, :datetime
  end
end
