class ClearlogJob
  def perform
    if Time.now.strftime('%H').to_i > 7 && Time.now.strftime('%H').to_i < 24
      CronoJob.all.update(log: '')
    end
    # sleep(5)
  end
end
