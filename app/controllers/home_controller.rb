class HomeController < ApplicationController
  def index
    @comics = ComicDecorator.decorate_collection(
      MarvelApi::SearchComics.call(search_term: params[:search_term])
    )
  end
end
