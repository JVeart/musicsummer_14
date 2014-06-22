class AddContactMail < ActiveRecord::Migration
  def change
    add_column :users, :contact_mail, :string
  end
end
