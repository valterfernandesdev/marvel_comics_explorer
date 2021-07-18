module MarvelApi
  class Client < ApplicationService
    attr_reader :ts

    def initialize
      @ts = Time.zone.now.to_s
    end

    private

    def payload
      {
        apikey: Rails.application.credentials[:marvel][:public_key],
        ts: ts,
        hash: Digest::MD5.hexdigest(md5_hash_values),
      }
    end

    def md5_hash_values
      ts + Rails.application.credentials[:marvel][:private_key] + Rails.application.credentials[:marvel][:public_key]
    end
  end
end
