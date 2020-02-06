class CreateOuras < ActiveRecord::Migration[6.0]
  def change
    create_table :ouras do |t|
      t.integer :user_id, :default => ""
      t.json :userinfo, :default => {}
      t.json :sleep, :default => {}
      t.json :activity, :default => {}
      t.json :readiness, :default => {}

      t.timestamps
    end
  end
end
