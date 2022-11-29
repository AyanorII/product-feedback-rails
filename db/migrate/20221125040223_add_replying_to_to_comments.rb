class AddReplyingToToComments < ActiveRecord::Migration[7.0]
  def change
    # add_index :users, :username, unique: true
    add_column :comments,
               :replying_to,
               :string,
               foreign_key: {
                 to_table: :users,
                 to_column: :username
               }
    # add_foreign_key :comments,
    #                 :replying_to,
    #                 table: :users,
    #                 # column: :replying_to,
    #                 primary_key: :username
    # add_foreign_key :comments,
    #                 :replying_to,
    #                 to_table: :users
    # add_reference :comments, :replying_to, foreign_key: { to_table: :users }
    # add_foreign_key :comments,
    #                 :users,
    #                 column: :replying_to,
    #                 primary_key: :username
  end
end
