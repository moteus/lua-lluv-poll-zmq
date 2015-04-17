package.path = "..\\src\\lua\\?.lua;" .. package.path

local uv    = require "lluv"
local zmq   = require "lzmq"
uv.poll_zmq = require "lluv.poll_zmq"

local ep = arg[1] or "inproc://hello"

local ctx = zmq.context()

local srv = ctx:socket{"PAIR", bind    = ep }
ep = srv:last_endpoint()
local cli = ctx:socket{"PAIR", connect = ep }

print("ZMQ   version:", zmq.version(true))
print("Test endpoint:", ep)

local counter = 0
local called = 0

local t = uv.timer():start(1000, 1000, function(self)
  counter = counter + 1
  srv:send(tostring(counter))
  if counter == 5 then
    self:close()
    ctx:shutdown()
  end
end)

uv.poll_zmq(cli):start(function(handle, err, sock)
  assert(cli == sock)
  assert(not err, tostring(err))
  local msg, err = sock:recvx()
  assert(not err, tostring(err))
  print(msg)
  assert(tonumber(msg) == counter, msg .. "/" .. counter)
  called = called + 1
end)

uv.run()

assert(called == 4, called)

