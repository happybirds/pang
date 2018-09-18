class Route1daydir1Job

  def perform
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 20
        Route1daydir1Worker.perform_async('Route1daydir1Job')
      end
      sleep 3
  end


end
