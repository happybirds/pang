class Route3daydir1Job

  def perform
        ms = ['Mon','Tue','Wed',"Thu",'Fri','Sat']
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 20 && ms.include?(Date.today.strftime("%a"))
        Route3daydir1Worker.perform_async('Route3daydir1Job')
      end
      sleep 3
  end
end
