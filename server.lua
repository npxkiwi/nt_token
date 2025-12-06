local string<const> = lib.string
local Tokens = {}
Config = lib.require('config')
local function dbg(...)
    if not ... or not Config.Debug then
        return
    end

    local resourceName<const> = GetCurrentResourceName()
    local message<const> = ...

    print(string.format('^2[%s]^7: %s', resourceName, message))
end

---This is used to find a value in a table
---@param a table The table
---@param b string The value
---@return boolean any Returns if it finds the value or not
local function table_contains(a,b)
    for i=1,#a do
        if a[i] == b then
            return true
        end
    end
    return false
end

---Check the token function
---@param _token string The token value
---@return boolean any Returns if it find the token
local function CheckToken(_token)
    if not _token then
        return false
    end

    return table_contains(Tokens, _token)
end

local function UseToken(_token)
    if not _token then
        return false
    end
    if CheckToken(_token) then
        table.remove(Tokens, _token)
        return true
    end
    return false
end

local function CreateNewToken()
    local Token<const> = string.random('AAA-AAA')
    dbg(('Token: %s'):format(Token))
    table.insert(Tokens, Token)
    return Token
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Tokens = {}
end)


exports('CreateNewToken', CreateNewToken)
exports('CheckToken', CheckToken)
exports('UseToken', UseToken)
