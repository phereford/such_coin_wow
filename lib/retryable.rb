module Retryable
  def retryable(&blk)
    try_times = 0
    @request_is_retryable = true

    begin
      yield
    rescue Errno::ECONNREFUSED 
      if try_times > 5
      else
        try_times += 1
        retry
      end
    ensure
      @request_is_retryable = false
    end
  end
end
