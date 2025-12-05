local debug<const> = true
local string<const> = lib.string

local function dbg(...)
    if not ... or not debug then
        return
    end

    local msg<const> = ...
    local resourceName<const> = GetCurrentResourceName()

    print(string.format('^2[%s]:^7 %s', resourceName, msg))
end
---This is used to generate tokens
---@return string
local function GenerateTokenString()
    local token<const> = string.random('AAA-AAA',6)
    dbg(string.format('Token: %s', token))
    return token
end

---Get tokens from database
---@param token string The token that has been made
---@return boolean
local function CheckToken(token)
    local result = MySQL.query.await(
        'SELECT 1 FROM `nt_token` WHERE token = ? LIMIT 1',
        { token }
    )
    return result and result[1] ~= nil
end

---Insert the token to the database
---@param token string The toke
---@return boolean
local function InsertToken(token)
    local id = MySQL.insert.await('INSERT INTO `nt_token` (token) VALUES (?)', {
        token
    })
    return id ~= nil
end

---Add a new token to the database
---@return string
local function AddNewToken()
    for _ = 1, 10 do
        local token = GenerateTokenString()

        if not CheckToken(token) then
            if InsertToken(token) then
                return token
            end
        end
    end
    return false
end
---Used to remove tokens
---@param token string The token
---@return boolean
local function RemoveToken(token)
    if CheckToken(token) then
        local affectedRows = MySQL.update.await('DELETE FROM `nt_token` WHERE token = ?', {token})
        if affectedRows then
            dbg(string.format('Tokens removed: %s', token))
            return true
        else
            dbg(string.format('Failed to remove token: %s', token))
            return false
        end
    end
    return false
end

exports('generateToken', AddNewToken)
exports('checkToken', CheckToken)
exports('useToken', RemoveToken)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  local affectedRows = MySQL.update.await('DELETE * FROM `nt_token`')
  if affectedRows then
    dbg('Removed all tokens')
    return true
  else
    dbg('Failed to remove all tokens')
    return false
  end
end)
