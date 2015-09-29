require 'json'

class Alluc
  def initialize(string)
    #https://www.alluc.com/api/search/download/?apikey=1ca40c6e8c2ea9b1dad7fd44de022e41&query=big+buck+bunny&count=2&from=0&getmeta=0
    @base_url = "https://www.alluc.com/api/"
    @action   = "search/stream"

    @params = { apikey: "1ca40c6e8c2ea9b1dad7fd44de022e41", query: string}
  end

  def fetch
    url = URI.join(@base_url, @action)
    url.query = URI.encode_www_form(@params)

    puts url.to_s
    json = JSON.parse(Typhoeus.get(url.to_s).body)
    results = []

    if json["status"] == "success"
      json["result"].each do |result|
        return unless result["hosterurls"].size == 1

        results << result["hosterurls"].first["url"]
      end
    end

    results
  end
end
