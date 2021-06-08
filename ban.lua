local fs = require('fs')
local json = require('json')
local cfg = json.decode(fs.readFileSync('config.json'))

local discordia = require('discordia')
local client = discordia.Client()

client:on('messageCreate', function(message)
  if message.author.bot then return end

  if message.content:sub(1, 4) == '!ban' then
    local author = message.guild:getMember(message.author.id)
    local member = message.mentionedUsers.first

    if not member then
      -- The user have not mentioned any member to be banned
      message:reply("Please mention someone to be exiled!")
      return
    elseif not author:hasPermission("banMembers") then
      -- The user does not have enough permissions
      message:reply("You do not have the permissions!")
      return
    end

    for user in message.mentionedUsers:iter() do
      member = message.guild:getMember(user.id)
      if author.highestRole.position > member.highestRole.position then
        member:send("You have been exiled to the far far lands....")
        member:ban()
      end
    end
    message:reply("The commoner has been exiled!")
  end
end)

client:run("Bot "..cfg.token)