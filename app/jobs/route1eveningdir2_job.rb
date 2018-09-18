class Route1eveningdir2Job

  def perform
        ms = ['Mon','Tue','Wed',"Thu",'Fri','Sat']
      if Time.now.strftime('%H').to_i > 19 && Time.now.strftime('%H').to_i < 24 && ms.include?(Date.today.strftime("%a"))
        Route1eveningdir2Worker.perform_async('Route1eveningdir2Job')
      end
        sleep 3
  end

end
