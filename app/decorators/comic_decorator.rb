class ComicDecorator < ApplicationDecorator
  def comic_img_url
    "#{object['thumbnail']['path']}/portrait_uncanny.#{object['thumbnail']['extension']}"
  end
end
