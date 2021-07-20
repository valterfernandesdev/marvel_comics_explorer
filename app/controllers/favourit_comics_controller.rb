class FavouritComicsController < ApplicationController
  def create
    @favourit_comic = FavouritComic.new(favourit_comics_params)

    render :error unless @favourit_comic.save
  end

  def destroy
    @favourit_comic = FavouritComic.find_by(favourit_comics_params)

    @favourit_comic.destroy
  rescue StandardError
    render :error
  end

  private

  def favourit_comics_params
    params.permit(:comic_id, :user_id)
  end
end
