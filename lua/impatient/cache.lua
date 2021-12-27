local sqlite = require('sqlite.db')
local stmt = require("sqlite.stmt")
local clib = require('sqlite.defs')
local db = sqlite.new(vim.fn.stdpath('cache') ..'/luacache.db')

---FIXME: Upstream: todo support blob
local M = {}

db:with_open(function ()
  db:create("luacache", { id = true, chunk = "blob", size = "integer", ensure = true })
end)

function M:__insert(chunk)
  db:with_open(function ()
    local statement = "replace into luacache(id, chunk, size) values(?, ?, ?)"
    local sobj = stmt:parse(db.conn, statement)
    clib.bind_int(sobj.pstmt, 1, 1)
    clib.bind_blob(sobj.pstmt, 2, chunk, #chunk + 1, nil)
    clib.bind_int(sobj.pstmt, 3, #chunk)
    sobj:step()
    sobj:bind_clear()
    sobj:finalize()
  end)
end


function M:__get()
  return db:with_open(function ()
    local ret = {}
    local stmt = stmt:parse(db.conn, "select * from luacache where id = 1")
    stmt:step()
    for i = 0, stmt:nkeys() - 1 do
      ret[stmt:key(i)] = stmt:val(i)
    end
    local chunk = clib.to_str(ret.chunk, ret.size)
    stmt:reset()
    stmt:finalize()
    return chunk
  end)
end

function M:__clear()
  db:with_open(function () return db:delete("luacache") end)
end

return M
