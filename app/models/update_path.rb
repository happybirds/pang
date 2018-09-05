class UpdatePath

  def self.update(routes,route_num,direction)

    boards  = Board.where(route_name: routes,route_num: route_num)

    board_count = Board.where(route_name: routes,route_num: route_num).where.not(name: '').last.sort

    @dir = 9
    # if routes == '1day'
      uri = URI(ENV[routes] )
    # end
      res = Net::HTTP.get(uri)
      bus_infos =  JSON.parse res
    c = {}
    _nh = []
    # _nh = []
    _distance = []

    _num = []

      _num1 = {}
        _num2= {}
    @finish_bus = []

    @is_true = false


    yy = ''

    $redis.set("distance_"+routes+"_" + "direction#{direction}_true",false)

    bus_infos.each_with_index do |n,index|
      h = []
      # h = []
      boards.each do |b|
        d =  Geocoder::Calculations.distance_between([n['lat'],n['long']], [b.lat,b.long])

        if !b.name.blank?
          c[d] = b.name
          c[b.name] = b.sort
          h.push(d)
        else
          c[d] = b.reverse_name
          c[b.reverse_name] = b.sort
          h.push(d)
        end

      end

      if h.sort[0] > 0.5
        $redis.del(routes+"_" + "direction2_"+n['busNumber'])
        $redis.del(routes+"_" + "direction1_"+n['busNumber'])
        $redis.del(routes+"_" + "direction2_flag"+n['busNumber'])
        $redis.del(routes+"_" + "direction1_flag"+n['busNumber'])
        $redis.del(routes+"_" +n['busNumber'])
        break
      end
      _nh.push(h.sort[0])
      # _nh.push(h.sort[0])

      _num.push(n['busNumber'])

     if $redis.get(routes+"_" +n['busNumber'])


        if  ($redis.get(routes+"_" + "direction1_flag"+n['busNumber']).to_i == 1) || ($redis.get(routes+"_" +n['busNumber']).to_i < c[c[_nh[index]]].to_i  && direction.to_i == 1)
            # p c[c[_nh[index]]].to_i
            _num1[n['busNumber']] = 1
            _num2.delete(n['busNumber'])

            @dir = 1
            if($redis.get(routes+"_" +n['busNumber']).to_i == board_count )
              # $redis.set(routes+"_"+n['busNumber'],board_count)
              $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],1)
              $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],0)
              p '正面结束！！！！'
              yy = '正面结束！！！！'
              # $redis.set(routes+"_" + "direction1_"+n['busNumber'],c[_nh[index]])
              # $redis.set(routes+"_" + "direction1_finish_"+@finish_bus,true)
              break
            end
            # p '正面---start-----'
            # p direction.to_i
            # p "bus: ----#{n['busNumber']}----}"
            # p $redis.get(routes+"_" +n['busNumber']).to_i
            # p c[c[_nh[index]]].to_i
            # p _nh[index]
            # p c[_nh[index]]
            # p '正面---over-----'




            @dir = 1
            $redis.set(routes+"_" + "direction1_"+n['busNumber'],c[_nh[index]])
            $redis.del(routes+"_" + "direction2_"+n['busNumber'])
            $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],1)
            $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],0)
            $redis.set(routes+"_"+n['busNumber'],c[c[_nh[index]]])
         elsif   ($redis.get(routes+"_" + "direction2_flag"+n['busNumber']).to_i == 1) || ($redis.get(routes+"_" +n['busNumber']).to_i > c[c[_nh[index]]].to_i   && direction.to_i == 2)
            # p board_re_name_count
            # p $redis.get(routes+"_" +n['busNumber'])
            @dir = 2

            _num2[n['busNumber']] = 2
            _num1.delete(n['busNumber'])

            if($redis.get(routes+"_" +n['busNumber']).to_i == 1 )
              # $redis.set(routes+"_"+n['busNumber'],1)
              $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],0)
              $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],1)
              p '反面结束！！！！'
              # $redis.set(routes+"_" + "direction2_"+n['busNumber'],c[_nh[index]])
              yy = '反面结束！！！！'
              break
            end


            # p '反面--start-----'
            # p direction.to_i
            # p "bus: ----#{n['busNumber']}----}"
            # p c[c[_nh[index]]].to_i
            # p _nh[index]
            # p c[_nh[index]]
            # p '反面---over------'
            #
            # p c[c[_nh[index]]].to_i
            # p _nh[index]
            $redis.set(routes+"_" + "direction2_"+n['busNumber'],c[_nh[index]])
            $redis.del(routes+"_" + "direction1_"+n['busNumber'])
            $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],0)
            $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],1)
            $redis.set(routes+"_"+n['busNumber'],c[c[_nh[index]]])

         end



     else
        $redis.set(routes+"_"+n['busNumber'],c[c[_nh[index]]])
     end
    end
    # binding.pry
    bus_num = []
    route1daydir1 = JSON.parse $redis.get('route1daydir1')
    route1daydir2 = JSON.parse $redis.get('route1daydir2')

    _num.each do |n|
      if !$redis.get(routes+"_" + "direction#{@dir}_"+n).blank?

        bus_name = $redis.get(routes+"_" + "direction#{@dir}_"+n)
p bus_name
        if @dir == 1 && (route1daydir1.include? bus_name)
          p _num1[n]
          if _num1[n]
            if boards.first.name == bus_name
              @finish_bus.push(bus_name.split('_')[0]+","+n)
            end
              _distance.push(bus_name.split('_')[0] +","+n)

           $redis.set("distance_"+routes+"_" + "direction#{direction}_true",true)
         end
        end

        if @dir == 2 && (route1daydir2.include? bus_name)
          p _num2[n]
  if _num2[n]
          if boards.first.reverse_name == bus_name
            @finish_bus.push(bus_name.split('_')[0]+","+n)
          end
            _distance.push(bus_name.split('_')[0] +","+n)

          $redis.set("distance_"+routes+"_" + "direction#{direction}_true",true)
end
        end

          bus_num.push(n)

      end

    end
    @bus_num = bus_num
    @distance =  _distance

#      p '显示的距离===start===='
#      p @distance
#      p @finish_bus
# p direction
# distance_1day_direction2_finish

  $redis.set("distance_"+routes+"_" + "direction1_finish",nil)
  $redis.set("distance_"+routes+"_" + "direction2_finish",nil)
    if @dir == 1
         $redis.set("distance_"+routes+"_" + "direction1",@distance)
        # $redis.set("distance_"+routes+"_" + "direction1_finish",@finish_bus)
    end

    if @dir == 2
         $redis.set("distance_"+routes+"_" + "direction2",@distance)
          # $redis.set("distance_"+routes+"_" + "direction2_finish",@finish_bus)
    end
     # p '=====end ==='
     p 111111
     p  JSON.parse $redis.get("distance_"+routes+"_" + "direction1")
      p '=====end ==='
     p 222222
p  JSON.parse $redis.get("distance_"+routes+"_" + "direction2")
 p '=====end ==='
 p yy
  end

end
