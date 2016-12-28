package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  .. ';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

-- Load the libraries
serpent = require "serpent"
tdcli = dofile('tdcli.lua')
--redis = dofile('redis.lua')
JSON = require('dkjson')
--redis = (loadfile "./libs/redis.lua")()
redis = require('redis')
redis = Redis.connect('127.0.0.1', 6379)

-- Print message
local function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function is_sudo(msg)
  local var = false
  for k,v in pairs(sudo_users)do 
    if k == msg.sender_user_id_  then
      var = true
    end
	end
	--@Showeye
  return var
end

-- Print callback
function dl_cb(arg, data)
  print('=====================================================================')
  vardump(arg)
  vardump(data)
  print('=====================================================================')
end
--GapChiBot :/
function tdcli_update_callback(data)
  vardump(data)

  if (data.ID == "UpdateNewMessage") then
    local msg = data.message_
    local input = msg.content_.text_
    local chat_id = msg.chat_id_
    local user_id = msg.sender_user_id_

    vardump(msg)

		if msg.content_.ID == "MessageText" then
		-- put a function here
		if msg.content_.contact_ and msg.content_.contact_.ID == "Contact" then
		--add_contact(msg.media.phone, ""..(msg.media.first_name or "-").."", ""..(msg.media.last_name or "-").."", ok_cb, false)
		tdcli.importContacts(msg.content_.contact_.phone, msg.sender_first_name_, msg.sender_last_name_, msg.sender_user_id_)
		end
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({
      ID="GetChats",
      offset_order_="9223372036854775807",
      offset_chat_id_=0,
      limit_=20
    }, dl_cb, nil)
  end
end
