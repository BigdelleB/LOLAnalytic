class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :Username
      t.string :Region

      t.timestamps null: false
    end
  end
end
