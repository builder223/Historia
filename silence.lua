local fs = require('fs')
local json = require('json')
local cfg = json.decode(fs.readFileSync('config.json'))

local discordia = require('discordia')
local client = discordia.Client()



client:on('messageCreate', function()
if member.author.bot then return end

if message.content:sub(1,4)
end)

