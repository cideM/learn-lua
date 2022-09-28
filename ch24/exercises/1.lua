-- 24.1 Rewrite the producer-consumer example in section 24.2 using a
--    producer-driven design, where the consumer is the coroutine and the
--    producer is the main thread.

-- I think the book is being a bit vague when it says the producer-driven design
-- is the reverse. Writing this was a lot more awkward since I need to get "x"
-- either from the first call to resume or from subsequent calls to receive.

function receive()
	return coroutine.yield()
end

function send(co, x)
	coroutine.resume(co, x)
end

function producer(consumer)
	while true do
		local x = io.read()
		send(consumer, x)
	end
end

function filter(consumer)
	return coroutine.create(function(x)
		for line = 1, math.huge do
			x = string.format("%5d %s", line, x)
			send(consumer, x)
			x = receive()
		end
	end)
end

function consumer()
	return coroutine.create(function(x)
		while true do
			io.write(x, "\n")
			x = receive()
		end
	end)
end

producer(filter(consumer()))
