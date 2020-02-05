class CreateOuras < ActiveRecord::Migration[6.0]
  def change
    create_table :ouras do |t|
      t.integer :user_id
      t.json :userinfo
      t.json :sleep
      t.json :activity
      t.json :readiness

      t.timestamps
    end
  end
end
