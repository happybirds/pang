class  Api::V1::BridgeController < ActionController::Base
   def index
     mechanize = Mechanize.new
     page = mechanize.get("https://www.confederationbridge.com/")
     advisory_type =   page.search('.advisory_type')[0].text
     advisory_message =  page.search('.advisory_message')[0].text
     wide_load_advisory = [] 
     if page.search('.wide_load_advisory')[0]
        wide_load_advisory =  page.search('.wide_load_advisory')[0].text.gsub("\t","").gsub("\n","") 
     end



     ary =[]

     page.search('tr td').each do |s|
       ary << s.text.strip
     end









     render json: {current_wind_speed: ary,advisory_type: advisory_type, advisory_message: advisory_message,wide_load_advisory: wide_load_advisory}
   end

end
