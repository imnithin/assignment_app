class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.string :name
      t.text :detail

      t.timestamps
    end
  end
end
