class DeleteRedisJob
  def perform
    $redis.flushdb
  end

end
