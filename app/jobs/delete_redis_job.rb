class DeleteRedisJob
  def perform
    RedisWorker.perform_async('DeleteRedisJob')
  end

end
