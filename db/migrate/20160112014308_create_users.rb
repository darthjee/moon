class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :authentication_token
      t.string :code
      t.timestamps
    end

    add_column :marriage_invites, :user_id, :integer

    Marriage::Invite.all.each do |invite|
      attributes = invite.attributes.slice(*%w(
        email authentication_token code
      ))
      attributes.merge!(
        name: invite.guests.last.try(:name)
      )

      user = User.create(attributes)
      invite.update(user_id: user.id)
    end
  end

  def down
    drop_table :users

    remove_column :marriage_invites, :user_id, :integer
  end
end
