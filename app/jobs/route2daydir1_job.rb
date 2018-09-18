class Route2daydir1Job

  def perform
        ms = ['Mon','Tue','Wed',"Thu",'Fri','Sat']
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 19 && ms.include?(Date.today.strftime("%a"))
        Route2daydir1Worker.perform_async('Route2daydir1Job')
      end
      sleep 3
  end

end
