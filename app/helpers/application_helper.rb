module ApplicationHelper
  def changeW(i)
    if i == 1
      w = 'Mon'
    elsif i==2
      w = 'TUE'
    elsif i==3
      w = 'WED'
    elsif i==4
      w = 'THU'
    elsif i==5
      w = 'FRI'
    end
      return w
  end


  def get_name(s)

    if s =='route1daydir1'
      w = 'MALL TO DT(route1 day)'
    elsif s== 'route1daydir2'
      w = 'DT TO MALL(route1 day)'
    elsif s== 'route1eveningdir1'
      w = 'MALL TO DT(route1 evening)'
    elsif s== 'route1eveningdir2'
      w = 'DT TO MALL(route1 evening)'
    elsif s== 'route2daydir1'
      w = 'route2'
    elsif s== 'route3daydir1'
      w = 'route3'
    end
    
    return w
  end
end
