class ComicDecorator < ApplicationDecorator
  def comic_img_url
    "#{object['thumbnail']['path']}/portrait_xlarge.#{object['thumbnail']['extension']}"
  end
end
