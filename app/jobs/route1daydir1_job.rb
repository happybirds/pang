class Route1daydir1Job

  def perform
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 19
        Route1daydir1Worker.perform_async('Route1daydir1Job')
      else
        1.upto(3) do |n|
          puts n
          # sleep 1
        end
      end
  end


end
