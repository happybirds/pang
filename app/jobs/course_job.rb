class CourseJob

  def perform
    CourseWorker.perform_async('CourseJob')
    sleep(5)
  end

end
