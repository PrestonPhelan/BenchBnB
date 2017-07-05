class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true, presence: true
      t.string :password_digest, presence: true
      t.string :session_token, unique: true

      t.timestamps
    end
  end
end
