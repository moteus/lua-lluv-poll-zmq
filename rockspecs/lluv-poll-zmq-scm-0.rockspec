package = "lluv-poll-zmq"
version = "scm-0"

source = {
  url = "https://github.com/moteus/lua-lluv-poll-zmq/archive/master.zip",
  dir = "lua-lluv-poll-zmq-master",
}

description = {
  summary    = "ZMQ poller for lluv library",
  homepage   = "https://github.com/moteus/lua-lluv-poll-zmq",
  license    = "MIT/X11",
  maintainer = "Alexey Melnichuk",
  detailed   = [[
  ]],
}

dependencies = {
  "lua >= 5.1, < 5.4",
  "lluv > 0.1.1",
}

build = {
  copy_directories = {'examples', 'test'},

  type = "builtin",

  modules = {
    ["lluv.poll_zmq"] = "src/lua/lluv/poll_zmq.lua",
  }
}
