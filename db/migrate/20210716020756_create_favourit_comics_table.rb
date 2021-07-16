class CreateFavouritComicsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :favourit_comics do |t|
      t.bigint :comic_id, null: false
      t.uuid :user_id, null: false
      t.timestamps
    end
  end
end
