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
end
