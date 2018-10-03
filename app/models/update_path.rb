class UpdatePath

  def self.update(routes,route_num,direction)
    boards  = Board.where(route_name: routes,route_num: route_num)
    board_count = Board.where(route_name: routes,route_num: route_num).where.not(name: '')

    if board_count.size != 0
      board_count = board_count.last.sort
    else
      board_count = 0
    end
    @dir = 9

    uri = URI(ENV[routes] )

    res = Net::HTTP.get(uri)
    bus_infos =  JSON.parse res

    if bus_infos.size != 0  #有信号
        c = {}
        _nh = []
        _distance1 = []
        _distance2 = []
        _num = []
        _num1 = {}
        _num2= {}
        @finish_bus = []

        yy = ''

        $redis.set("distance_"+routes+"_" + "direction#{direction}_true",false)
        bus_infos.each_with_index do |n,index|
          h = []
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
          _num.push(n['busNumber'])
         if $redis.get(routes+"_" +n['busNumber'])
            if  ($redis.get(routes+"_" + "direction1_flag"+n['busNumber']).to_i == 1) || ($redis.get(routes+"_" +n['busNumber']).to_i < c[c[_nh[index]]].to_i  && direction.to_i == 1)
                _num1[n['busNumber']] = n['busNumber']
                _num2.delete(n['busNumber'])
                @dir = 1
                if($redis.get(routes+"_" +n['busNumber']).to_i == board_count )

                  if route_num == 2 || route_num ==3
                     $redis.set(routes+"_" +n['busNumber'] ,1)
                     $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],1)
                  else
                    $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],1)
                    $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],0)
                  end

                  break
                end
                $redis.set(routes+"_" + "direction1_"+n['busNumber'],c[_nh[index]])
                $redis.del(routes+"_" + "direction2_"+n['busNumber'])
                $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],1)
                $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],0)
                $redis.set(routes+"_"+n['busNumber'],c[c[_nh[index]]])
             elsif   ($redis.get(routes+"_" + "direction2_flag"+n['busNumber']).to_i == 1) || ($redis.get(routes+"_" +n['busNumber']).to_i > c[c[_nh[index]]].to_i   && direction.to_i == 2)
                @dir = 2
                _num2[n['busNumber']] = n['busNumber']
                _num1.delete(n['busNumber'])
                if($redis.get(routes+"_" +n['busNumber']).to_i == 1 )
                  $redis.set(routes+"_" + "direction2_flag"+n['busNumber'],0)
                  $redis.set(routes+"_" + "direction1_flag"+n['busNumber'],1)

                  break
                end

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
        route1daydir1 =  $redis.get('route1daydir1')
        route1daydir2 =  $redis.get('route1daydir2')
        route1eveningdir1 =  $redis.get('route1eveningdir1')
        route1eveningdir2 =  $redis.get('route1eveningdir2')

        route2daydir1 =  $redis.get('route2daydir1')
        route3daydir1 =  $redis.get('route3daydir1')

        if routes == '1day'
          datas1 = route1daydir1
          datas2 = route1daydir2
        elsif routes == '1evening'
          datas1 = route1eveningdir1
          datas2 = route1eveningdir2
        elsif routes == '2day'
          datas1 = route2daydir1
        elsif routes == '3day'
          datas1 = route3daydir1
        end


        p "正面-----bus-------#{_num1.keys}"
        p "反面-----bus-------#{_num2.keys}"
        if _num1.size == 0
           $redis.del("distance_"+routes+"_" + "direction1")

         end
         if _num2.size == 0
           $redis.del("distance_"+routes+"_" + "direction2")

         end

         $redis.set("prev_distance_"+routes+"_" + "direction#{direction}",nil)

        _num1.keys.each do |n|
            bus_name = $redis.get(routes+"_" + "direction1_"+n)
            # p 'datas1+++++++++++++++++++++'
               # p datas1
                 p datas1.include? bus_name
            if  (datas1.include? bus_name)
                  _distance1.push(bus_name.split('_')[0] +","+n)
                 $redis.set("prev_distance_"+routes+"_" + "direction1"+","+n,bus_name.split('_')[0] +","+n)

                 $redis.set("distance_"+routes+"_" + "direction#{direction}_true",true)

                if boards.first.name == bus_name
                  @finish_bus.push(bus_name.split('_')[0]+","+n)

                end
              else
                p '上一次正面'
                p   $redis.get("prev_distance_"+routes+"_" + "direction1"+","+n)
                 _distance1.push($redis.get("prev_distance_"+routes+"_" + "direction1"+","+n))
            end
      end
      _num2.keys.each do |n|
          bus_name = $redis.get(routes+"_" + "direction2_"+n)
            # p 'datas2+++++++++++++++++++++'
          # p datas2
          p datas2.include? bus_name

            if  (datas2.include? bus_name)
                _distance2.push(bus_name.split('_')[0] +","+n)

                $redis.set("prev_distance_"+routes+"_" + "direction2"+","+n,bus_name.split('_')[0] +","+n)

               $redis.set("distance_"+routes+"_" + "direction#{direction}_true",true)
                if boards.first.reverse_name == bus_name
                  @finish_bus.push(bus_name.split('_')[0]+","+n)
                   $redis.set("prev_distance_"+routes+"_" + "direction#{direction}"+","+n,'无反面第一个')
                end
            else
              p '上一次反面'
              p   $redis.get("prev_distance_"+routes+"_" + "direction2"+","+n)
             _distance2.push($redis.get("prev_distance_"+routes+"_" + "direction2"+","+n))
            end
       end

           p "正面----#{_distance1}----#{_num1.count}"
           p "反面-----#{_distance2}----#{_num2.count}"
        if direction == 1
            $redis.set("distance_"+routes+"_" + "direction1",_distance1)
            $redis.set("count_" + routes+"_" + "direction1",_num1.count)

        end

        if direction == 2

           $redis.set("distance_"+routes+"_" + "direction2",_distance2)
           $redis.set("count_" + routes+"_" + "direction2",_num2.count)
        end
        $redis.set("no_sign_" + routes,true)


    else
      @dir = 0
      $redis.set("no_sign_" + routes,false)
       $redis.set("count_" + routes+"_" + "direction2",0)
       $redis.set("count_" + routes+"_" + "direction1",0)
    end
  end

end
