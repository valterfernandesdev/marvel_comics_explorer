module MarvelApi
  class SearchComics < Client
    attr_reader :search_term

    def initialize(search_term:)
      @search_term = search_term

      super()
    end

    def call
      @character_id_list = MarvelApi::SearchCharacters.call(name: search_term)

      response = RestClient.get("https://gateway.marvel.com/v1/public/comics?", params)

      JSON.parse(response.body)["data"]["results"]
    rescue RestClient::Exception
      []
    end

    private

    def params
      { params: payload.merge({ orderBy: "-onsaleDate", formatType: "comic" }).merge(character_hash) }
    end

    def character_hash
      return {} if search_term.blank?
      return {} if @character_id_list.blank?

      { characters: @character_id_list }
    end
  end
end
