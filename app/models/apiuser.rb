class Apiuser

  def self.make_four_square_request(lat,long)
    HTTParty.get("https://api.foursquare.com/v2/venues/explore?ll=" + lat.to_s + "," + long.to_s + "&openNow=1&limit=150&client_id=#{ENV['FOUR_SQUARE_ID']}&client_secret=#{ENV['FOUR_SQUARE_PW']}&v=20141206&m=foursquare")["response"]["groups"][0]["items"]
  end

  def self.get_four_square_info(lat,long)
    places = make_four_square_request(lat,long)
    placeInfo = []
    places.each do |place|
      placehash = {}
      placehash[:name] = place["venue"]["name"]
      placehash[:long] = place["venue"]["location"]["lng"]
      placehash[:lat] = place["venue"]["location"]["lat"]
      placehash[:address] = place["venue"]["location"]["address"]
      placehash[:category] = place["venue"]["categories"][0]["name"]
      placehash[:open_until] = place["venue"]["hours"]["status"]
      placehash[:here_now] = place["venue"]["hereNow"]["count"]
      placeInfo.push(placehash)
    end
    return placeInfo
  end

  def self.get_current_location
    location = Geocoder.search(HTTParty.get('http://api.ipify.org?format=json')["ip"])[0]
    lat = location.data["latitude"]
    long = location.data["longitude"]
    return {lat: lat, long: long}
  end

end
