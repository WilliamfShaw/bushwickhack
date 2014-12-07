class MapsController < ApplicationController

	def index
		@start_address = params[:start]
		@end_address = params[:end]
		if (params[:start] && params[:end])
			start_response = Geocoder.search(params[:start])
			if start_response != []
				start_address = start_response[0].data["geometry"]["location"]
				start_lat = start_address["lat"]
				start_lng = start_address["lng"]
			end

			end_response = Geocoder.search(params[:end])
			if end_response != []
				end_address = end_response[0].data["geometry"]["location"]
				end_lat = end_address["lat"]
				end_lng = end_address["lng"]
			end

			if start_response && end_response
				@end_lat = end_lat
				@end_lng = end_lng
				@start_lat = start_lat
				@start_lng = start_lng
				@mid_lat = (@start_lat + @end_lat)/2
				@mid_lng = (@start_lng + @end_lng)/2
				@start_locations = Apiuser.get_four_square_info(start_lat,start_lng)
				@end_locations = Apiuser.get_four_square_info(end_lat,end_lng)
				@mid_locations = Apiuser.get_four_square_info(@mid_lat,@mid_lng)
			end
		else
			@start_locations = Apiuser.get_four_square_info(40.7108500,-73.9339270)
			@mid_locations = Apiuser.get_four_square_info((40.7108500 + 40.7158757)/2, (-73.9339270 + -73.9280905)/2)
			@end_locations = Apiuser.get_four_square_info(40.7158757, -73.9280905)
		end
	end
end
