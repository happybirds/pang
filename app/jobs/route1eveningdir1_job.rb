class Route1eveningdir1Job

  def perform
    ms = ['Mon','Tue','Wed',"Thu",'Fri','Sat']
      if Time.now.strftime('%H').to_i > 18 && Time.now.strftime('%H').to_i < 24 &&  ms.include?(Date.today.strftime("%a"))
        Route1eveningdir1Worker.perform_async('Route1eveningdir1Job')
      end
        1.upto(7) do |n|
          puts n
          sleep 1
        end
  end


end
