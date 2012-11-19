module QC
  class Queue

    attr_reader :name, :chan

    def initialize(name, notify=false)
      @name = name
      @chan = @name if notify
    end

    def enqueue(method, *args)
      Queries.insert(name, method, args, chan)
    end

    def enqueue_if_not_queued(method, *args)
      enqueue(method, *args) if job_count(method, *args) == 0
    end

    def lock(top_bound=TOP_BOUND)
      Queries.lock_head(name, top_bound)
    end

    def delete(id)
      Queries.delete(id)
    end

    def delete_all
      Queries.delete_all(@name)
    end

    def count
      Queries.count(@name)
    end

    def job_count(method, *args)
      Queries.job_count(name, method, args)
    end

  end
end
