class  Api::V1::AirportController < ActionController::Base
   def index



     ary_port = []
     mechanize = Mechanize.new
     page = mechanize.get("https://www.flightstats.com/go/weblet?guid=34b64945a69b9cac:46cf2cff:137a5643c65:-5b5f&imageColor=Grey&language=English&weblet=status&action=AirportFlightStatus&airportCode=YYG&airportQueryType=1")

     page.search('.tableListingTable td').each do |s|
        ary_port << s.text.strip.gsub("\r\n","").gsub("         ","")
     end







     render json: {ary_port: ary_port}
   end

end
