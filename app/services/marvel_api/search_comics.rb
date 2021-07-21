module MarvelApi
  class SearchComics < Client
    attr_reader :search_term, :options

    def initialize(search_term:, options:)
      @search_term = search_term
      @options = options

      super()
    end

    def call
      @character_id_list = MarvelApi::SearchCharacters.call(name: search_term)

      response = RestClient.get("https://gateway.marvel.com/v1/public/comics?", params)

      JSON.parse(response.body)["data"]
    rescue RestClient::Exception
      []
    end

    private

    def params
      {
        params: payload.merge(
          {
            orderBy: "-onsaleDate",
            noVariants: true,
            dateRange: "1949-01-01,#{Date.current}",
          }
        ).merge(character_hash).merge(options_hash),
      }
    end

    def character_hash
      return {} if search_term.blank?
      return {} if @character_id_list.blank?

      { characters: @character_id_list }
    end

    def options_hash
      return {} if @options.blank?

      { offset: options[:offset] }
    end
  end
end
