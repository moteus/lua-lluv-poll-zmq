# lua-lluv-poll-zmq
[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)
[![Build Status](https://travis-ci.org/moteus/lua-lluv-poll-zmq.svg?branch=master)](https://travis-ci.org/moteus/lua-lluv-poll-zmq)
[![Coverage Status](https://coveralls.io/repos/moteus/lua-lluv-poll-zmq/badge.svg)](https://coveralls.io/r/moteus/lua-lluv-poll-zmq)

ZMQ poller for lluv library

```Lua
local function thread(pipe)
  local uv    = require "lluv"
  uv.poll_zmq = require "lluv.poll_zmq"

  uv.poll_zmq(pipe):start(function(handle, err, pipe)
    if err then return handle:close() end

    print("Pipe recv:", pipe:recvx())
  end)

  uv.run()
end

local zth = require "lzmq.threads"
local ztm = require "lzmq.timer"

local actor = zth.xactor(thread):start()

for i = 1, 5 do
  actor:send("Hello #" .. i)
  ztm.sleep(1000)
end
```
