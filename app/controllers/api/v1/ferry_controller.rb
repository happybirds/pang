class  Api::V1::FerryController < ActionController::Base
   def index


     mechanize = Mechanize.new
     page = mechanize.get("https://www.ferries.ca/ns-pei-ferry/schedule/")


     ary_ferry =[]

     page.search('.basic-table').each do |s|
      s.search('td').each do |t|
          ary_ferry << t.text.strip
      end
      
     end

    ary_h4 = []
    page.search('h4').each do |s|
          ary_h4 << s.text.strip
     end


   





     render json: {ary_h4: ary_h4,ary_ferry:ary_ferry}
   end

end
