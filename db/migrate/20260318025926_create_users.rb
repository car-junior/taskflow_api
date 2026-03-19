class CreateUsers < ActiveRecord::Migration[7.1]
  def up
    execute('CREATE SCHEMA IF NOT EXISTS dbo')
    create_table 'dbo.users' do |u|
      u.string :name, null: false, limit: 100
      u.string :last_name, null: false, limit: 100
      u.string :email, null: false
      u.string :password_digest, null: false
      u.string :cpf, null: false, limit: 11
      u.string :phone_number, null: false
      u.boolean :active, null: false, default: true
      u.timestamps

      u.index :email, unique: true
      u.index :cpf, unique: true
      u.index :phone_number, unique: true
    end
  end

  def down
    drop_table 'dbo.users'
  end
end
