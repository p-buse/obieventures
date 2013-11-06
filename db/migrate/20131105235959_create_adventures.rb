class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :summary
      t.string :details

      t.timestamps
    end
  end
end
