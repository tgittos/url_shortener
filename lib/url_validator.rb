require 'net/http'

class UrlValidator
    def self.validate(url)
        begin
            if (url =~ /^http:\/\//).nil?
                url = "http://#{url}"
            end
            uri = URI(url)

            Net::HTTP.start(uri.host, uri.port) do |http|
                http.head('/')
                true
            end
        rescue SocketError => err
            false
        rescue Exception => err
            Rails.logger.info "[UrlValidator.validate] unexpected error for url #{url}: #{err.inspect}"
            false
        end
    end
end