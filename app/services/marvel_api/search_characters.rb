module MarvelApi
  class SearchCharacters < Client
    attr_reader :name

    def initialize(name:)
      @name = name

      super()
    end

    def call
      response = RestClient.get("https://gateway.marvel.com/v1/public/characters?", params)

      character_ids(JSON.parse(response.body)["data"]["results"])
    rescue RestClient::Exception
      ""
    end

    private

    def character_ids(results)
      return "" if results.blank?

      ids = ""

      results.each do |result|
        ids += "#{result['id']}," and next unless result.equal? results.last

        ids += result["id"].to_s
      end

      ids
    end

    def params
      { params: payload.merge({ orderBysasd: "name" }).merge(character_hash) }
    end

    def character_hash
      return {} if name.blank?

      { nameStartsWith: name }
    end
  end
end
