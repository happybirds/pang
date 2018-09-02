class ListsController < ApplicationController
	def index
		mechanize = Mechanize.new
		page = mechanize.get(ENV['TRAN'])
		n = page.at('p')
		@notice = n.text.strip if !n.nil?
		@route1daydir1 = Board.where(route_name: '1day',route_num: 1)
		@route1daydir2 = Board.where(route_name: '1day',route_num: 1).order('sort desc')
	end

	 def distance
	 	boards  = Board.where(route_name: params[:routes],route_num: params[:route_num])
		@dir = 9
		if params[:routes] == '1day'
			uri = URI(ENV['1DAY'] )
		end
    res = Net::HTTP.get(uri)
    bus_infos =  JSON.parse res
		c = {}
		_nh = []
		_distance = []
		_num = []

		bus_infos.each_with_index do |n,index|
			h = []
			boards.each do |b|
				d =  Geocoder::Calculations.distance_between([n['lat'],n['long']], [b.lat,b.long])
				if b.name.blank?
					c[d] = b.reverse_name
					c[b.reverse_name] = b.sort
				else
					c[d] = b.name
					c[b.name] = b.sort
				end
				h.push(d)
			end
			_nh.push(h.sort[0])
			_num.push(n['busNumber'])

		 if $redis.get(params[:routes]+"_" +n['busNumber'])
				if ($redis.get(params[:routes]+"_" +n['busNumber']).to_i < c[c[_nh[index]].to_i ) && (params[:direction].to_i == 1) || ($redis.get(params[:routes]+"_" + "direction1_flag"+n['busNumber']).to_i == 1)
						@dir = 1
						$redis.set(params[:routes]+"_" + "direction1_"+n['busNumber'],c[_nh[index])
						$redis.del(params[:routes]+"_" + "direction2_"+n['busNumber'])
						$redis.set(params[:routes]+"_" + "direction1_flag"+n['busNumber'],1)
						$redis.set(params[:routes]+"_" + "direction2_flag"+n['busNumber'],0)
						$redis.set(params[:routes]+"_"+n['busNumber'],c[c[_nh[index]])
			   elsif ($redis.get(params[:routes]+"_" +n['busNumber']).to_i > c[c[_nh[index]].to_i )  && (params[:direction].to_i == 2) || ($redis.get(params[:routes]+"_" + "direction2_flag"+n['busNumber']).to_i == 1)
						@dir = 2
						$redis.set(params[:routes]+"_" + "direction2_"+n['busNumber'],c[_nh[index])
						$redis.del(params[:routes]+"_" + "direction1_"+n['busNumber'])
						$redis.set(params[:routes]+"_" + "direction1_flag"+n['busNumber'],0)
						$redis.set(params[:routes]+"_" + "direction2_flag"+n['busNumber'],1)
						$redis.set(params[:routes]+"_"+n['busNumber'],c[c[_nh[index]])
			   end

		 else
				$redis.set(params[:routes]+"_"+n['busNumber'],c[c[_nh[index]])
		 end
		end
		bus_num = []
		_num.each do |n|
			if $redis.get(params[:routes]+"_" + "direction#{@dir}_"+n)
				 _distance.push($redis.get(params[:routes]+"_" + "direction#{@dir}_"+n).split('_')[0])
				 bus_num.push(n)
			end

		end
		@bus_num = bus_num
		@distance =  _distance
	 end
end
