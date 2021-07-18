class SearchComics < ApplicationService
  attr_reader :title, :ts

  def initialize(title:)
    @title = title
    @ts = Time.zone.now.to_s
  end

  def call
    response = RestClient.get("https://gateway.marvel.com/v1/public/comics", payload)

    JSON.parse(response.body)["data"]["results"]
  end

  private

  def payload
    {
      params: {
        orderBy: "-onsaleDate",
        formatType: "comic",
        apikey: Rails.application.credentials[:marvel][:public_key],
        ts: ts,
        hash: Digest::MD5.hexdigest(md5_hash_values),
      }.merge(title_hash),
    }
  end

  def title_hash
    return {} if title.blank?

    { title: title }
  end

  def md5_hash_values
    ts + Rails.application.credentials[:marvel][:private_key] + Rails.application.credentials[:marvel][:public_key]
  end
end
