class HomeController < ApplicationController
  def index
    @comics = MarvelApi::SearchComics.call(search_term: params[:search_term])
  end
end
