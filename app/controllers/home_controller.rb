class HomeController < ApplicationController
  def index
    @comics = SearchComics.call(title: params[:title])
  end
end
