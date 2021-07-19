class HomeController < ApplicationController
  def index
    @comics_data = MarvelApi::SearchComics.call(search_term: params[:search_term], options: { offset: params[:offset] })
    @comics = ComicDecorator.decorate_collection(@comics_data["results"])
  end
end
