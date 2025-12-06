# FiveM Token System

## Exports Server Side

Generate Tokens:
```lua
exports.nt_token:CreateNewToken() -- This will make a new token and return the token
```
Checking Tokens:
```lua
exports.nt_token:CheckToken(token) -- This is used to check if the token is valid
```
Removing Tokens:
```lua
exports.nt_token:UseToken(token) -- This will remove the token
```

## Uses
Example Generate Token:
```lua
lib.callback.register('nt_drugs:server:PlantDrugs', function(source)
    -- Add to database blah blah
    return true, exports.nt_token:CreateNewToken()
end)
```
Removing Token:
```lua
lib.callback.register('nt_drugs:server:FarmDrgus', function(source, token)
    -- Farming blah blah
    local RemoveToken = exports.nt_token:UseToken(token)
    if RemoveToken then
        -- Add item to inv
    end
end)
```

## Requirements
* ox_lib
* ox_mysql
