class FavouritComic < ApplicationRecord
  validates :comic_id, :user_id, presence: true
  validates :comic_id, uniqueness: { scope: :user_id }
end