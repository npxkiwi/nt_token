# FiveM Token System

## Exports Server Side

Generate Tokens:
```lua
exports.nt_token:generateToken() -- This will make a new token and return the token
```
Checking Tokens:
```lua
exports.nt_token:checkToken(token) -- This is used to check if the token is valid
```
Removing Tokens:
```lua
exports.nt_token:useToken(token) -- This will remove the token
```

## Uses
Example Generate Token:
```lua
lib.callback.register('nt_drugs:server:PlantDrugs', function(source)
    -- Add to database blah blah
    return true, exports.nt_token:generateToken()
end)
```
Removing Token:
```lua
lib.callback.register('nt_drugs:server:FarmDrgus', function(source, token)
    -- Farming blah blah
    local RemoveToken = exports.nt_token:useToken(token)
    if RemoveToken then
        -- Add item to inv
    end
end)
```

## Requirements
* ox_lib
* ox_mysql
