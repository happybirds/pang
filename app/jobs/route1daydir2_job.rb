class Route1daydir2Job

  def perform
      if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 19
        Route1daydir2Worker.perform_async('Route1daydir2Job')
      end
      sleep 3
  end
end
