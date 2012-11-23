class RedisRollout
  def self.lapsus
  	(10.minute.ago).to_i
  end

  def self.mark(name)
      REDIS.set(name, Time.now.to_i)
  end

  def self.overloaded?(name, lapso=nil)
  	lapso ||= lapsus 
    last = REDIS.get(name)
    #returns true if exists and happend between lapsus and now
    if last 
      if last.to_i > lapso
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
