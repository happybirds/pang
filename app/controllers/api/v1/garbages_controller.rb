class  Api::V1::GarbagesController < ActionController::Base
   def index
    mechanize = Mechanize.new

    street_no = ''
    street_nm = 'beach grove'

    page = mechanize.get("http://www.gov.pe.ca/civicaddress/locator/index.php3?showsections=&zoominmap=YES&street_no=#{street_no}&street_nm=#{street_nm}&street_abbrev=&action=Find+this+Address")

    ary=[]
    _ary=[]
        page.links.each_with_index do |link,index|
            # puts link.uri
             ary << [link.uri,link.text]
        end

       page =  mechanize.get("http://www.gov.pe.ca/civicaddress/locator/details.php3?county=QUN&street_no=47&street_nm=BEACH%20GROVE%20RD&comm_nm=CHARLOTTETOWN&zoominmap=YES&showsections=")
         
        b=[]
        s = ""

        page.search('tr').each do |a|
        s += a.text
        end

        waste = s.index("Waste Watch Collection Information")

        emergency =  s.index("Emergency Service Providers")

        waste_all =  s[waste..emergency]

         render json: {waste_all: waste_all}
   end

   def detail

        mechanize = Mechanize.new

        # street_no = ''
        # street_nm = 'beach grove'

        # page = mechanize.get("http://www.gov.pe.ca/civicaddress/locator/index.php3?showsections=&zoominmap=YES&street_no=#{street_no}&street_nm=#{street_nm}&street_abbrev=&action=Find+this+Address")

        # ary=[]
        # _ary=[]
        # page.links.each_with_index do |link,index|
        #     # puts link.uri
        #      ary << [link.uri,link.text]
        # end
      

       url =  "http://www.gov.pe.ca/civicaddress/#{params[:url][3,params[:url].length]}&street_no=#{params[:street_no]}&street_nm=#{params[:street_nm]}&comm_nm=#{params[:comm_nm]}&apt_no=#{params[:apt_no]}&zoominmap=YES&showsections="
      
       page =  mechanize.get(url)
        
    
        s = ""

        page.search('tr').each do |a|
        s += a.text
        end

        waste = s.index("Waste Watch Collection Information")

        blue = s.index("Blue Bag Collection:")

        cart = s.index("Cart Collection:")

        spring = s.index("Spring Clean Up:")

        fall = s.index("Fall Clean Up:")

        christams = s.index("Christmas Tree Collection:")

        cottage = s.index("Cottage Collection:")

        customer = s.index("Customer Service:")

        emergency =  s.index("Emergency Service Providers")

        top = s[waste..blue-1].gsub('    ','').strip

        blue = s[blue..cart-1].gsub('    ','').strip

        cart = s[cart..spring-1].gsub('    ','').strip

        spring = s[spring..fall-1].gsub('    ','').strip

        fall = s[fall..christams-1].gsub('    ','').strip

        christams=s[christams..cottage-1].gsub('    ','').strip

        cottage=s[cottage..customer-1].gsub('    ','').strip

        customer=s[customer..emergency-1].gsub('    ','').strip

        render json: {top: top,blue:blue,cart:cart,spring: spring,fall:fall,christams:christams,cottage:cottage,customer:customer}
   end

    def address
        mechanize = Mechanize.new
        page = mechanize.get("http://www.gov.pe.ca/civicaddress/locator/index.php3?showsections=&zoominmap=YES&street_no=#{params[:street_no]}&street_nm=#{params[:street_nm]}&street_abbrev=&action=Find+this+Address")
        ary=[]
        _ary=[]
        address=[]
        s=""
        sm=[]
        page.links.each_with_index do |link,index|
         _ary << link.uri.to_s
            
        if index > 3 
            if _ary[index-1] == link.uri.to_s 
          
            else
                address << link.uri.to_s
                sm << s
                s=""
            end
        end
        s+= link.text+" "
       
        end
        address.shift 
        address.pop
        address.pop
        address.pop
        address.pop

        sm.pop
        sm.pop
        sm.pop
        sm.shift
        sm.shift

h = Hash[sm.zip address]

        render json: {addurl: address,address: sm,ary: h} 
    end

end

