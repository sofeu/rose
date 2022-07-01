Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
luatele = require('luatele')
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(Server_Done.."set:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:setex(Server_Done.."set:Token",300,TokenBot)
Redis:setex(Server_Done.."set:userbot",300,Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua rosebot.lua')
end
if not Redis:get(Server_Done.."set:user") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:setex(Server_Done.."set:user",300,UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua rosebot.lua')
end
if not Redis:get(Server_Done.."set:user:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:setex(Server_Done.."set:user:ID",300,UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua rosebot.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(Server_Done.."set:Token")..[[",
UserBot = "]]..Redis:get(Server_Done.."set:userbot")..[[",
UserSudo = "]]..Redis:get(Server_Done.."set:user")..[[",
SudoId = ]]..Redis:get(Server_Done.."set:user:ID")..[[
}
]])
Informationlua:close()
local Therose = io.open("Therose", 'w')
Therose:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.3 rosebot.lua
done
]])
Therose:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S Therose -X kill
screen -S Therose ./Therose
done
]])
Run:close()
Redis:del(Server_Done.."set:user:ID");Redis:del(Server_Done.."set:user");Redis:del(Server_Done.."set:userbot");Redis:del(Server_Done.."set:Token")
os.execute('chmod +x Therose;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
Therose = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..Therose)
LuaTele = luatele.set_config{api_id=2692371,api_hash='fe85fff033dfe0f328aeb02b4f784930',session_name=Therose,token=Token}
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,1000596797}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controllerbanall(ChatId,UserId)
Status = 0
DevelopersQ = Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) 
if UserId == 1000596797 then
Status = true
elseif UserId == 1000596797 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Therose then
Status = true
elseif DevelopersQ then
Status = true
else
Status = false
end
return Status
end
function Controller(ChatId,UserId)
Status = 0
Developers = Redis:sismember(Therose.."rose:Developers:Groups",UserId) 
DevelopersQ = Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) 
TheBasicsQ = Redis:sismember(Therose.."rose:TheBasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Therose.."rose:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Therose.."rose:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Therose.."rose:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Therose.."rose:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Therose.."rose:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1000596797 then
Status = 'مطور السورس'
elseif UserId == 1000596797 then
Status = 'مبرمج السورس'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == Therose then
Status = 'البوت'
elseif DevelopersQ then
Status = 'المطور'
elseif Developers then
Status = Redis:get(Therose.."rose:Developer:Bot:Reply"..ChatId) or 'المطور'
elseif TheBasicsQ then
Status = "المالك"
elseif TheBasics then
Status = Redis:get(Therose.."rose:President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Originators then
Status = Redis:get(Therose.."rose:Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Managers then
Status = Redis:get(Therose.."rose:Manager:Group:Reply"..ChatId) or 'المدير'
elseif Addictive then
Status = Redis:get(Therose.."rose:Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الكروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن المجموعه'
elseif Distinguished then
Status = Redis:get(Therose.."rose:Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(Therose.."rose:Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنسئ,الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات المجموعه : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"‹ :  صلاحيات الادمن - ", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(Therose.."rose:lockpin"..ChatId) then    
lock_pin = "✔️"
else 
lock_pin = "❌"    
end
if Redis:get(Therose.."rose:Lock:tagservr"..ChatId) then    
lock_tagservr = "✔️"
else 
lock_tagservr = "❌"
end
if Redis:get(Therose.."rose:Lock:text"..ChatId) then    
lock_text = "✔️"
else 
lock_text = "❌ "    
end
if Redis:get(Therose.."rose:Lock:AddMempar"..ChatId) == "kick" then
lock_add = "✔️"
else 
lock_add = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:Join"..ChatId) == "kick" then
lock_join = "✔️"
else 
lock_join = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:edit"..ChatId) then    
lock_edit = "✔️"
else 
lock_edit = "❌ "    
end
if Redis:get(Therose.."rose:Chek:Welcome"..ChatId) then
welcome = "✔️"
else 
welcome = "❌ "    
end
if Redis:hget(Therose.."rose:Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(Therose.."rose:Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقيد "     
elseif Redis:hget(Therose.."rose:Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(Therose.."rose:Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "✔️"
else     
flood = "❌ "     
end
if Redis:get(Therose.."rose:Lock:Photo"..ChatId) == "del" then
lock_photo = "✔️" 
elseif Redis:get(Therose.."rose:Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقيد "   
elseif Redis:get(Therose.."rose:Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "❌ "   
end    
if Redis:get(Therose.."rose:Lock:Contact"..ChatId) == "del" then
lock_phon = "✔️" 
elseif Redis:get(Therose.."rose:Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:Link"..ChatId) == "del" then
lock_links = "✔️"
elseif Redis:get(Therose.."rose:Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Cmd"..ChatId) == "del" then
lock_cmds = "✔️"
elseif Redis:get(Therose.."rose:Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(Therose.."rose:Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "❌ "    
end
if Redis:get(Therose.."rose:Lock:User:Name"..ChatId) == "del" then
lock_user = "✔️"
elseif Redis:get(Therose.."rose:Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "❌ "    
end
if Redis:get(Therose.."rose:Lock:hashtak"..ChatId) == "del" then
lock_hash = "✔️"
elseif Redis:get(Therose.."rose:Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "❌ "    
end
if Redis:get(Therose.."rose:Lock:vico"..ChatId) == "del" then
lock_muse = "✔️"
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "❌ "    
end 
if Redis:get(Therose.."rose:Lock:Video"..ChatId) == "del" then
lock_ved = "✔️"
elseif Redis:get(Therose.."rose:Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Animation"..ChatId) == "del" then
lock_gif = "✔️"
elseif Redis:get(Therose.."rose:Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Sticker"..ChatId) == "del" then
lock_ste = "✔️"
elseif Redis:get(Therose.."rose:Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "❌ "    
end
if Redis:get(Therose.."rose:Lock:geam"..ChatId) == "del" then
lock_geam = "✔️"
elseif Redis:get(Therose.."rose:Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:vico"..ChatId) == "del" then
lock_vico = "✔️"
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "✔️"
elseif Redis:get(Therose.."rose:Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقيد "
elseif Redis:get(Therose.."rose:Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "❌ "
end
if Redis:get(Therose.."rose:Lock:forward"..ChatId) == "del" then
lock_fwd = "✔️"
elseif Redis:get(Therose.."rose:Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:Document"..ChatId) == "del" then
lock_file = "✔️"
elseif Redis:get(Therose.."rose:Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "❌ "    
end    
if Redis:get(Therose.."rose:Lock:Unsupported"..ChatId) == "del" then
lock_self = "✔️"
elseif Redis:get(Therose.."rose:Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "✔️"
elseif Redis:get(Therose.."rose:Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقيد "   
elseif Redis:get(Therose.."rose:Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Markdaun"..ChatId) == "del" then
lock_mark = "✔️"
elseif Redis:get(Therose.."rose:Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "❌ "    
end
if Redis:get(Therose.."rose:Lock:Spam"..ChatId) == "del" then    
lock_spam = "✔️"
elseif Redis:get(Therose.."rose:Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقيد "    
elseif Redis:get(Therose.."rose:Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(Therose.."rose:Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "❌ "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'غير متفاعل' 
elseif tonumber(Message) < 200 then 
MsgText = 'بده يتحسن' 
elseif tonumber(Message) < 400 then 
MsgText = 'شبه متفاعل' 
elseif tonumber(Message) < 700 then 
MsgText = 'متفاعل' 
elseif tonumber(Message) < 1200 then 
MsgText = 'متفاعل قوي' 
elseif tonumber(Message) < 2000 then 
MsgText = 'متفاعل جدا' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اقوى تفاعل'  
elseif tonumber(Message) < 4000 then 
MsgText = 'متفاعل نار' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'اقوى متفاعل' 
elseif tonumber(Message) < 7000 then 
MsgText = 'ملك التفاعل' 
elseif tonumber(Message) < 9500 then 
MsgText = 'امبروطور التفاعل' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'رب التفاعل'  
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات المجموعه : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"‹ :  صلاحيات المجموعه - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(Therose.."rose:BanAll:Groups",UserId) ,
BanGroup = Redis:sismember(Therose.."rose:BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(Therose.."rose:SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if UserInfo.username then
UserInfousername = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
else
UserInfousername = '['..UserInfo.first_name..'](tg://user?id='..UserId..')'
end
return {
Lock     = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n‹ : بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n‹ : خاصيه المسح *',
unLock   = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n‹ : بواسطه ← *'..UserInfousername..'\n'..TextMsg,
lockKtm  = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n‹ : بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n‹ : خاصيه الكتم *',
lockKid  = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n‹ : بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n‹ : خاصيه التقييد *',
lockKick = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n‹ : بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n‹ : خاصيه الطرد *',
Reply    = '[🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :](https://t.me/s36468)\n*— — — — — — — — —\n🔰 : المستخدم⇷ *'..UserInfousername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Therose.."rose:Developers:Groups",UserId) 
TheBasicsQ = Redis:sismember(Therose.."rose:TheBasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Therose.."rose:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Therose.."rose:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Therose.."rose:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Therose.."rose:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Therose.."rose:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1000596797 then
Status = true
elseif UserId == 1000596797 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Therose then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasicsQ then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Therose.."rose:Developers:Groups",UserId) 
TheBasicsQ = Redis:sismember(Therose.."rose:TheBasicsQ:Group"..ChatId,UserId) 
TheBasics = Redis:sismember(Therose.."rose:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Therose.."rose:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Therose.."rose:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Therose.."rose:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Therose.."rose:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1000596797 then
Status = true
elseif UserId == 1000596797 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == Therose then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasicsQ then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,Therose).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
local function Info_Video(x)
local f=io.popen(x)
if f then
local s=f:read"*a"
f:close()
if s == 'a' then
end
return s
end
end
function ChannelJoin(msg)
JoinChannel = true
local Channel = Redis:get(Therose..'rose:Channel:Join')
if Channel then
local url , res = https.request('https://api.telegram.org/bot'..Token..'/getchatmember?chat_id=@'..Channel..'&user_id='..msg.sender.user_id)
local ChannelJoin = JSON.decode(url)
if ChannelJoin.result.status == "left" then
JoinChannel = false
end
end
return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
local text = nil
if msg.sender.luatele == "messageSenderChat" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
Redis:incr(Therose..'rose:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end
if data.content.text then
text = data.content.text.text
end
if tonumber(msg.sender.user_id) == tonumber(Therose) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 1000596797 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1000596797 then
msg.Name_Controller = 'مبرمج السورس '
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(Therose.."rose:DevelopersQ:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(Therose.."rose:Developers:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(Therose.."rose:Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = "المالك"
elseif Redis:sismember(Therose.."rose:TheBasics:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(Therose.."rose:President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(Therose.."rose:Originators:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(Therose.."rose:Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(Therose.."rose:Managers:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(Therose.."rose:Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(Therose.."rose:Addictive:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(Therose.."rose:Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(Therose.."rose:Distinguished:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Therose.."rose:Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(Therose) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(Therose.."rose:Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.DevelopersQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Developers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasicsQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasics = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Originators = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Managers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Addictive = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Distinguished = true
end



if Redis:get(Therose.."rose:Lock:text"..msg_chat_id) and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(Therose.."rose:Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(Therose.."rose:Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md")  
else
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : اطلق دخول ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')\n‹ : نورت الكروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Distinguished and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(Therose) then
return false
end
local floods = Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(Therose.."rose:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : قام بالتكرار في المجموعه وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : قام بالتكرار في المجموعه وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : قام بالتكرار في المجموعه وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(Therose.."rose:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(Therose.."rose:Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and Redis:get(Therose..'lock:Fshar'..msg.chat_id) and not msg.Special then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and Redis:get(Therose..'lock:Fars'..msg.chat_id) and not msg.Special then 
list = {"که","پی","خسته","برم","راحتی","بیام","بپوشم","كرمه","چه","ڬ","ڿ","ڀ","ڎ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and not msg.Distinguished then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(Therose.."rose:Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Therose.."rose:Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Therose.."rose:Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Therose.."rose:Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Distinguished then -- التوجيه
local Fwd_Group = Redis:get(Therose.."rose:Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Distinguished then  -- الكيبورد
local Keyboard_Group = Redis:get(Therose.."rose:Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
var(LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}))
elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Distinguished then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Distinguished then  -- الماركداون
local Markduan_Gtoup = Redis:get(Therose.."rose:Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Distinguished then  -- الالعاب
local Games_Group = Redis:get(Therose.."rose:Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(Therose.."rose:lockpin"..msg_chat_id)
if Pin_Msg and not msg.Managers then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 

if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(Therose.."rose:Lock:Join"..msg.chat_id) == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end

if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(Therose.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(Therose.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(Therose.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(Therose) then
local N = (Redis:get(Therose.."Name:Bot") or "الروكس")
photo = LuaTele.getUserProfilePhotos(Therose)
return LuaTele.sendPhoto(msg.chat_id, 0, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,'*‹ : انا بوت اسمي '..N..'\n‹ : وظيفتي حمايه الكروب من السبام والتفليش الخ....\n‹ : لتفعيل البوت قم اضافته للمجموعتك وقم برفعه مشرف واكتب تفعيل\n*', "md")
end


Redis:set(Therose.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(Therose.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Distinguished then  -- الجهات
local Contact_Group = Redis:get(Therose.."rose:Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Distinguished then  -- بصمه الفيديو
local Videonote_Group = Redis:get(Therose.."rose:Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Distinguished then  -- الملفات
local Document_Group = Redis:get(Therose.."rose:Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Distinguished then  -- الملفات الصوتيه
local Audio_Group = Redis:get(Therose.."rose:Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Distinguished then  -- الفيديو
local Video_Grouo = Redis:get(Therose.."rose:Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Distinguished then  -- البصمات
local Voice_Group = Redis:get(Therose.."rose:Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Distinguished then  -- الملصقات
local Sticker_Group = Redis:get(Therose.."rose:Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Distinguished then  -- انلاين
local Inlen_Group = Redis:get(Therose.."rose:Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Distinguished then  -- المتحركات
local Gif_group = Redis:get(Therose.."rose:Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Distinguished then  -- الصور
local Photo_Group = Redis:get(Therose.."rose:Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end
if msg.content.photo and Redis:get(Therose.."rose:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,msg.content.photo.sizes[2].photo.remote.id)
if (ChatPhoto.luatele == "error") then
Redis:del(Therose.."rose:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا استطيع تغيير صوره المجموعه لاني لست ادمن او ليست لديه الصلاحيه ","md",true)    
end
Redis:del(Therose.."rose:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تغيير صوره المجموعه المجموعه الى ","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(Therose.."rose:Lock:Link"..msg_chat_id)  
if not msg.Distinguished then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Distinguished then 
local UserName_Group = Redis:get(Therose.."rose:Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Distinguished then 
local Hashtak_Group = Redis:get(Therose.."rose:Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Distinguished then 
local comd_Group = Redis:get(Therose.."rose:Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (Redis:get(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(Therose.."rose:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(Therose.."rose:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(Therose.."rose:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(Therose.."rose:List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(Therose.."rose:Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(Therose.."rose:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : تم اضافه رد التحذير","md",true)  
end
if text and (Redis:get(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(Therose.."rose:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(Therose.."rose:Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(Therose.."rose:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(Therose.."rose:Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(Therose.."rose:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(Therose.."rose:Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(Therose.."rose:List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(Therose.."rose:Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم الغاء منع ("..Filters..")","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(Therose.."rose:Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : لقد تم منع هذه ( "..statusfilter.." ) هنا*\n‹ : "..ReplyFilters,"md",true)   
end
end
if text and Redis:get(Therose.."rose:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(Therose.."rose:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Therose.."rose:Command:List:Group"..msg_chat_id,text)
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم ازالة هاذا ← { "..text.." }","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(Therose.."rose:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(Therose.."rose:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(Therose.."rose:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Therose.."rose:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(Therose.."rose:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(Therose.."rose:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(Therose.."rose:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(Therose.."rose:Command:List:Group"..msg_chat_id,text)
Redis:del(Therose.."rose:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ الامر باسم ← { "..text..' }',"md",true)
end
if Redis:get(Therose.."rose:Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(Therose.."rose:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"📥︙تم الغاء حفظ الرابط","md",true)         
end
if text and text:match("(https://telegram.me/%S+)") or text and text:match("(https://t.me/%S+)") then     
local LinkGroup = text:match("(https://telegram.me/%S+)") or text:match("(https://t.me/%S+)")   
Redis:set(Therose.."rose:Group:Link"..msg_chat_id,LinkGroup)
Redis:del(Therose.."rose:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"📥︙تم حفظ الرابط بنجاح","md",true)         
end
end 
if Redis:get(Therose.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Therose.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم الغاء حفظ الترحيب","md",true)   
end 
Redis:del(Therose.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(Therose.."rose:Welcome:Group"..msg_chat_id,text) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ ترحيب المجموعه","md",true)     
end
if Redis:get(Therose.."rose:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Therose.."rose:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم الغاء حفظ القوانين","md",true)   
end 
Redis:set(Therose.."rose:Group:Rules" .. msg_chat_id,text) 
Redis:del(Therose.."rose:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ قوانين المجموعه","md",true)  
end  
if Redis:get(Therose.."rose:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Therose.."rose:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم الغاء حفظ وصف المجموعه","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(Therose.."rose:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ وصف المجموعه","md",true)  
end  
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(Therose.."rose:Text:Manager"..msg.sender.user_id..":"..msg_chat_id.."")
if Redis:get(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(Therose.."rose:Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(Therose.."rose:Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
end   
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose:Add:Rd:Manager:Text"..test..msg_chat_id, text)  
end  
if msg.content.audio then
Redis:set(Therose.."rose:Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
Redis:set(Therose.."rose:Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
end
if msg.content.animation then
Redis:set(Therose.."rose:Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
end
if msg.content.video_note then
Redis:set(Therose.."rose:Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.video then
Redis:set(Therose.."rose:Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
print(idPhoto)
Redis:set(Therose.."rose:Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
end
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ رد للمدير بنجاح \n‹ : ارسل ( "..test.." ) لرئية الرد","md",true)  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(Therose.."rose:Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(Therose.."rose:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Therose.."rose:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:sadd(Therose.."rose:List:Manager"..msg_chat_id.."", text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير الرد', data = msg.sender.user_id..'/chengreplyg'},
},
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,[[
‹ : ارسل لي الرد سواء كان  :
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
‹ : يمكنك اضافة الى النص :
— — — — — — — — —
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد السحكات

]],"md",true, false, false, false, reply_markup)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(Therose.."rose:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Therose.."rose:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Therose.."rose:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف الرد من ردود المدير ","md",true)  
return false
end
end
if text and Redis:get(Therose.."rose:Status:ReplySudo"..msg_chat_id) then
local anemi = Redis:get(Therose.."rose:Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(Therose.."rose:Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(Therose.."rose:Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(Therose.."rose:Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(Therose.."rose:Add:Rd:Sudo:Photo"..text)
local video = Redis:get(Therose.."rose:Add:Rd:Sudo:Video"..text)
local document = Redis:get(Therose.."rose:Add:Rd:Sudo:File"..text)
local audio = Redis:get(Therose.."rose:Add:Rd:Sudo:Audio"..text)
local video_note = Redis:get(Therose.."rose:Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text and Redis:get(Therose.."rose:Status:Reply"..msg_chat_id) then
local anemi = Redis:get(Therose.."rose:Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(Therose.."rose:Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(Therose.."rose:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(Therose.."rose:Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(Therose.."rose:Add:Rd:Manager:Photo"..text..msg_chat_id)
local video = Redis:get(Therose.."rose:Add:Rd:Manager:Video"..text..msg_chat_id)
local document = Redis:get(Therose.."rose:Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(Therose.."rose:Add:Rd:Manager:Audio"..text..msg_chat_id)
local video_note = Redis:get(Therose.."rose:Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Texingt,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(Therose.."rose:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(Therose.."rose:Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(Therose.."rose:Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
end   
if msg.content.animation then   
Redis:set(Therose.."rose:Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content.audio then
Redis:set(Therose.."rose:Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
Redis:set(Therose.."rose:Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
end
if msg.content.video then
Redis:set(Therose.."rose:Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
end
if msg.content.video_note then
Redis:set(Therose.."rose:Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Therose.."rose:Add:Rd:Sudo:Photo"..test, idPhoto)  
end
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حفظ رد للمطور \n‹ : ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(Therose.."rose:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(Therose.."rose:List:Rd:Sudo", text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير الرد', data = msg.sender.user_id..'/chengreplys'},
},
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,[[
‹ : ارسل لي الرد سواء كان  :
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
‹ : يمكنك اضافة الى النص :
— — — — — — — — —
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد السحكات

]],"md",true, false, false, false, reply_markup)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose:Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(Therose..'rose:'..v..text)
end
Redis:del(Therose.."rose:Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Therose.."rose:List:Rd:Sudo", text)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف الرد من ردود المطور","md",true)  
end
end
if Redis:get(Therose.."rose:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(Therose.."rose:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(Therose.."rose:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(Therose.."rose:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
Redis:set(Therose.."rose:PinMsegees:"..v,text)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(Therose.."rose:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Therose.."rose:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء الاذاعه خاص","md",true)  
end 
local list = Redis:smembers(Therose..'rose:Num:User:Pv')  
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تمت الاذاعه الى *- "..#list.." * مشترك في البوت ","md",true)      
Redis:del(Therose.."rose:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Therose.."rose:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(Therose.."rose:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(Therose.."rose:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Therose.."rose:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Therose.."rose:ChekBotAdd")   
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم التوجيه الى *- "..#list.." * مجموعه في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Therose.."rose:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Therose.."rose:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء الاذاعه بالتوجيه خاص","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Therose.."rose:Num:User:Pv")   
LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم التوجيه الى *- "..#list.." * مجموعه في البوت ","md",true) 
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,1,msg.media_album_id,false,true)
end   
Redis:del(Therose.."rose:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(Therose..'rose:GetTexting:DevTherose'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' then 
Redis:del(Therose..'rose:GetTexting:DevTherose'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم الغاء حفظ كليشة المطور')
end
Redis:set(Therose..'rose:Texting:DevTherose',text)
Redis:del(Therose..'rose:GetTexting:DevTherose'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم حفظ كليشة المطور')
end
if Redis:get(Therose.."rose:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء امر تعين الايدي","md",true)  
Redis:del(Therose.."rose:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(Therose.."rose:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(Therose.."rose:Set:Id:Group"..msg.chat_id,text:match("(.*)"))
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير الايدي', data = msg.sender.user_id..'/chenid'},
},
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعين الايدي الجديد',"md",true, false, false, false, reply_markup)
end
if Redis:get(Therose.."rose:Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Change:Name:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء امر تغير اسم البوت","md",true)  
end 
Redis:del(Therose.."rose:Change:Name:Bot"..msg.sender.user_id) 
Redis:set(Therose.."rose:Name:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "‹ :  تم تغير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(Therose.."rose:Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
Redis:del(Therose.."rose:Change:Start:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n‹ : تم الغاء امر تغير كليشه start","md",true)  
end 
Redis:del(Therose.."rose:Change:Start:Bot"..msg.sender.user_id) 
Redis:set(Therose.."rose:Start:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "‹ :  تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(Therose.."rose:Game:Smile"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Smile"..msg.chat_id) then
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."rose:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - سمايل او سمايلات","md",true)
end
end 
if Redis:get(Therose.."Game:Countrygof"..msg.chat_id) then
if text == Redis:get(Therose.."Game:Countrygof"..msg.chat_id) then
Redis:incrby(Therose.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."Game:Countrygof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : العب مره اخره وارسل - اعلام","md",true)  
end
end
if Redis:get(Therose.."mshaher"..msg.chat_id) then
if text == Redis:get(Therose.."mshaher"..msg.chat_id) then
Redis:del(Therose.."mshaher"..msg.chat_id)
Redis:incrby(Therose.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : العب مره اخره وارسل - بوب او مشاهير","md",true)  
end
end
if Redis:get(Therose.."Game:enkliz"..msg.chat_id) then
if text == Redis:get(Therose.."Game:enkliz"..msg.chat_id) then
Redis:incrby(Therose.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."Game:enkliz"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : العب مره اخره وارسل - انجليزي","md",true)  
end
end
if Redis:get(Therose.."rose:Game:Monotonous"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Monotonous"..msg.chat_id) then
Redis:del(Therose.."rose:Game:Monotonous"..msg.chat_id)
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(Therose.."rose:Game:Riddles"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Riddles"..msg.chat_id) then
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."rose:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(Therose.."rose:Game:Meaningof"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Meaningof"..msg.chat_id) then
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."rose:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - معاني","md",true)   
end
end
if Redis:get(Therose.."rose:Game:Reflection"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Reflection"..msg.chat_id) then
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Therose.."rose:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(Therose.."rose:Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(Therose.."rose:Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(Therose.."rose:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Therose.."rose:Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(Therose.."rose:SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(Therose.."rose:SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(Therose.."rose:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Therose.."rose:Game:Estimate"..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اوبس لقد خسرت في اللعبه \n‹ : حظآ اوفر في المره القادمه \n‹ : كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اوبس تخمينك غلط \n‹ : ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(Therose.."rose:Game:Difference"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Difference"..msg.chat_id) then 
Redis:del(Therose.."rose:Game:Difference"..msg.chat_id)
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - المختلف","md",true)  
else
Redis:del(Therose.."rose:Game:Difference"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد خسرت حضا اوفر في المره القادمه\n‹ : اللعب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(Therose.."rose:Game:Example"..msg.chat_id) then
if text == Redis:get(Therose.."rose:Game:Example"..msg.chat_id) then 
Redis:del(Therose.."rose:Game:Example"..msg.chat_id)
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد فزت في اللعبه \n‹ : اللعب مره اخره وارسل - امثله","md",true)  
else
Redis:del(Therose.."rose:Game:Example"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لقد خسرت حضا اوفر في المره القادمه\n‹ : اللعب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Therose) ~= tonumber(FilesJson.BotId) then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
LuaTele.sendText(msg_chat_id,msg_id,'‹ : جاري استرجاع المشتركين والكروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(Therose..'rose:Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(Therose.."rose:ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(Therose.."rose:TheBasics:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(Therose.."rose:Originators:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(Therose.."rose:Managers:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(Therose.."rose:Addictive:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(Therose.."rose:Distinguished:Group"..GroupId,v)
end
end 
end
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم استرجاع {'..X..'} مجموعه \n‹ : واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(Therose) then 
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(Therose.."rose:ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(Therose.."rose:Originators:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(Therose.."rose:Managers:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(Therose.."rose:Addictive:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(Therose.."rose:TheBasics:Group"..idg,idASAS)
end;end
end
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم استرجاع المجموعات من نسخه تشاكي')
else
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : الملف لا يدعم هاذا البوت')
end
end
end
if (Redis:get(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if (Redis:get(Therose.."rose:AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == '『 الغاء الامر 』' then   
Redis:del(Therose.."rose:AddSudosNew"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, "\n ⦁ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(Therose.."rose:AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ⦁ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ⦁ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ⦁ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
return LuaTele.sendText(msg_chat_id,msg_id,"\n ⦁ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
end
end
if text == 'تغيير المطور الاساسي' or text == '『 تغيير المطور الاساسي 』' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ⦁ هاذا الامر يخص 『 '..Controller_Num(1)..' 』* ',"md",true)  
end
Redis:set(Therose.."rose:AddSudosNew"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id," ⦁ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == 'الغاء' or text == 'الغاء الامر' then 
Redis:del(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'•︙تم الغاء حفظ قناة الاشتراك')
end
Redis:del(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
Redis:del(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n•︙عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
local ChannelUser = text:gsub('@','')
if UserId_Info.type.is_channel == true then
local StatusMember = LuaTele.getChatMember(UserId_Info.id,Therose).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,"\n•︙البوت عضو في القناة يرجى رفع البوت ادمن واعادة وضع الاشتراك ","md",true)  
end
Redis:set(Therose..'rose:Channel:Join',ChannelUser) 
Redis:set(Therose..'rose:Channel:Join:Name',UserId_Info.title) 
return LuaTele.sendText(msg_chat_id,msg_id,"\n•︙تم تعيين الاشتراك الاجباري على قناة : [@"..ChannelUser..']',"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n•︙هاذا ليس معرف قناة يرجى ارسال معرف القناة الصحيح: [@"..ChannelUser..']',"md",true)  
end
end
end
if text == 'تفعيل الاشتراك الاجباري' or text == 'تفعيل الاشتراك الاجباري ‹ : ' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
Redis:set(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : ارسل الي الان قناة الاشتراك ","md",true)  
end
if text == 'تعطيل الاشتراك الاجباري' or text == 'تعطيل الاشتراك الاجباري ‹ : ' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
Redis:del(Therose..'rose:Channel:Join')
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : تم تعطيل الاشتراك الاجباري","md",true)  
end
if text == 'تغيير الاشتراك الاجباري' or text == 'تغيير الاشتراك الاجباري ‹ : ' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
Redis:set(Therose..'rose:Channel:Redis'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : ارسل الي الان قناة الاشتراك ","md",true)  
end
if text == 'الاشتراك الاجباري' or text == 'الاشتراك الاجباري ‹ : ' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local Channel = Redis:get(Therose..'rose:Channel:Join')
if Channel then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : الاشتراك الاجباري مفعل على : [@"..Channel..']',"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : لا توجد قناة في الاشتراك ارسل تغيير الاشتراك الاجباري","md",true)  
end
end
if text == 'تحديث السورس' or text == 'تحديث السورس ‹ : ' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
--os.execute('rm -rf rosebot.lua')
--download('https://raw.githubusercontent.com/SourceTherose/Therose/master/rosebot.lua','rosebot.lua')
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم تحديث السورس * ',"md",true)  
end
if text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(Therose..'rose:ChekBotAdd')  
local UsersBot = Redis:smembers(Therose..'rose:Num:User:Pv')  
local Get_Json = '{"BotId": '..Therose..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(Therose.."rose:TheBasics:Group"..v)
local Constructor = Redis:smembers(Therose.."rose:Originators:Group"..v)
local Manager = Redis:smembers(Therose.."rose:Managers:Group"..v)
local Admin = Redis:smembers(Therose.."rose:Addictive:Group"..v)
local Vips = Redis:smembers(Therose.."rose:Distinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"ahmad_sors"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*‹ : تم جلب النسخه الاحتياطيه\n‹ : تحتوي على {'..#Groups..'} مجموعه \n‹ : وتحتوي على {'..#UsersBot..'} مشترك *\n', 'md')
end
if text == 'جلب نسخه الردود' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local Get_Json = '{"BotId": '..Therose..','  
Get_Json = Get_Json..'"GroupsBotreply":{'
local Groups = Redis:smembers(Therose..'rose:ChekBotAdd')  
for k,ide in pairs(Groups) do   
listrep = Redis:smembers(Therose.."rose:List:Manager"..ide.."")
if k == 1 then
Get_Json = Get_Json..'"'..ide..'":{'
else
Get_Json = Get_Json..',"'..ide..'":{'
end
if #listrep >= 5 then
for k,v in pairs(listrep) do
if Redis:get(Therose.."rose:Add:Rd:Manager:Gif"..v..ide) then
db = "gif@"..Redis:get(Therose.."rose:Add:Rd:Manager:Gif"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Vico"..v..ide) then
db = "Vico@"..Redis:get(Therose.."rose:Add:Rd:Manager:Vico"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Stekrs"..v..ide) then
db = "Stekrs@"..Redis:get(Therose.."rose:Add:Rd:Manager:Stekrs"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Text"..v..ide) then
db = "Text@"..Redis:get(Therose.."rose:Add:Rd:Manager:Text"..v..ide)
db = string.gsub(db,'"','')
db = string.gsub(db,"'",'')
db = string.gsub(db,'*','')
db = string.gsub(db,'`','')
db = string.gsub(db,'{','')
db = string.gsub(db,'}','')
db = string.gsub(db,'\n',' ')
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Photo"..v..ide) then
db = "Photo@"..Redis:get(Therose.."rose:Add:Rd:Manager:Photo"..v..ide) 
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Video"..v..ide) then
db = "Video@"..Redis:get(Therose.."rose:Add:Rd:Manager:Video"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:File"..v..ide) then
db = "File@"..Redis:get(Therose.."rose:Add:Rd:Manager:File"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Audio"..v..ide) then
db = "Audio@"..Redis:get(Therose.."rose:Add:Rd:Manager:Audio"..v..ide)
elseif Redis:get(Therose.."rose:Add:Rd:Manager:video_note"..v..ide) then
db = "video_note@"..Redis:get(Therose.."rose:Add:Rd:Manager:video_note"..v..ide)
end
v = string.gsub(v,'"','')
v = string.gsub(v,"'",'')
Get_Json = Get_Json..'"'..v..'":"'..db..'",'
end   
Get_Json = Get_Json..'"taha":"ok"'
end
Get_Json = Get_Json..'}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./ReplyGroups.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./ReplyGroups.json', '', 'md')
end
if text == 'رفع نسخه الردود' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local Reply_Groups = JSON.decode(Get_Info) 
for GroupId,ListGroup in pairs(Reply_Groups.GroupsBotreply) do
if ListGroup.taha == "ok" then
for k,v in pairs(ListGroup) do
Redis:sadd(Therose.."rose:List:Manager"..GroupId,k)
if v and v:match('gif@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Gif"..k..GroupId,v:match('gif@(.*)'))
elseif v and v:match('Vico@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Vico"..k..GroupId,v:match('Vico@(.*)'))
elseif v and v:match('Stekrs@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Stekrs"..k..GroupId,v:match('Stekrs@(.*)'))
elseif v and v:match('Text@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Text"..k..GroupId,v:match('Text@(.*)'))
elseif v and v:match('Photo@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Photo"..k..GroupId,v:match('Photo@(.*)'))
elseif v and v:match('Video@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Video"..k..GroupId,v:match('Video@(.*)'))
elseif v and v:match('File@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:File"..k..GroupId,v:match('File@(.*)') )
elseif v and v:match('Audio@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:Audio"..k..GroupId,v:match('Audio@(.*)'))
elseif v and v:match('video_note@(.*)') then
Redis:set(Therose.."rose:Add:Rd:Manager:video_note"..k..GroupId,v:match('video_note@(.*)') )
end
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم استرجاع ردود المجموعات* ',"md",true)  
end
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'*‹ :  تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : عدد احصائيات البوت الكامله \n— — — — — — — — —\n‹ : عدد المجموعات : '..(Redis:scard(Therose..'rose:ChekBotAdd') or 0)..'\n‹ : عدد المشتركين : '..(Redis:scard(Therose..'rose:Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تفعيل' and msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Therose.."rose:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Therose..'rose:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..Redis:get(Therose..'rose:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : *['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*\n‹ : تم تفعيلها مسبقا *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ترتيب الاوامر', data = msg.sender.user_id..'/trt@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n‹ : تم تفعيل مجموعه جديده \n‹ : من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n‹ : معلومات المجموعه :\n‹ : عدد الاعضاء : '..Info_Chats.member_count..'\n‹ : عدد الادمنيه : '..Info_Chats.administrator_count..'\n‹ : عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name ~= "" then
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,msg.sender.user_id) 
Redis:sadd(Therose.."rose:ChekBotAdd",msg_chat_id)
Redis:set(Therose.."rose:Status:Id"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:Reply"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:BanId"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : *['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*\n‹ : تم تفعيل المجموعه *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرا انته لست ادمن او مالك الكروب *","md",true)  
end
if not Redis:get(Therose.."rose:BotFree") then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : الوضع الخدمي تم تعطيله من قبل مطور البوت *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Therose.."rose:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Therose..'rose:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..Redis:get(Therose..'rose:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n‹ : تم تفعيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n‹ : تم تفعيل مجموعه جديده \n‹ : من قام بتفعيلها : *['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')* \n‹ : معلومات المجموعه :\n‹ : عدد الاعضاء : '..Info_Chats.member_count..'\n‹ : عدد الادمنيه : '..Info_Chats.administrator_count..'\n‹ : عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ترتيب الاوامر', data = msg.sender.user_id..'/trt@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name ~= "" then
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,v.member_id.user_id) 
end
end
end
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,msg.sender.user_id) 
Redis:sadd(Therose.."rose:ChekBotAdd",msg_chat_id)
Redis:set(Therose.."rose:Status:Id"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:Reply"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:BanId"..msg_chat_id,true) ;Redis:set(Therose.."rose:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : *['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*\n‹ : تم تفعيل المجموعه *','md', true, false, false, false, reply_markup)
end
end
if text == 'تعطيل' and msg.Developers then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Therose.."rose:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n‹ : تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n‹ : تم تعطيل مجموعه جديده \n‹ : من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n‹ : معلومات المجموعه :\n‹ : عدد الاعضاء : '..Info_Chats.member_count..'\n‹ : عدد الادمنيه : '..Info_Chats.administrator_count..'\n‹ : عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(Therose.."rose:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n‹ : تم تعطيلها بنجاح *','md',true)
end
end
if text == 'تعطيل' and not msg.Developers then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرا انته لست ادمن او مالك الكروب *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Therose.."rose:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n‹ : تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
aLuaTele.sendText(Sudo_Id,0,'*\n‹ : تم تعطيل مجموعه جديده \n‹ : من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n‹ : معلومات المجموعه :\n‹ : عدد الاعضاء : '..Info_Chats.member_count..'\n‹ : عدد الادمنيه : '..Info_Chats.administrator_count..'\n‹ : عدد المطرودين : '..Info_Chats.banned_count..'\n‹ : عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(Therose.."rose:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n‹ : تم تعطيلها بنجاح *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(Therose.."rose:ChekBotAdd",msg_chat_id) then
if text == 'اوامر التسليه' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- متحركه', data = msg.sender.user_id..'/gife@'..msg_chat_id},{text = '- صوره', data = msg.sender.user_id..'/photos@'..msg_chat_id},
},
{
{text = '- انمي', data = msg.sender.user_id..'/aneme@'..msg_chat_id},{text = '- ريمكس', data = msg.sender.user_id..'/remex@'..msg_chat_id},
},
{
{text = '- فلم', data = msg.sender.user_id..'/filme@'..msg_chat_id},{text = '- مسلسل', data = msg.sender.user_id..'/mslsl@'..msg_chat_id},
},
{
{text = '- ميمز', data = msg.sender.user_id..'/memz@'..msg_chat_id},{text = '- غنيلي', data = msg.sender.user_id..'/kne@'..msg_chat_id},
},
{
{text = ' S𝘰𝘶𝘳𝘤𝘦 rose ⁦ᯓ ',url="https://t.me/s36468"}
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : اهلا بك مجددا عزيزي \n‹ : اليك الازرار الخاصه بأوامر التسليه الخاصه بسورس الروكس فقط اضغط على الامر الذي تريد تنفيذه *','md', true, false, false, false, reply_markup)
end
if text == "@all" or text == "تاك عام" or text == "all" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0
tags = 0
local list = Info_Members.members
for k, v in pairs(list) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then
tags = x + 5
listall = ""
end
x = x + 1
if UserInfo.first_name ~= '' then
listall = listall.." ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id.."),"
end
if x == 5 or x == tags or k == 0 then
LuaTele.sendText(msg_chat_id,msg_id,listall,"md",true)  
end
end
end
if text == "متحركات" then
Abs = math.random(2,140); 
local Text ='*‹ : تم اختيار المتحركة لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '‹ : مره اخرى 🔃 .', callback_data = IdUser..'/gifes@'},
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "تفعيل متحركه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل المتحركه'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:gif:Abs'..msg.chat_id) 
end
if text == "تعطيل متحركه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل المتحركه'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:gif:Abs'..msg.chat_id,true)  
end
if text and (text == "متحركه" or text == "↫ متحركه ✯") and not Redis:get(Therose..'Abs:gif:Abs'..msg.chat_id) then
Abs = math.random(2,1075); 
local Text ='*‹ : تم اختيار المتحركه لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end
if text == "تفعيل ميمز" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل الميمز'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:memz:Abs'..msg.chat_id) 
end
if text == "تعطيل ميمز" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل الميمز'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:memz:Abs'..msg.chat_id,true)  
end
if text and (text == "ميمز" or text == "↫ ميمز ✯") and not Redis:get(Therose..'Abs:memz:Abs'..msg.chat_id) then
Abs = math.random(2,1201); 
local Text ='*‹ : تم اختيار مقطع الميمز لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/MemzWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end
if text == "تفعيل ريمكس" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل الريمكس'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:Remix:Abs'..msg.chat_id) 
end
if text == "تعطيل ريمكس" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل الريمكس'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:Remix:Abs'..msg.chat_id,true)  
end


if text == "تفعيل صوره" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل الصوره'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:Photo:Abs'..msg.chat_id) 
end
if text == "تعطيل صوره" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل الصوره'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:Photo:Abs'..msg.chat_id,true)  
end
if text and (text == "صوره" or text == "↫ صوره ✯") and not Redis:get(Therose..'Abs:Photo:Abs'..msg.chat_id) then
Abs = math.random(4,1171); 
local Text ='*‹ : تم اختيار الصوره لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PhotosWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end

if text == "تفعيل انمي" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل الانمي'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:Anime:Abs'..msg.chat_id) 
end
if text == "تعطيل انمي" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل الانمي'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:Anime:Abs'..msg.chat_id,true)  
end
if text and (text == "انمي" or text == "↫ انمي ✯") and not Redis:get(Therose..'Abs:Anime:Abs'..msg.chat_id) then
Abs = math.random(3,1002); 
local Text ='*‹ : تم اختيار صورة الانمي لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end

if text == "تفعيل فلم" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل الافلام'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:Movies:Abs'..msg.chat_id) 
end
if text == "تعطيل فلم" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل الافلام'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:Movies:Abs'..msg.chat_id,true)  
end
if text and (text == "فلم" or text == "↫ فلم ✯") and not Redis:get(Therose..'Abs:Movies:Abs'..msg.chat_id) then
Abs = math.random(45,125); 
local Text ='*‹ : تم اختيار الفلم لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end
if text == "تفعيل مسلسل" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تفعيل المسلسلات'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:del(Therose..'Abs:Series:Abs'..msg.chat_id) 
end
if text == "تعطيل مسلسل" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local F333F = ' \n‹ : تم تعطيل المسلسلات'
LuaTele.sendText(msg_chat_id,msg_id,F333F,"md")
Redis:set(Therose..'Abs:Series:Abs'..msg.chat_id,true)  
end
if text and (text == "مسلسل" or text == "↫ مسلسل ✯") and not Redis:get(Therose..'Abs:Series:Abs'..msg.chat_id) then
Abs = math.random(2,54); 
local Text ='*‹ : تم اختيار المسلسل لك*'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/SeriesWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end

if text == 'بايو' and not Redis:get(Therose..'idnotmembio'..msg.chat_id)  then
local InfoUser = LuaTele.getUserFullInfo(msg.sender.user_id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = 'لا يوجد'
end
LuaTele.sendText(msg_chat_id, msg_id, '‹ : البايو : ['..Bio..']', 'md')
end
if text == "تعطيل البايو" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if Redis:get(Therose..'idnotmembio'..msg.chat_id)  then
LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم تعطيل امر البايو مسبقا\n ✓',"md")
else
Redis:set(Therose.."idnotmembio"..msg.chat_id,"true")
LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم تعطيل امر البايو \n ✓',"md")
end
end
if text == "تفعيل البايو" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if not Redis:get(Therose..'idnotmembio'..msg.chat_id)  then
LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم تفعيل امر البايو مسبقا\n ✓',"md")
else
Redis:del(Therose.."idnotmembio"..msg.chat_id)
LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم تفعيل امر البايو \n ✓',"md")
end
end
if Redis:get(Therose..":"..msg.sender.user_id..":lov_Bots"..msg.chat_id) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","?? 66","?? 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '‹ : اليك النتائج الخـاصة :\n\n‹ : نسبة الحب بيـن : *'..text..'* '..sendnum..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":lov_Bots"..msg.chat_id)
end
if Redis:get(Therose..":"..msg.sender.user_id..":lov_Bottts"..msg.chat_id) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '‹ : اليك النتائج الخـاصة :\n\n‹ : نسبة الغباء  : *'..text..'* '..sendnum..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":lov_Bottts"..msg.chat_id)
end
if Redis:get(Therose..":"..msg.sender.user_id..":lov_Botttuus"..msg.chat_id) == "sendlove" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '‹ : اليك النتائج الخـاصة :\n\n‹ : نسبة الذكاء  : *'..text..'* '..sendnum..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":lov_Botttuus"..msg.chat_id)
end
if text and Redis:get(Therose..":"..msg.sender.user_id..":krh_Bots"..msg.chat_id) == "sendkrhe" then
num = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnum = num[math.random(#num)]
local tttttt = '⌯ اليك النتائج الخـاصة :\n\n⌯ نسبه الكرة : *'..text..'* '..sendnum..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":krh_Bots"..msg.chat_id)
end
if text and text ~="نسبه الرجوله" and Redis:get(Therose..":"..msg.sender.user_id..":rjo_Bots"..msg.chat_id) == "sendrjoe" then
numj = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","😁 98","🥰 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnuj = numj[math.random(#numj)]
local tttttt = '‹ : اليك النتائج الخـاصة :\n\n‹ :  نسبة الرجوله لـ : *'..text..'* '..sendnuj..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":rjo_Bots"..msg.chat_id)
end
if text and text ~="نسبه الانوثه" and Redis:get(Therose..":"..msg.sender.user_id..":ano_Bots"..msg.chat_id) == "sendanoe" then
numj = {"😂 10","🤤 20","😢 30","😔 35","😒 75","🤩 34","😗 66","🤐 82","😪 23","😫 19","😛 55","😜 80","😲 63","😓 32","🙂 27","😎 89","😋 99","?? 98","😀 79","🤣 100","😣 8","🙄 3","😕 6","🤯 0",};
sendnuj = numj[math.random(#numj)]
local tttttt = '‹ : اليك النتائج الخـاصة :\n\n‹ :  نسبه الانوثة لـ : *'..text..'* '..sendnuj..'%'
LuaTele.sendText(msg_chat_id,msg_id,tttttt) 
Redis:del(Therose..":"..msg.sender.user_id..":ano_Bots"..msg.chat_id)
end

if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":lov_Bots"..msg.chat_id,"sendlove")
hggg = '‹ : الان ارسل اسمك واسم الشخص الثاني :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end
if text == "نسبه الغباء" or text == "نسبه الغباء" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":lov_Bottts"..msg.chat_id,"sendlove")
hggg = '‹ : الان ارسل اسم الشخص :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end
if text == "نسبه الذكاء" or text == "نسبه الذكاء" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":lov_Botttuus"..msg.chat_id,"sendlove")
hggg = '‹ : الان ارسل اسم الشخص :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":krh_Bots"..msg.chat_id,"sendkrhe")
hggg = '‹ : الان ارسل اسمك واسم الشخص الثاني :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end
if text == "نسبه الرجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":rjo_Bots"..msg.chat_id,"sendrjoe")
hggg = '‹ : الان ارسل اسم الشخص :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id ~= 0 then
if not Redis:get(Therose.."AlNsb"..msg.chat_id) then    
Redis:set(Therose..":"..msg.sender.user_id..":ano_Bots"..msg.chat_id,"sendanoe")
hggg = '‹ : الان ارسل اسم الشخص :'
LuaTele.sendText(msg_chat_id,msg_id,hggg) 
return false
end
end

if text == "تعطيل النسب" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if Redis:get(Therose..'AlNsb'..msg.chat_id)  then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل النسب مسبقا\n ✓',"md")
else
Redis:set(Therose.."AlNsb"..msg.chat_id,"true")
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل النسب\n ✓',"md")
end
end
if text == "تفعيل النسب" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if not Redis:get(Therose..'AlNsb'..msg.chat_id)  then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل النسب مسبقا\n ✓',"md")
else
Redis:del(Therose.."AlNsb"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل النسب\n ✓',"md")
end
end
if text == "تعطيل صورتي" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if Redis:get(Therose..'myphoto'..msg.chat_id)  then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل صورتي مسبقا\n ✓',"md")
else
Redis:set(Therose.."myphoto"..msg.chat_id,"off")
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل صورتي\n ✓',"md")
end
end
if text == "تفعيل صورتي" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if not Redis:get(Therose..'myphoto'..msg.chat_id)  then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل صورتي مسبقا\n ✓',"md")
else
Redis:del(Therose.."myphoto"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل صورتي\n ✓',"md")
end
end
if text == "تفعيل نسبه جمالي" or text == "تفعيل جمالي" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Therose.."mybuti"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم تفعيل امر جمالي * ',"md",true)  
end
if text == "تعطيل جمالي" or text == "تعطيل نسبه جمالي" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Therose.."mybuti"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم امر امر جمالي * ',"md",true)  
end
if text == "تفعيل كول" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Therose.."sayy"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم تفعيل امر كول * ',"md",true)  
end
if text == "تعطيل كول" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Therose.."sayy"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم امر امر كول * ',"md",true)  
end
if text == "جمالي" or text == 'نسبه جمالي' then
if Redis:get(Therose.."mybuti"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : نسبه جمالي معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if msg.Dev then
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي ⁹⁰⁰% لأن انته مطور لطيف ورائع 💝*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : لا توجد صوره ف حسابك*',"md",true) 
end
else
if photo.total_count > 0 then
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي "..rdbhoto.."% 🙄♥*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : لا توجد صوره ف حسابك*',"md",true) 
end
end
end
end
if text and text:match("^كول (.*)$")then
local m = text:match("^كول (.*)$")
if Redis:get(Therose.."sayy"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : امر كول معطل*',"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "صورتي" then
if Redis:get(Therose.."myphoto"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : الصوره معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=msg.sender.user_id.."/sorty2"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape("٭ عدد صورك هو "..photo.total_count.." صوره").."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*عدد صورك هو "..photo.total_count.." صوره*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if text == 'تغيير الايدي' or text == 'تغير الايدي' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
local List = {[[
 ∵ USERNAME . #username
 ∵ STAST . #stast
 ∵ ID . #id
 ∵ MSGS . #msgs
]],[[
 ∵ USERNAME . #username
 ∵ STAST . #stast
 ∵ ID . #id
 ∵ MSGS . #msgs
]],[[
: 𝖴ِᥱ᥉ : #username .
: Iَժ : #id .
: Sƚِᥲ : #stast .
: 𝖬⁪⁬⁮᥉َ𝗀 : #msgs .
]],[[
َ› Msgs : #msgs .🦇
َ› ID : #id .🦇
َ› Stast : #stast .🦇
َ› UserName : #username .🦇
]],[[
☁️ . USERNAME . #username
☁️ . STAST . #stast
☁️ . ID . #id
☁️ . MSGS . #msgs
]],[[
 . USERNAME . #username
 . STAST . #stast
 . ID . #id
 . MSGS . #msgs
]],[[
  USERNAME . #username
  STAST . #stast
  ID . #id
  MSGS . #msgs
]],[[
◜⛓️ِ𝗨َِS𝗘ِr #username 🕷 .  
◜⛓️ِ𝗠ِsِG  #msgs   .
◜⛓️ِ𝗦َ𝗧 #stast  .
◜⛓️ِ𝗜ِd  #id 🕸 .
]],[[
 . USERNAME . #username
 . STAST . #stast
 . ID . #id
 . MSGS . #msgs
]],[[
˛ 𝗎!𝗌 : #username ٰ⛓️ '.
˛ 𝗆!𝗀 #msgs .
˛ 𝗌!𝗍 : #stast .
˛𝗂!𝖽 : #id ⛓️ '.
]],[[
َ› Msgs : #msgs .🦇
َ› ID : #id .🦇
َ› Stast : #stast .🦇
َ› UserName : #username .🦇
]],[[
: 𝖴ِᥱ᥉ : #username .
: Iَժ : #id .
: Sƚِᥲ : #stast .
: 𝖬⁪⁬⁮᥉َ𝗀 : #msgs .
]]} 
local Text_Rand = List[math.random(#List)] 
Redis:set(Therose.."rose:Set:Id:Group"..msg.chat_id,Text_Rand)
return LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم التغيير ارسل ايدي لعرض الايدي الجديد',"md",true)  
end



if text == "ايدي" and msg.reply_to_message_id == 0 then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(Therose.."rose:Status:Id"..msg_chat_id) then
return false
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(Therose.."rose:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {
'صورتك فدشي خيالي',
"شتحس مخلي هلصورا ؟ ",
"محتحت اقسم",
"كشخه بربي",
"دغيرها شسالفه",
"ابوس لحات انا",
}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
Get_Is_Id = Redis:get(Therose.."rose:Set:Id:Group"..msg_chat_id)
if Redis:get(Therose.."rose:Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,
'\n*‹ :  '..Description..
'\n‹ :  ايديك : '..UserId..
'\n‹ :  معرفك : '..UserInfousername..
'\n‹ :  رتبتك : ( '..RinkBot..
')\n‹ :  صورك : '..TotalPhoto..
'\n‹ :  رسائلك : '..TotalMsg..
'\n‹ :  تعديلاتك : '..TotalEdit..
'\n‹ :  تفاعلك : '..TotalMsgT..
'*', "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*‹ :  ايديك : '..UserId..
'\n‹ :  معرفك : '..UserInfousername..
'\n‹ :  رتبتك : '..RinkBot..
'\n‹ :  رسائلك : '..TotalMsg..
'\n‹ :  تعديلاتك : '..TotalEdit..
'\n‹ :  تفاعلك : '..TotalMsgT..
'*',"md",true) 
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return LuaTele.sendText(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*‹ :  ايديك : '..UserId..
'\n‹ :  معرفك : '..UserInfousername..
'\n‹ :  رتبتك : '..RinkBot..
'\n‹ :  رسائلك : '..TotalMsg..
'\n‹ :  تعديلاتك : '..TotalEdit..
'\n‹ :  تفاعلك : '..TotalMsgT..
'*',"md",true) 
end
end
end
if text == 'ايدي' or text == 'كشف'  and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local RinkBot = Controller(msg_chat_id,Message_Reply.sender.user_id)
local TotalMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..Message_Reply.sender.user_id) or 0
local TotalEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..Message_Reply.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*‹ : ايديه : '..UserId..
'\n‹ : معرفه : '..UserInfousername..
'\n‹ : رتبته : '..RinkBot..
'\n‹ : رسائله : '..TotalMsg..
'\n‹ : تعديلاته : '..TotalEdit..
'\n‹ : تفاعله : '..TotalMsgT..
'*',"md",true) 
end
if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..UserId_Info.id) or 0
local TotalEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..UserId_Info.id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*‹ : ايديه : '..UserId..
'\n‹ : معرفه : @'..UserName..
'\n‹ : رتبته : '..RinkBot..
'\n‹ : رسائله : '..TotalMsg..
'\n‹ : تعديلاته : '..TotalEdit..
'\n‹ : تفاعله : '..TotalMsgT..
'*',"md",true) 
end
if text == 'رتبتي' then
return LuaTele.sendText(msg_chat_id,msg_id,'\n‹ : رتبتك هي : '..msg.Name_Controller,"md",true)  
end
if text == 'معلوماتي' or text == 'صلاحياتي' then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك الكروب'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف المجموعه'
else
StatusMemberChat = 'عظو في المجموعه'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Therose..'rose:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(Therose..'rose:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف المجموعه' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n‹ : صلاحيات المستخدم :\n— — — — — — — — —'..'\n‹ : تغيير المعلومات : '..change_info..'\n‹ : تثبيت الرسائل : '..pin_messages..'\n‹ : اضافه مستخدمين : '..invite_users..'\n‹ : مسح الرسائل : '..delete_messages..'\n‹ : حظر المستخدمين : '..restrict_members..'\n‹ : اضافه المشرفين : '..promote..'\n\n*'
end
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*‹ : ايديك : '..UserId..
'\n‹ : معرفك : '..UserInfousername..
'\n‹ : رتبتك : '..RinkBot..
'\n‹ : رتبته المجموعه: '..StatusMemberChat..
'\n‹ : رسائلك : '..TotalMsg..
'\n‹ : تعديلاتك : '..TotalEdit..
'\n‹ : تفاعلك : '..TotalMsgT..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,Therose).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : البوت عضو في المجموعه ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Therose).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n‹ : صلاحيات البوت في المجموعه :\n— — — — — — — — —'..'\n‹ : تغيير المعلومات : '..change_info..'\n‹ : تثبيت الرسائل : '..pin_messages..'\n‹ : اضافه مستخدمين : '..invite_users..'\n‹ : مسح الرسائل : '..delete_messages..'\n‹ : حظر المستخدمين : '..restrict_members..'\n‹ : اضافه المشرفين : '..promote..'\n\n*'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^تنظيف (%d+)$') then
local NumMessage = text:match('^تنظيف (%d+)$')
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
LuaTele.sendText(msg_chat_id, msg_id, "‹ : تم تنظيف - "..NumMessage.. ' رساله', 'md')
end

if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasicsW:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته منشئ بنجاح ☑اساسي بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته منشئ بنجاح ☑اساسي بنجاح ☑ ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته منشئ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته منشئ بنجاح ☑ ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مدير مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مدير بنجاح ☑  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته ادمن مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته ادمن بنجاح ☑  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مميز مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم ترقيته مميز بنجاح ☑  ").Reply,"md",true)  
end
end
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ‹ : تم ترقيته منشئ اساسي بنجاح ☑").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته منشئ اساسي بنجاح ☑").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته منشئ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته منشئ بنجاح ☑ ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مدير مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مدير بنجاح ☑  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته ادمن مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته ادمن بنجاح ☑  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مميز مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم ترقيته مميز بنجاح ☑  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم ترقيته مطوࢪ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم ترقيته مطوࢪ بنجاح ☑ ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته منشئ بنجاح ☑اساسي بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته منشئ بنجاح ☑اساسي بنجاح ☑ ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته منشئ بنجاح ☑ مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته منشئ بنجاح ☑ ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مدير مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مدير بنجاح ☑  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته ادمن مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته ادمن بنجاح ☑  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مميز مسبقآ ☑ ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"‹ : تم ترقيته مميز بنجاح ☑  ").Reply,"md",true)  
end
end
end
if text and text:match("^تغير رد المطور (.*)$") then
local Teext = text:match("^تغير رد المطور (.*)$") 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:set(Therose.."rose:Developer:Bot:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد المطور الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ الاساسي (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
Redis:set(Therose.."rose:President:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ (.*)$") 
Redis:set(Therose.."rose:Constructor:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغير رد المدير (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد المدير (.*)$") 
Redis:set(Therose.."rose:Manager:Group:Reply"..msg.chat_id,Teext) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد المدير الى :"..Teext)
elseif text and text:match("^تغير رد الادمن (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد الادمن (.*)$") 
Redis:set(Therose.."rose:Admin:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد الادمن الى :"..Teext)
elseif text and text:match("^تغير رد المميز (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد المميز (.*)$") 
Redis:set(Therose.."rose:Vip:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد المميز الى :"..Teext)
elseif text and text:match("^تغير رد العضو (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local Teext = text:match("^تغير رد العضو (.*)$") 
Redis:set(Therose.."rose:Mempar:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  تم تغير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Developer:Bot:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:President:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المنشئ' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Constructor:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Manager:Group:Reply"..msg.chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Admin:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Vip:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Mempar:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه مطورين الثانويين \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين الثانويين', data = msg.sender.user_id..'/DevelopersQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه مطورين البوت \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' or text == 'مالكين' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المالكين \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المالكين', data = msg.sender.user_id..'/TheBasicsQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' or text == 'الاساسيين' then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المنشئين الاساسيين \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين الاساسيين', data = msg.sender.user_id..'/TheBasics'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المنشئين  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين', data = msg.sender.user_id..'/Originators'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المدراء  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المدراء', data = msg.sender.user_id..'/Managers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه الادمنيه  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الادمنيه', data = msg.sender.user_id..'/Addictive'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المميزين  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المميزين', data = msg.sender.user_id..'/DelDistinguished'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين عام' or text == 'قائمه العام' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المحظورين عام  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المحظورين  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المكتومين  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(Therose.."rose:Status:Link"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(Therose.."rose:Status:Welcome"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:Id"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:IdPhoto"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'ردود المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:Reply"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل ردود المدير ","md",true)
end
if TextMsg == 'ردود المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:ReplySudo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل ردود المطور ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:BanId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(Therose.."rose:Status:Games"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'اطردني' then
Redis:set(Therose.."rose:Status:KickMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل اطردني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(Therose.."rose1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(Therose.."rose1:List:Rd:Sudo"..msg.chat_id, text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير الرد', data = msg.sender.user_id..'/chengreplygg'},
},
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
}
return  LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ',"md",true, false, false, false, reply_markup) 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose1:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:del(Therose..'rose1:Add:Rd:Sudo:Text'..text..msg.chat_id)
Redis:del(Therose..'rose1:Add:Rd:Sudo:Text1'..text..msg.chat_id)
Redis:del(Therose..'rose1:Add:Rd:Sudo:Text2'..text..msg.chat_id)
Redis:del(Therose.."rose1:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(Therose.."rose1:List:Rd:Sudo"..msg.chat_id, text)
return  LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
end
end
if text == ("مسح الردود المتعدده") then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local list = Redis:smembers(Therose.."rose1:List:Rd:Sudo"..msg.chat_id)
for k,v in pairs(list) do  
Redis:del(Therose.."rose1:Add:Rd:Sudo:Text"..v..msg.chat_id) 
Redis:del(Therose.."rose1:Add:Rd:Sudo:Text1"..v..msg.chat_id) 
Redis:del(Therose.."rose1:Add:Rd:Sudo:Text2"..v..msg.chat_id) 
Redis:del(Therose.."rose1:List:Rd:Sudo"..msg.chat_id)
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == ("الردود المتعدده") then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
local list = Redis:smembers(Therose.."rose1:List:Rd:Sudo"..msg.chat_id)
text = "\nقائمة ردود المتعدده \n━━━━━━━━\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
 LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]")
end
if text == "اضف رد متعدد" then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:set(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد" then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:set(Therose.."rose1:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(Therose.."rose1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose1:Add:Rd:Sudo:Text"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(Therose.."rose1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose1:Add:Rd:Sudo:Text1"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(Therose.."rose1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(Therose.."rose1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose1:Add:Rd:Sudo:Text2"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(Therose.."rose1:Add:Rd:Sudo:Text"..text..msg.chat_id)   
local Text1 = Redis:get(Therose.."rose1:Add:Rd:Sudo:Text1"..text..msg.chat_id)   
local Text2 = Redis:get(Therose.."rose1:Add:Rd:Sudo:Text2"..text..msg.chat_id)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ')
Redis:set(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(Therose.."rose11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(Therose.."rose11:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if Redis:get(Therose.."rose11:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
Redis:del(Therose..'rose11:Add:Rd:Sudo:Text'..text)
Redis:del(Therose..'rose11:Add:Rd:Sudo:Text1'..text)
Redis:del(Therose..'rose11:Add:Rd:Sudo:Text2'..text)
Redis:del(Therose.."rose11:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(Therose.."rose11:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده عام") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local list = Redis:smembers(Therose.."rose11:List:Rd:Sudo")
for k,v in pairs(list) do  
Redis:del(Therose.."rose11:Add:Rd:Sudo:Text"..v) 
Redis:del(Therose.."rose11:Add:Rd:Sudo:Text1"..v) 
Redis:del(Therose.."rose11:Add:Rd:Sudo:Text2"..v)   
Redis:del(Therose.."rose11:List:Rd:Sudo")
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == ("الردود المتعدده عام") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
local list = Redis:smembers(Therose.."rose11:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n━━━━━━━━\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
 LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]")
end
if text == "اضف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
Redis:set(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
Redis:set(Therose.."rose11:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(Therose.."rose11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose11:Add:Rd:Sudo:Text"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(Therose.."rose11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose11:Add:Rd:Sudo:Text1"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(Therose.."rose11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(Therose.."rose11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Therose.."rose11:Add:Rd:Sudo:Text2"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(Therose.."rose11:Add:Rd:Sudo:Text"..text)   
local Text1 = Redis:get(Therose.."rose11:Add:Rd:Sudo:Text1"..text)   
local Text2 = Redis:get(Therose.."rose11:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
 
if msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then      
Redis:sadd(Therose.."rose:allM"..msg.chat_id, msg.id)
if Redis:get(Therose.."rose:Status:Del:Media"..msg.chat_id) then    
local gmedia = Redis:scard(Therose.."rose:allM"..msg.chat_id)  
if gmedia >= 200 then
local liste = Redis:smembers(Therose.."rose:allM"..msg.chat_id)
for k,v in pairs(liste) do
local Mesge = v
if Mesge then
t = "‹ : تم مسح "..k.." من الوسائط تلقائيا\n‹ : يمكنك تعطيل الميزه بستخدام الامر ( `تعطيل المسح التلقائي` )"
LuaTele.deleteMessages(msg.chat_id,{[1]= Mesge})
end
end
LuaTele.sendText(msg_chat_id,msg_id, t)
Redis:del(Therose.."rose:allM"..msg.chat_id)
end
end
end
if text and text:match("^احسب (.*)$") then
local TextRet = text:match("^احسب (.*)$")
local ReturnHttps = https.request("https://faeder.ml/AgeF/Age.php?text="..URL.escape(TextRet))
return LuaTele.sendText(msg.chat_id,msg.id,ReturnHttps,"html")
end
if text and text:match("^برج (.*)$") then
local TextRet = text:match("^برج (.*)$")
local ReturnHttps = https.request("https://faeder.ml/AbragF/abrag.php?brg="..URL.escape(TextRet))
local InfoJson = JSON.decode(ReturnHttps)
return LuaTele.sendText(msg.chat_id,msg.id,InfoJson.description..'\n'..InfoJson.love..'\n'..InfoJson.work,"md")
end
if text and text:match("^معنى الاسم (.*)$") then
local TextRet = text:match("^معنى الاسم (.*)$") 
local ReturnHttps = https.request("https://faeder.ml/MeanF/Mean.php?Name="..URL.escape(TextRet))
local InfoJson = JSON.decode(ReturnHttps)
if InfoJson.ok == true then
return LuaTele.sendText(msg.chat_id,msg.id,InfoJson.Mean.Title..'\n\n'..InfoJson.Mean.Description)
end
end
if text == ("امسح") then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
local list = Redis:smembers(Therose.."rose:allM"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "‹ : تم مسح "..k.." من الوسائط الموجوده"
LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Therose.."rose:allM"..msg.chat_id)
end
end
if #list == 0 then
t = "‹ : لا يوجد ميديا في المجموعه"
end
 LuaTele.sendText(msg_chat_id,msg_id, t)
end
if text == ("عدد الميديا") then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
local gmria = Redis:scard(Therose.."rose:allM"..msg.chat_id)  
 LuaTele.sendText(msg_chat_id,msg_id,"‹ : عدد الميديا الموجود هو (* "..gmria.." *)","md")
end
if text == "تعطيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Status:Del:Media"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل المسح التلقائي للميديا')
return false
end 
if text == "تفعيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
Redis:set(Therose.."rose:Status:Del:Media"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل المسح التلقائي للميديا')
return false
end 
if text == "تعطيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Status:yt"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تعطيل المسح اليوتيوب')
return false
end 
if text == "تفعيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
Redis:set(Therose.."rose:Status:yt"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم تفعيل اليوتيوب')
return false
end 
if text and text:match('^بحث (.*)$') and Redis:get(Therose.."rose:Status:yt"..msg.chat_id) then
local Ttext = text:match('^بحث (.*)$') 
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
local httpsCurl = "https://devstorm.ml/YoutubeApi/tahaj200.php?token="..Token.."&msg="..MSGID.."&Text="..URL.escape(Ttext).."&chat_id="..msg_chat_id.."&user="..msg.sender.user_id
io.popen('curl -s "'..httpsCurl..'"')
end
if text == "تنظيف الميديا"  then
LuaTele.sendText(msg.chat_id,msg.id,"*- يتم البحث عن الميديا .*","md",true)  
msgid = (msg.id - (1048576*250))
y = 0
r = 1048576
for i=1,250 do
r = r + 1048576
Delmsg = LuaTele.getMessage(msg.chat_id,msgid + r)
if Delmsg and Delmsg.content and Delmsg.content.luatele ~= "messageText" then
LuaTele.deleteMessages(msg.chat_id,{[1]= Delmsg.id}) 
y = y + 1
end
end
if y == 0 then 
t = "*- لم يتم العثور على ميديا ضمن 250 رساله السابقه*"
else
t = "*- تم حذف ( "..y.." ) من الميديا *"
end
return LuaTele.sendText(msg.chat_id,msg.id,Reply_Status(msg.sender.user_id,t).Repbn,"md",true)  
end
if text == "غنيلي" then
Abs = math.random(2,140); 
local Text =" [. تم اختيار الاغنيه لك ᯓ ](t.me/YIY88Y)"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re@'},
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/TEAMSUL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "راب" then
Abs = math.random(2,140); 
local Text ='*•︙تم اختيار الاغنيه لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re@'},
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/TEAMSUL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text =" [. تم اختيار الشعر لك ᯓ ](t.me/YIY88Y)"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re1@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
{
{text = 'اخفاء الميوزك .', callback_data = IdUser..'/delAmr'},
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/shaarshahum/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "ميمز" then
Abs = math.random(2,140); 
local Text =" [متحركات Gٍٓif ᯓ ](t.me/YIY88Y)"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/https://t.me/YIY88Y/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : ︙عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*‹ : ︙اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos(UserInfo.id)
local InfoUser = LuaTele.getUserFullInfo(UserInfo.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
if photo.total_count > 0 then
local TestText = "  ❲ Owner Groups ❳\n— — — — — — — — —\n ‹ : *Owner Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n‹ : *Owner Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else

local TestText = "- معلومات المالك : \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end
if text == 'المطور' or text == 'مطور البوت' then   
local UserInfo = LuaTele.getUser(Sudo_Id) 
local InfoUser = LuaTele.getUserFullInfo(Sudo_Id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n— — — — — — — — —\n ‹ : *Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n‹ : *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers Source ❳\n— — — — — — — — —\n ‹ : *Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n‹ : *Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
if text == 'مبرمج سورس' or text == 'مطور السورس' or text == 'المبرمج' then  
local UserId_Info = LuaTele.searchPublicChat("ahmad_sors")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = " 🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :\n— — — — — — — — —\n ‹ : *Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n‹ : *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝖼𝗈𝖽𝖾𝗋 ❳', url = "https://t.me/ahmad_sors"}
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات مبرمج السورس : \\nn: name Dev . ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝖼𝗈𝖽𝖾𝗋 ❳', url = "https://t.me/ahmad_sors"}
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'محدث السورس' or text == 'مطور سورس' or text == 'المحدث' then  
local UserId_Info = LuaTele.searchPublicChat("@s36468")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = " 🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :\n— — — — — — — — —\n ‹ : *Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n‹ : *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝗎𝗉𝖽𝖺𝗍𝖾’s ❳', url = "https://t.me/VW4WV"}
},
{
{text = '- ??𝘯𝘢𝘱 𝖲𝗈𝗎𝗋𝖼𝖾 .', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات محدث السورس : \\nn: name Dev . ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url='https://t.me/s36468'},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == "مسح الرتب" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مسح المميزين', data = msg.sender.user_id..'/'.. 'DelDistinguished'},{text = 'مسح الادمنيه', data = msg.sender.user_id..'/'.. 'Addictive'},
},
{
{text = 'مسح المدراء', data = msg.sender.user_id..'/'.. 'Managers'},{text = 'مسح المنشئين', data = msg.sender.user_id..'/'.. 'Originators'},
},
{
{text = ' مسح الاساسين ', data =msg.sender.user_id..'/'.. 'TheBasics'}
},
{
{text = '❲ إخفاء الأمر ❳', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, '‹ : يمكنك من هنا التحكم في رتب المجموعة ', 'md', false, false, false, false, reply_markup)
 end  
if text == 'ريمكس' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ريمكس بصيغة بصمة', data = msg.sender.user_id..'/remexvos@'..msg_chat_id},{text = '- ريمكس MP3', data = msg.sender.user_id..'/remexmp3@'..msg_chat_id},
},
{
{text = 'إخفاء الامر', data = IdUser..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : اهلا بك عزيزي اختر الصيغة من الأسفل .*','md', true, false, false, false, reply_markup)
end
if text == 'رابط الحذف' or text == 'روابط الحذف' then
Text =[[
‹ : Hello pro buttons at the bottom to delete social media accounts .
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Delete Telegram',url="https://my.telegram.org/auth?to=delete"},{text = 'Delete Bot ',url="https://t.me/LC6BOT"}},
{{text = 'Delete Instagram',url="https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/"},{text = 'Delete rosechat',url="https://accounts.rosechat.com/accounts/login?continue=https%3A%2F%2Faccounts.rosechat.com%2Faccounts%2Fdeleteaccount"}},{{text= '❲ 𝘴????𝘱 𝖲𝗈𝗎𝗋𝖼𝖾 ❳',url="t.me/s36468"}}
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/NNAON/474&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 

if text == 'السورس' or text == 'سورس' or text == 'ياسورس' or text == 'يا سورس' then  
local Text =[[
*‹ : 𝗐ᴇʟᴄᴏ𝗆𝖾 ᴛᴏ 𝗌𝗈𝗎𝗋𝖼𝖾 𝘴𝘯𝘢𝘱 .*
— — — — — — — — —
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ' S𝘰𝘶𝘳𝘤𝘦 rose ⁦ᯓ ',url="https://t.me/s36468"},{text = ' U𝘱 𝘥𝘢𝘵𝘦𝘴 ᯓ ',url="https://t.me/ahmad_sors"}
},
{
{text = ' مطور السورس ⁦ᯓ ',url="https://t.me/ahmad_sors"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/ahmad_sors&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
if text == 'حاله الاشتراك' or text == 'حاله اشتراك البوت' then  
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url = "https://t.me/s36468"}
},
{
{text = '❲ VIP version updates ❳', url = "https://https://t.me/eilanD_Source"}
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[
‹ : حاله اشتراك البوت ❲ *Normal* ❳
— — — — — — — — —
]],"md",false, false, false, false, reply_markup)
end
if text == 'تعطيل التحقق' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Status:joinet"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل التحقق ","md",true)
end
if text == 'تفعيل التحقق' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:set(Therose.."rose:Status:joinet"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل التحقق ","md",true)
end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(Therose.."rose:Status:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(Therose.."rose:Status:Welcome"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:Id"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:IdPhoto"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'ردود المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:Reply"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل ردود المدير ","md",true)
end
if TextMsg == 'ردود المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:ReplySudo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل ردود المطور ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:BanId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Status:SetId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(Therose.."rose:Status:Games"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'اطردني' then
Redis:del(Therose.."rose:Status:KickMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل اطردني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controllerbanall(msg_chat_id,UserId_Info.id) == true then 
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الحظر', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم حظࢪه من المجموعه مسبقآ ☑ ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الحظر', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم حظࢪه من المجموعه ☑ ").Reply,"md",true, false, false, false, reply_markup)
end 
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الكتم', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم كتمه في المجموعه مسبقا ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الكتم', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم كتمه في المجموعه  ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تقييده في المجموعه \n‹ : لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تقييده في المجموعه \n‹ : لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId[3]).." } *","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n‹ : تم تقييده في المجموعه \n‹ : لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تقييده في المجموعه ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الطࢪد', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم طࢪده من المجموعه سابقآ ☑ ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الطࢪد', data = msg.sender.user_id..'/unbanktmkid@'..UserId_Info.id},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم طࢪده من المجموعه ☑ ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controllerbanall(msg_chat_id,Message_Reply.sender.user_id) == true then 
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الحظر', data = msg.sender.user_id..'/unbanktmkid@'..Message_Reply.sender.user_id},
},
}
}
if Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم حظࢪه من المجموعه مسبقآ ☑ ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم حظࢪه من المجموعه ☑ ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الكتم', data = msg.sender.user_id..'/unbanktmkid@'..Message_Reply.sender.user_id},
},
}
}
if Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم كتمه في المجموعه مسبقا ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم كتمه في المجموعه  ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/unbanktmkid@'..Message_Reply.sender.user_id},
},
}
}
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تقييده في المجموعه ").Reply,"md",true, false, false, false, reply_markup)
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Therose.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
--LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم طࢪده من المجموعه ☑ ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Controllerbanall(msg_chat_id,UserId) == true then 
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(Therose.."rose:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Therose.."rose:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/unbanktmkid@'..UserId},
},
}
}
if Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم حظࢪه من المجموعه مسبقآ ☑ ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم حظࢪه من المجموعه ☑ ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/unbanktmkid@'..UserId},
},
}
}
if Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم كتمه في المجموعه مسبقا ").Reply,"md",true, false, false, false, reply_markup)
else
Redis:sadd(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم كتمه في المجموعه  ").Reply,"md",true, false, false, false, reply_markup)
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Therose.."rose:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- الغاء الامر', data = msg.sender.user_id..'/unbanktmkid@'..UserId},
},
}
}
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم تقييده في المجموعه ").Reply,"md",true, false, false, false, reply_markup)
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"‹ : تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Therose.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم طࢪده من المجموعه ☑ ").Reply,"md",true)  
end

if text == "اطردني" or text == "طردني" then
if not Redis:get(Therose.."rose:Status:KickMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : امر اطردني تم تعطيله من قبل المدراء *","md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if StatusCanOrNotCan(msg_chat_id,msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,msg.sender.user_id).." } *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
KickMe = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
KickMe = true
else
KickMe = false
end
if KickMe == true then
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : عذرا لا استطيع طرد ادمنيه ومنشئين المجموعه*","md",true)    
end
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم طردك من المجموعه بنائآ على طلبك").Reply,"md",true)  
end

if text == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*‹ : قائمه الادمنيه \n — — — — — — — — —*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @"..UserInfo.username.."* "..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Therose.."rose:TheBasics:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Therose.."rose:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end



if text == 'كشف البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n*‹ : قائمه البوتات \n — — — — — — — — —*\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..UserInfo.username.."* "..Admin.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,listBots.."*\n— — — — — — — — —\n‹ : عدد البوتات التي هي ادمن ( "..x.." )*","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n*‹ : قائمه المقيديين \n — — — — — — — — —*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted.."*"..x.." - @"..UserInfo.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
LuaTele.sendText(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "بوت غادر" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,"*\n‹ : تم مغادرة المجموعه بامر من المطور *","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == 'تاك للكل' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*‹ : قائمه الاعضاء \n — — — — — — — — —*\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall.."*"..k.." - @"..UserInfo.username.."*\n"
else
listall = listall.."*"..k.." -* ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listall,"md",true)  
end

if text == "قفل الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:text"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:AddMempar"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:Join"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:Bot:kick"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:Bot:kick"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Therose.."rose:Lock:tagservr"..msg_chat_id,true)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Therose.."rose:lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Therose.."rose:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Therose.."rose:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Therose..'rose:'..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:AddMempar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:text"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:Join"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات " then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end  
Redis:del(Therose.."rose:Lock:tagservr"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:lockpin"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Therose.."rose:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Therose..'rose:'..lock..msg_chat_id)    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Therose.."rose:Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Therose.."rose:Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Therose.."rose:Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Therose.."rose:Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(Therose.."rose:Spam:Group:User"..msg_chat_id ,"Spam:User")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Link"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Link"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Link"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Link"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Link"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:User:Name"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:User:Name"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:User:Name"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:User:Name"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:User:Name"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:hashtak"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:hashtak"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:hashtak"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:hashtak"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:hashtak"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Cmd"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Cmd"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Cmd"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Cmd"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Cmd"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == "قفل الصور"then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Photo"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Photo"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Photo"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Photo"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصور").lockKick,"md",true)  
return false
end
if text == "قفل الفشار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:set(Therose.."rose:Lock:phshar"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفشار").Lock,"md",true)  
return false
end 
if text == 'قفل الفارسيه'  then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:set(Therose..'lock:Fars'..msg.chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفارسيه").Lock,"md",true)  
end
if text == "فتح الفشار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:del(Therose.."rose:Lock:phshar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الفشار").unLock,"md",true)  
return false
end 
if text == 'فتح الفارسيه' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:del(Therose..'lock:Fars'..msg.chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الفارسيه").unLock,"md",true)  
end
if text == "فتح الصور" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Photo"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Video"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Video"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Video"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Video"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Video"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Animation"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Animation"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Animation"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Animation"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Animation"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:geam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:geam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:geam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:geam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:geam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Audio"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Audio"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Audio"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Audio"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Audio"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:vico"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:vico"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:vico"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:vico"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:vico"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Keyboard"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Keyboard"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Keyboard"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Keyboard"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Keyboard"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Sticker"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Sticker"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Sticker"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Sticker"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Sticker"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:forward"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:forward"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:forward"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:forward"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:forward"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Document"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Document"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Document"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Document"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Document"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Unsupported"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Unsupported"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Unsupported"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Unsupported"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Unsupported"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Markdaun"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Markdaun"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Markdaun"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Markdaun"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Markdaun"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Contact"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Contact"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Contact"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Contact"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Contact"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Spam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Spam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Spam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Spam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Spam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Inlen"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Inlen"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Inlen"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Lock:Inlen"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Lock:Inlen"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"‹ : تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
Redis:setex(Therose.."rose:Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل رابط المجموعه او رابط قناة المجموعه","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Group:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not Redis:get(Therose.."rose:Status:Link"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(Therose.."rose:Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, "‹ :  Link Group : \n["..GetLink..']', 'md', true, false, false, false, reply_markup)
else
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'taha',tonumber(msg.date+86400),100,false)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return LuaTele.sendText(msg_chat_id, msg_id, "‹ :  Link Group : \n["..LinkGroup.invite_link..']', 'md', true, false, false, false, reply_markup)
end
end

if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي الترحيب الان".."\n‹ : تستطيع اضافة مايلي !\n‹ : دالة عرض الاسم »{`name`}\n‹ : دالة عرض المعرف »{`user`}\n‹ : دالة عرض اسم المجموعه »{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(Therose.."rose:Status:Welcome"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(Therose.."rose:Welcome:Group"..msg_chat_id)
if Welcome then 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لم يتم تعيين ترحيب للمجموعه","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Welcome:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم ازالة ترحيب المجموعه","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Group:Rules"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم ازالة قوانين المجموعه","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(Therose.."rose:Group:Rules" .. msg_chat_id)   
if Rules then     
return LuaTele.sendText(msg_chat_id,msg_id,Rules,"md",true)     
else      
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(Therose.."rose:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي وصف المجموعه الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم ازالة قوانين المجموعه","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تغيير اسم المجموعه الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(Therose.."rose:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(Therose.."rose:Filter:Group:"..v..msg_chat_id)  
Redis:srem(Therose.."rose:List:Filter"..msg_chat_id,v)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n*‹ : قائمه المنع \n — — — — — — — — —*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(Therose.."rose:Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." » { "..Text_Filter.." }*\n"    
end  
LuaTele.sendText(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(Therose.."rose:Command:List:Group"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:Command:List:Group"..msg_chat_id.."")
Command = "‹ : قائمه الاوامر المضافه  \n— — — — — — — — —\n"
for k,v in pairs(list) do
Commands = Redis:get(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "‹ : لا توجد اوامر اضافيه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : تم الغاء تثبيت جميع الرسائل","md",true)
for i=0, 20 do
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if not LuaTele.getChatPinnedMessage(msg_chat_id).id then
break
end
end
end
if text == "الحمايه" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل ردود المدير', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل ردود المدير', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل ردود المطور', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود المطور', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, '‹ : اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if Redis:get(Therose.."rose:Status:Link"..msg.chat_id) then
Statuslink = '❬ ✔️ ❭' else Statuslink = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:Welcome"..msg.chat_id) then
StatusWelcome = '❬ ✔️ ❭' else StatusWelcome = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:Id"..msg.chat_id) then
StatusId = '❬ ✔️ ❭' else StatusId = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '❬ ✔️ ❭' else StatusIdPhoto = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:Reply"..msg.chat_id) then
StatusReply = '❬ ✔️ ❭' else StatusReply = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '❬ ✔️ ❭' else StatusReplySudo = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:BanId"..msg.chat_id)  then
StatusBanId = '❬ ✔️ ❭' else StatusBanId = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:SetId"..msg.chat_id) then
StatusSetId = '❬ ✔️ ❭' else StatusSetId = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
StatusGames = '❬ ✔️ ❭' else StatusGames = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:KickMe"..msg.chat_id) then
Statuskickme = '❬ ✔️ ❭' else Statuskickme = '❬ ❌ ❭'
end
if Redis:get(Therose.."rose:Status:AddMe"..msg.chat_id) then
StatusAddme = '❬ ✔️ ❭' else StatusAddme = '❬ ❌ ❭'
end
local protectionGroup = '\n*‹ : اعدادات حمايه المجموعه\n — — — — — — — — —\n'
..'\n‹ : جلب الرابط ➤ '..Statuslink
..'\n‹ : جلب الترحيب ➤ '..StatusWelcome
..'\n‹ : الايدي ➤ '..StatusId
..'\n‹ : الايدي بالصوره ➤ '..StatusIdPhoto
..'\n‹ : ردود المدير ➤ '..StatusReply
..'\n‹ : ردود المطور ➤ '..StatusReplySudo
..'\n‹ : الرفع ➤ '..StatusSetId
..'\n‹ : الحظر - الطرد ➤ '..StatusBanId
..'\n‹ : الالعاب ➤ '..StatusGames
..'\n‹ : امر اطردني ➤ '..Statuskickme..'*\n\n.'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url = 't.me/s36468'}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n‹ : اعدادات المجموعه ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n🔓︙علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'المجموعه' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local permissions = '*\n‹ : صلاحيات المجموعه :\n— — — — — — — — —'..'\n‹ : ارسال الويب : '..web..'\n‹ : تغيير معلومات المجموعه : '..info..'\n‹ : اضافه مستخدمين : '..invite..'\n‹ : تثبيت الرسائل : '..pin..'\n‹ : ارسال الميديا : '..media..'\n‹ : ارسال الرسائل : '..messges..'\n‹ : اضافه البوتات : '..other..'\n‹ : ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n‹ : معلومات المجموعه :\n— — — — — — — — —'..' \n‹ : عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n‹ : عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n‹ : عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n‹ : عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n‹ : اسم المجموعه : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return LuaTele.sendText(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات المجموعه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات المجموعه : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "‹ :  الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Therose..'rose:Originators:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Therose..'rose:Managers:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Therose..'rose:Addictive:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Therose..'rose:Distinguished:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Developers:Groups",Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(Therose.."rose:Developers:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Therose..'rose:Originators:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Therose..'rose:Managers:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Therose..'rose:Addictive:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Therose..'rose:Distinguished:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(Therose.."rose:Developers:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(Therose.."rose:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(Therose.."rose:Originators:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(Therose.."rose:Managers:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Developers:Groups",UserId_Info.id)
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Therose.."rose:Distinguished:Group"..msg_chat_id, UserId_Info.id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : تم تنزيل الشخص من الرتب التاليه ( "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *)","md",true)  
end
if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Therose.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..Message_Reply.sender.user_id.."&can_invite_users=True")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Therose.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..UserId_Info.id.."&can_invite_users=True")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
end 
if text == 'لقبي' then
Ge = https.request("https://api.telegram.org/bot".. Token.."/getChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..msg.sender.user_id)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : ليس لديك لقب*',"md",true) 
else
LuaTele.sendText(msg_chat_id,msg_id,'‹ : لقبك هو : '..GeId.result.custom_title,"md",true) 
end
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "‹ :  صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "‹ :  صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"‹ : تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(Therose..'rose:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
Redis:del(Therose..'rose:Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(Therose..'rose:Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'‹ : تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
LuaTele.sendText(msg_chat_id,msg_id,'‹ : عدد رسائلك هنا *~ '..(Redis:get(Therose..'rose:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'‹ : عدد التعديلات هنا *~ '..(Redis:get(Therose..'rose:Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'‹ : عدد جهاتك المضافه هنا *~ '..(Redis:get(Therose.."rose:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Addictive then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end


if text == 'تعين الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
‹ : ارسل الان النص
‹ : يمكنك اضافه :
‹ : `#username` » اسم المستخدم
‹ : `#msgs` » عدد الرسائل
‹ : `#photos` » عدد الصور
‹ : `#id` » ايدي المستخدم
‹ : `#auto` » نسبة التفاعل
‹ : `#stast` » رتبة المستخدم 
‹ : `#edit` » عدد السحكات
‹ : `#game` » عدد المجوهرات
‹ : `#AddMem` » عدد الجهات
‹ : `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Set:Id:Group"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, '‹ : تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(3)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مالكين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:TheBasicsQ:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المالكين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.TheBasicsQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(44)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:TheBasics:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(4)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد منشئين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Originators:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(5)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مدراء حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Managers:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد ادمنيه حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Addictive:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مميزين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Distinguished:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المميزين *","md",true)
end
if TextMsg == 'المحظورين عام' or TextMsg == 'قائمه العام' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(2)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(Therose.."rose:BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:BanGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المحظورين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مكتومين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:SilentGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..x.."} من المقيديين *","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عدد البوتات الموجوده : "..#List_Members.."\n‹ : تم طرد ( "..x.." ) بوت من المجموعه *","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عدد المطرودين في الموجوده : "..#List_Members.."\n‹ : تم الغاء الحظر عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : تم طرد ( "..x.." ) حساب محذوف *","md",true)  
end
end


if text == ("مسح ردود المدير") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(Therose.."rose:Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(Therose.."rose:Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(Therose.."rose:Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(Therose.."rose:Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(Therose.."rose:List:Manager"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم مسح قائمه ردود المدير","md",true)  
end
if text == ("ردود المدير") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Manager"..msg_chat_id.."")
text = "‹ : قائمه ردود المدير \n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(Therose.."rose:Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه 🎭"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه 📢"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق 🃏"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ✉"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره 🎇"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو 📹"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف ‹ : "
elseif Redis:get(Therose.."rose:Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه 🎵"
elseif Redis:get(Therose.."rose:Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "‹ : عذرا لا يوجد ردود للمدير في المجموعه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لاضافتها في ردود المدير ","md",true)  
end
if text == "حذف رد" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لحذفها من ردود المدير","md",true)  
end
if text == ("مسح ردود المطور") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Therose.."rose:Add:Rd:Sudo:Gif"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:vico"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:stekr"..v)     
Redis:del(Therose.."rose:Add:Rd:Sudo:Text"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:Photo"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:Video"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:File"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:Audio"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:video_note"..v)
Redis:del(Therose.."rose:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف ردود المطور","md",true)  
end
if text == ("ردود المطور") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Rd:Sudo")
text = "\n📝︙قائمة ردود المطور \n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(Therose.."rose:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:File"..v) then
db = "ملف ‹ : "
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "‹ : لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد للكل" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لاضافتها في ردود المطور ","md",true)  
end
if text == "حذف رد للكل" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لحذفها من ردود المطور","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي التوجيه الان\n‹ : ليتم نشره في المجموعات","md",true)  
return false
end

if text=="اذاعه خاص بالتوجيه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي التوجيه الان\n‹ : ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : معلومات الكشف \n— — — — — — — — —"..'\n‹ : الحظر العام : '..BanAll..'\n‹ : الحظر : '..BanGroup..'\n‹ : الكتم : '..SilentGroup..'\n‹ : التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : معلومات الكشف \n— — — — — — — — —"..'\n‹ : الحظر العام : '..BanAll..'\n‹ : الحظر : '..BanGroup..'\n‹ : الكتم : '..SilentGroup..'\n‹ : التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Therose.."rose:BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Therose.."rose:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Therose.."rose:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Therose.."rose:BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Therose.."rose:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Therose.."rose:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:GetTexting:DevTherose'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ :  ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose..'rose:Texting:DevTherose')
return LuaTele.sendText(msg_chat_id,msg_id,'‹ :  تم حذف كليشه المطور')
end

if text == 'الاوامر' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = msg.sender.user_id..'/help1'}, {text = '- 𝟐 -', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '- 𝟑 -', data = msg.sender.user_id..'/help3'}, {text = '- 𝟒 -', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '- 𝟓 -', data = msg.sender.user_id..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'},
},
{
{text = '- الالعاب -', data = msg.sender.user_id..'/help6'},
},
{
{text = '- القفل و الفتح -', data = msg.sender.user_id..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = msg.sender.user_id..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
↜ توجد -› 8 اوامر في البوت
— — — — — — — — — 
‹ : ارسل م1 -› اوامر الحمايه↡
‹ : ارسل م2 -› اوامر الادمنيه↡
‹ : ارسل م3 -› اوامر المدراء↡
‹ : ارسل م4 -› اوامر المنشئين↡
‹ : ارسل م5 -› اوامر مطورين البوت↡
‹ : ارسل م6 -› اوامر التسليه+التحشيش↡
*]],"md",false, false, false, false, reply_markup)
elseif text == 'م1' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م2' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م3' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م4' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م5' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ قائمه الاوامر }', data = msg.sender.user_id..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
{
{text = 'إخفاء الأمر', data = msg.sender.user_id..'/delAmr'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ : عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
end
if text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "‹ :  تم تحديث الملفات ♻","md",true)
dofile('rosebot.lua')  
end
if text == "تغير اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف اسم البوت ","md",true)   
end
if text == (Redis:get(Therose.."rose:Name:Bot") or "الروكس") then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "الروكس")
local NameBots = {
"يروح "..NamesBot.. " كول؟",
"انا "..NamesBot.. " القميل",
"هاعمري",
"تفضل ؟",
"محتاج شي صيحني بأسمي \n القميل "..NamesBot,
'هاها شتريد'
}
return LuaTele.sendText(msg_chat_id,msg_id, NameBots[math.random(#NameBots)],"md",true)  
end
if text == "بوت" or text == "البوت" or text == "bot" or text == "Bot" then
local photo = LuaTele.getUserProfilePhotos(Therose)
local UserInfo = LuaTele.getUser(Therose)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "الروكس")
local BotName = {
"نادني "..NamesBot.. " عزيزي",
"عزيزي اسمي "..NamesBot.. " وانت ؟",
}
NamesBots = BotName[math.random(#BotName)]
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = NamesBots, url = 'https://t.me/s36468'}, 
},
{
{text = '‹ : أضفني .', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == (Redis:get(Therose.."rose:Name:Bot") or "آيلاند") then
local photo = LuaTele.getUserProfilePhotos(Therose)
local UserInfo = LuaTele.getUser(Therose)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "آيلاند")
local BotName = {
"يروح "..NamesBot.. " كول؟",
"انا "..NamesBot.. " القميل",
"هاعمري",
"تفضل ؟",
"محتاج شي صيحني بأسمي \n القميل "..NamesBot,
'هاها شتريد'
}
NamesBots = BotName[math.random(#BotName)]
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = NamesBots, url = 'https://t.me/s36468'}, 
},
{
{text = '‹ : أضفني .', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "كيف الحال" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "الروكس")
local BotName = {
"الحمد لله ونته",
"على قول @ahmad_sors ع الباري ونتَ",
"انا بخير",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == "بوسه" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "rose")
local BotName = {
"اهممممواح🙈😉.",
"عيع خدك وصخ 😹🏃‍♀️.",
"اوفف اخدر اذاابوسه 🙈😻.",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == "رزله" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "rose")
local BotName = {
"تع دنك راسك وبالحذاء وبالحذاء وعراسك 😹🏃‍♀️.",
"خيولي هوه مندر مال اهاين ورزايل😹🏃‍♀️.",
"تع لك العار اليوم اشبعك رزايل 😹🏃‍♀️.",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == "تفله" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "rose")
local BotName = {
"اخخختفووو ام لمخاطيه بكصتك 😹🏃‍♀️.",
"اختفوووو يلعار ابلع من عمك توفي😹🏃‍♀️.",
"اختفوو ابلعها وكول عسل 😹🏃‍♀️.",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == "هينه" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "rose")
local BotName = {
"انته واحد زباله وعار ع المجتمع حبي 😹🏃‍♀️.",
"خيولي هوه مندر مال اهاين ورزايل😹🏃‍♀️.",
"يلفاشل انته موقعك منتلكرام شنو كاضيها زحف وكساع مضروب بوري 😹🏃‍♀️.",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == "مصه" then
local NamesBot = (Redis:get(Therose.."rose:Name:Bot") or "rose")
local BotName = {
"اوف امص خدودك المربربا 🙈😻.",
"عيب حبي شنو امصه اتبسز🌝❤️.",
"اجي امصك بركبتك واخليراثر وابوك يكتلك بلقندره 🙈😻.",
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Therose..'rose:Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' }\n‹ : تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' }\n‹ : لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Therose)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'*‹ : البوت عظو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(Therose..'rose:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Therose..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Therose..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Therose..'rose:ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' } للمجموعات \n‹ : تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n‹ : تم تعطيل المجموعه ومغادره البوت من الوهمي *',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' } للمجموعات \n‹ : لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","??","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","🌡","💣","‹ : ","📍","📓","📗","📂","📅","📪","📫","‹ : ","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(Therose.."rose:Game:Smile"..msg.chat_id,SM)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end
if text == "كت" or text == "كت تويت" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" آخر مره ضربت عشره كانت متى ؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"آخر مره ضربت عشره كانت متى ؟", 
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
    "هل انت دي تويت باعت باندا؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "هل انت حرامي تويت بتعت باندا؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
   "هل انت تحب باندا؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغيرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
   "هل باندا لطيف؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغيره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
   "لي باندا ناك اليكس؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "الاسرع" or tect == "ترتيب" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفه","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","كهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","بتيته","لهانه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنيت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(Therose.."rose:Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفه","ه ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بزونه","ز و ه ن")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"كهوه","ه ك ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"بتيته","ب ت ت ي ه")
name = string.gsub(name,"لهانه","ه ن ل ه ل")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنيت","ا ت ن ر ن ي ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "خيروك" or text == "لوخيروك" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
local texting = {
"الو خيروك بين البقاء مدى الحياة مع أخيك أو البقاء مدى الحياة مع حبيبك من تختار؟",
"لو عرضوا عليك السفر لمدة 20 عام مع شخص واحد فقط من تختار؟",
"امن تحب أكثر والدك أم والدتك؟",
"الو خيروك بين إعطاء هدية باهظة الثمن لفرد من أفراد أسرتك من تختار؟",
"لو خيروك بين الذكاء أو الثراء ماذا تختار؟",
"لو خيروك بين الزواج من شخص تحبه أو شخص سيحقق لك جميع أحلامك من تختار؟",
"الو خيروك بين المكوث مدى الحياة مع صديقك المفضل أو مع حبيبك من تختار؟",
"الو خيروك بين الشهادة الجامعية أو السفر حول العالم؟",
"الو خيروك بين العيش في نيويورك أو في لندن أيهما تختار؟",
"لو خيروك بين العودة إلى الماضي أو الذهاب إلى المستقبل أيهما تختار؟",
"لو خيروك بين تمتع شريك حياتك بصفة من الأثنين الطيبة أو حسن التصرف أيهما تختار؟",
"لو خيروك بين الزواج من شخص في عمرك فقير أو شخص يكبرك بعشرين عام غني من تختار",
"لو خيروك بين قتلك بالسم أو قتلك بالمسدس ماذا تختار؟",
"لو خيروك بين إنقاذ والدك أو إنقاذ والدتك من تختار؟",
}
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "بوب" or text == "مشاهير" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
KlamSpeed = {"شوان","سام","ايد شيرين","جاستين","اريانا","سام سميث","ايد","جاستين","معزه","ميسي","صلاح","محمد صلاح","احمد عز","كريستيانو","كريستيانو رونالدو","رامز جلال","امير كراره","ويجز","بابلو","تامر حسني","ابيو","شيرين","نانسي عجرم","محمد رمضان","احمد حلمي","محمد هنيدي","حسن حسني","حماقي","احمد مكي"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(Therose.."mshaher"..msg.chat_id,name)
name = string.gsub(name,"شوان","https://t.me/HC6HH/8")
name = string.gsub(name,"سام","https://t.me/HC6HH/7")
name = string.gsub(name,"سام سميث","https://t.me/HC6HH/7")
name = string.gsub(name,"ايد شيرين","https://t.me/HC6HH/6")
name = string.gsub(name,"ايد","https://t.me/HC6HH/6")
name = string.gsub(name,"جاستين","https://t.me/HC6HH/4")
name = string.gsub(name,"جاستين بيبر","https://t.me/HC6HH/4")
name = string.gsub(name,"اريانا","https://t.me/HC6HH/5")
name = string.gsub(name,"ميسي","https://t.me/HC6HH/10")
name = string.gsub(name,"معزه","https://t.me/HC6HH/10")
name = string.gsub(name,"صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"محمد صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"احمد عز","https://t.me/HC6HH/12")
name = string.gsub(name,"كريم عبدالعزيز","https://t.me/HC6HH/11")
name = string.gsub(name,"كريستيانو رونالدو","https://t.me/HC6HH/13")
name = string.gsub(name,"كريستيانو","https://t.me/HC6HH/13")
name = string.gsub(name,"امير كراره","https://t.me/HC6HH/14")
name = string.gsub(name,"رامز جلال","https://t.me/HC6HH/15")
name = string.gsub(name,"ويجز","https://t.me/HC6HH/16")
name = string.gsub(name,"بابلو","https://t.me/HC6HH/17")
name = string.gsub(name,"ابيو","https://t.me/HC6HH/20")
name = string.gsub(name,"شيرين","https://t.me/HC6HH/21")
name = string.gsub(name,"نانسي عجرم","https://t.me/HC6HH/22")
name = string.gsub(name,"محمد رمضان","https://t.me/HC6HH/25")
name = string.gsub(name,"احمد حلمي","https://t.me/HC6HH/26")
name = string.gsub(name,"محمد هنيدي","https://t.me/HC6HH/27")
name = string.gsub(name,"حسن حسني","https://t.me/HC6HH/28")
name = string.gsub(name,"احمد مكي","https://t.me/HC6HH/29")
name = string.gsub(name,"تامر حسني","https://t.me/HC6HH/30")
name = string.gsub(name,"حماقي","https://t.me/HC6HH/31")
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..name.."&caption="..URL.escape("اسرع واحد يكول اسم هذا الفنان").."&reply_to_message_id="..(msg.id/2097152/0.5))
--return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "صراحه" or text == "جرأه" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
local texting = {
"هل تعرضت لغدر في حياتك؟",
"هل تعرف عيوبك؟",
"هل أنت مُسامح أم لا تستطيع أن تُسامح؟",
"إذا قمت بالسفر إلى نُزهة خارج بلدك فمن هو الشخص الذي تُحب أن يُرافقك؟هل تتدخل إذا وجدت شخص يتعرض لحادثة سير أم تتركه وترحل؟",
"ما هو الشخص الذي لا تستطيع أن ترفض له أي طلب؟",
"إذا أعجبت بشخصٍ ما، كيف تُظهر له هذا الإعجاب أو ما هي الطريقة التي ستتبعها لتظهر إعجابك به؟",
"هل ترى نفسك مُتناقضً؟",
"ما هو الموقف الذي تعرضت فيه إلى الاحراج المُبرح؟",
"ما هو الموقف الذي جعلك تبكي أمام مجموعة من الناس رغمًا عنك؟",
"إذا جاء شريك حياتك وطلب الانفصال، فماذا يكون ردك وقته؟",
"إذا كان والد يعمل بعملٍ فقير هل تقبل به أو تستعر منه؟",
"ما الذي يجعلك تُصاب بالغضب الشديد؟",
"هإذا وجدت الشخص الذي أحببتهُ في يومٍ ما يمسك بطفله، هل هذا سيشعرك بالألم؟",
"علاقتك مع اهلك",
"ثلاثة أشياء تحبها"
}
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حزوره" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(Therose.."rose:Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يحل الحزوره ↓\n {"..name.."}","md",true)  
end
end
if text == "معاني" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Redis:del(Therose.."rose:Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(Therose.."rose:Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","??")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","??")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يدز معنى السمايل ~ {"..name.."}","md",true)  
end
end
if text == "اعلام" or text == "اعلام ودول" or text == "اعلام و دول" or text == "دول" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Redis:del(Therose.."Set:Country"..msg.chat_id)
Country_Rand = {"مصر","العراق","السعوديه","المانيا","تونس","الجزائر","فلسطين","اليمن","المغرب","البحرين","فرنسا","سويسرا","تركيا","انجلترا","الولايات المتحده","كندا","الكويت","ليبيا","السودان","سوريا"}
name = Country_Rand[math.random(#Country_Rand)]
Redis:set(Therose.."Game:Countrygof"..msg.chat_id,name)
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"المانيا","🇩🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"المغرب","🇲🇦")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"فرنسا","🇫🇷")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"انجلترا","🇬🇧")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"الولايات المتحده","🇱🇷")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"الكويت","🇰🇼")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"سوريا","🇸🇾")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يرسل اسم الدولة ~ {"..name.."}","md",true)  
end
end
if text == "انكليزي" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Redis:del(Therose.."Set:enkliz"..msg.chat_id)
enkliz_Rand = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = enkliz_Rand[math.random(#enkliz_Rand)]
Redis:set(Therose.."Game:enkliz"..msg.chat_id,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يترجم ~ {"..name.."}","md",true)  
end
end
if text == "العكس" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Redis:del(Therose.."rose:Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(Therose.."rose:Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"ناصي","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يدز العكس ~ {"..name.."}","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { 👊 }', data = '/Mahibes1'}, {text = '𝟐 » { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 » { 👊 }', data = '/Mahibes3'}, {text = '𝟒 » { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 » { 👊 }', data = '/Mahibes5'}, {text = '𝟔 » { 👊 }', data = '/Mahibes6'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
‹ :  لعبه المحيبس هي لعبة الحظ 
‹ : جرب حظك ويه البوت واتونس 
‹ : كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(Therose.."rose:Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."‹ : ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."‹ : سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(Therose.."rose:Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍??👩‍‍💻👨‍💻??‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍??👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳??‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀??‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يدز الاختلاف ~ {"..name.."}","md",true)  
end
end
if text == "امثله" then
if Redis:get(Therose.."rose:Status:Games"..msg.chat_id) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(Therose.."rose:Game:Example"..msg.chat_id,name)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : اسرع واحد يكمل المثل ~ {"..name.."}","md",true)  
end
end
if text and text:match("^بيع مجوهراتي (%d+)$") then
local NumGame = text:match("^بيع مجوهراتي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*‹ : لا استطيع البيع اقل من 1 *","md",true)  
end
local NumberGame = Redis:get(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ليس لديك جواهر من الالعاب \n‹ : اذا كنت تريد ربح الجواهر \n‹ : ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : ليس لديك جواهر بهاذا العدد \n‹ : لزيادة مجوهراتك في اللعبه \n‹ : ارسل الالعاب وابدأ اللعب !","md",true)   
end
local NumberGet = (NumGame * 50)
Redis:decrby(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(Therose.."rose:Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,NumGame)  
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم خصم *~ { "..NumGame.." }* من مجوهراتك \n‹ : وتم اضافة* ~ { "..(NumGame * 50).." } رساله الى رسالك *","md",true)  
end 
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(Therose.."rose:Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف مجوهرات (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم اضافه له { "..text:match("^اضف مجوهرات (%d+)$").." } من المجوهرات").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n‹ : عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(Therose.."rose:Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"‹ : تم اضافه له { "..text:match("^اضف رسائل (%d+)$").." } من الرسائل").Reply,"md",true)  
end
if text == "مجوهراتي" then 
local Num = Redis:get(Therose.."rose:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id, "‹ : لم تفز بأي مجوهره ","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id, "‹ : عدد الجواهر التي ربحتها *← "..Num.." *","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(6)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'مط','رفع مطور')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'تك','تنزيل الكل')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'ر','الرابط')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'رر','ردود المدير')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'،،','مسح المكتومين')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'رد','اضف رد')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'سح','مسح سحكاتي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'غ','غنيلي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'رس','رسائلي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..msg_chat_id..":"..'ثانوي','رفع مطور ثانوي')

return LuaTele.sendText(msg_chat_id,msg_id,[[*
‹ : تم ترتيب الاوامر بالشكل التالي ~
‹ :  ايدي - ا .
‹ :  رفع مميز - م .
‹ : رفع ادمن - اد .
‹ :  رفع مدير - مد . 
‹ :  رفع منشى - من . 
‹ :  رفع منشئ الاساسي - اس  .
‹ :  رفع مطور - مط .
‹ : رفع مطور ثانوي - ثانوي .
‹ :  تنزيل الكل - تك .
‹ :  تعطيل الايدي بالصوره - تعط .
‹ :  تفعيل الايدي بالصوره - تفع .
‹ :  الرابط - ر .
‹ :  ردود المدير - رر .
‹ :  مسح المكتومين - ،، .
‹ :  اضف رد - رد .
‹ :  مسح سحكاتي - سح .
‹ :  مسح رسائلي - رس .
‹ :  غنيلي - غ .
*]],"md")
end

end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات' or text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "‹ :  تم تحديث الملفات ♻","md",true)
dofile('rosebot.lua')  
end
if text == '/start' then
Redis:sadd(Therose..'rose:Num:User:Pv',msg.sender.user_id)  
if not msg.ControllerBot then
if not Redis:get(Therose.."rose:Start:Bot") then
local CmdStart = '*\n‹ : اهلا بك عزيزي في بوت '..(Redis:get(Therose.."rose:Name:Bot") or "rose")..
'\n‹ : حمايه ضد التفليش + سريع جدا .'..
'\n‹ : فقط ارفع البوت مشرف (ادمن) .'..
'\n‹ : واكتب تفعيل داخل المجموعه .'..
'\n‹ : البوت الاسرع والاقوا ع التلكرام .'..
'\n‹ : للأستفسار عمري اي مشكله راسل المطور - .'..
'\n‹ : المطور | <@'..UserSudo..'>*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ : أضفني .', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '‹ : شࢪوحات السوࢪس -', url = 't.me/s36468'}, {text = '‹ : شراء بوت', url = 't.me/ahmad_sors'},
},
{
{text = '‹ : سۅࢪس الروكس -', url = 't.me/s36468'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,CmdStart,"md",false, false, false, false, reply_markup)
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ : أضفني .', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '‹ : شࢪوحات السوࢪس', url = 't.me/ahmad_sors'}, {text = '‹ : شراء بوت', url = 't.me/ahmad_sors'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :', url = 't.me/s36468'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(Therose.."rose:Start:Bot"),"md",false, false, false, false, reply_markup)
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'تفعيل التواصل',type = 'text'},{text = 'تعطيل التواصل', type = 'text'},
},
{
{text = 'تفعيل البوت الخدمي',type = 'text'},{text = 'تعطيل البوت الخدمي', type = 'text'},
},
{
{text = 'اذاعه للمجموعات',type = 'text'},{text = 'اذاعه خاص', type = 'text'},
},
{
{text = 'اذاعه بالتوجيه',type = 'text'},{text = 'اذاعه بالتوجيه خاص', type = 'text'},
},
{
{text = 'اذاعه بالتثبيت',type = 'text'},
},
{
{text = 'المطورين الثانويين',type = 'text'},{text = 'المطورين',type = 'text'},{text = 'قائمه العام', type = 'text'},
},
{
{text = 'مسح المطورين الثانويين',type = 'text'},{text = 'مسح المطورين',type = 'text'},{text = 'مسح قائمه العام', type = 'text'},
},
{
{text = 'تغيير اسم البوت',type = 'text'},{text = 'حذف اسم البوت', type = 'text'},
},
{
{text = 'الاشتراك الاجباري',type = 'text'},{text = 'تغيير الاشتراك الاجباري',type = 'text'},
},
{
{text = 'تفعيل الاشتراك الاجباري',type = 'text'},{text = 'تعطيل الاشتراك الاجباري',type = 'text'},
},
{
{text = 'الاحصائيات',type = 'text'},
},
{
{text = 'تغغير كليشه المطور',type = 'text'},{text = 'حذف كليشه المطور', type = 'text'},
},
{
{text = 'تغيير كليشه ستارت',type = 'text'},{text = 'حذف كليشه ستارت', type = 'text'},
},
{
{text = 'تنظيف المجموعات',type = 'text'},{text = 'تنظيف المشتركين', type = 'text'},
},
{
{text = 'جلب نسخه احتياطيه',type = 'text'},{text = 'جلب نسخه الردود',type = 'text'},
},
{
{text = 'اضف رد عام',type = 'text'},{text = 'حذف رد عام', type = 'text'},
},
{
{text = 'الردود العامه',type = 'text'},{text = 'مسح الردود العامه', type = 'text'},
},
{
{text = 'تحديث الملفات',type = 'text'},{text = 'تحديث السورس', type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'‹ :  اهلا بك عزيزي المطور ', 'md', false, false, false, false, reply_markup)
end
end

if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Therose..'rose:Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' }\n‹ : تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' }\n‹ : لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Therose)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'*‹ : البوت عظو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(Therose..'rose:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Therose..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Therose..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Therose..'rose:ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' } للمجموعات \n‹ : تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n‹ : تم تعطيل المجموعه ومغادره البوت من الوهمي *',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*‹ : العدد الكلي { '..#list..' } للمجموعات \n‹ : لا توجد مجموعات وهميه*',"md")
end
end
if text == 'تغيير كليشه ستارت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Change:Start:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  ارسل لي كليشه Start الان ","md",true)  
end
if text == 'حذف كليشه ستارت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Start:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف كليشه Start ","md",true)   
end
if text == 'تغيير اسم البوت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ :  ارسل لي الاسم الان ","md",true)  
end
if text == 'حذف اسم البوت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'*‹ :  تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,'*‹ : عدد احصائيات البوت الكامله \n— — — — — — — — —\n‹ : عدد المجموعات : '..(Redis:scard(Therose..'rose:ChekBotAdd') or 0)..'\n‹ : عدد المشتركين : '..(Redis:scard(Therose..'rose:Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'الرتبه' or text == 'رتبته'  and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local RinkBot = Controller(msg_chat_id,UserId)
local NumAdd = Redis:get(Therose.."rose:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Therose.."rose:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*⦁ الرتبه -› '..RinkBot..
'*',"md",true) 
end
end
if text == 'ايديي' then
return LuaTele.sendText(msg_chat_id,msg_id,'\nايديك -› '..msg.sender.user_id,"md",true)  
end
if text == 'تغغير كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose..'rose:GetTexting:DevTherose'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'‹ :  ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose..'rose:Texting:DevTherose')
return LuaTele.sendText(msg_chat_id,msg_id,'‹ :  تم حذف كليشه المطور')
end
if text == 'اضف رد عام' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لاضافتها في ردود المطور ","md",true)  
end
if text == 'حذف رد عام' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل الان الكلمه لحذفها من ردود المطور","md",true)  
end
if text=='اذاعه خاص' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=='اذاعه للمجموعات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ‹ : ملصق ‹ : متحركه ‹ : صوره
 ‹ : فيديو ‹ : بصمه الفيديو ‹ : بصمه ‹ : صوت ‹ : رساله ❩
— — — — — — — — —
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي التوجيه الان\n‹ : ليتم نشره في المجموعات","md",true)  
return false
end

if text=='اذاعه بالتوجيه خاص' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Therose.."rose:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"‹ : ارسل لي التوجيه الان\n‹ : ليتم نشره الى المشتركين","md",true)  
return false
end

if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Rd:Sudo")
text = "\n📝︙قائمة ردود المطور \n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(Therose.."rose:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:File"..v) then
db = "ملف ‹ : "
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif Redis:get(Therose.."rose:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "‹ : لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("مسح الردود العامه") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Therose.."rose:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Therose.."rose:Add:Rd:Sudo:Gif"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:vico"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:stekr"..v)     
Redis:del(Therose.."rose:Add:Rd:Sudo:Text"..v)   
Redis:del(Therose.."rose:Add:Rd:Sudo:Photo"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:Video"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:File"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:Audio"..v)
Redis:del(Therose.."rose:Add:Rd:Sudo:video_note"..v)
Redis:del(Therose.."rose:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم حذف ردود المطور","md",true)  
end
if text == 'مسح المطورين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Therose.."rose:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(Therose.."rose:BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*‹ : تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if text == 'تعطيل البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل البوت الخدمي ","md",true)
end
if text == 'تعطيل التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:del(Therose.."rose:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل البوت الخدمي ","md",true)
end
if text == 'تفعيل التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
Redis:set(Therose.."rose:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : تم تفعيل التواصل داخل البوت ","md",true)
end
if text == 'قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end 
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه المحظورين عام  \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
var(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه مطورين البوت \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*‹ : هاذا الامر يخص ( '..Controller_Num(1)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(Therose..'rose:Channel:Join:Name')..'', url = 't.me/'..Redis:get(Therose..'rose:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n‹ : عذࢪا عمࢪي عليك الاشتࢪاك بقناه البوت -*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Therose.."rose:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"‹ : لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*‹ : قائمه مطورين البوت \n — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if not msg.ControllerBot then
if Redis:get(Therose.."rose:TwaslBot") and not Redis:sismember(Therose.."rose:BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(Therose.."rose:Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
LuaTele.sendText(IdSudo,0,Reply_Status(IdUser,'‹ : قام بارسال الملصق').Reply,"md",true)  
end
return LuaTele.sendText(IdUser,msg_id,Reply_Status(IdUser,'‹ : تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(Therose.."rose:Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(Therose..'rose:BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'‹ : تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(Therose..'rose:BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'‹ : تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'‹ : قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
LuaTele.sendText(Info_User,0,text,"md",true)
end 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'‹ : تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run


function CallBackLua(data) --- هذا الكالباك بي الابديت
--var(data) 
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
Redis:srem(Therose.."rose:ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(Therose..'*'..'-100'..data.supergroup.id)
for i = 1, #keys do
Redis:del(keys[i])
end
return LuaTele.sendText(Sudo_Id,0,'*\n‹ : تم طرد البوت من مجموعه جديده \n‹ : اسم المجموعه : '..Get_Chat.title..'\n‹ : ايدي المجموعه :*`-100'..data.supergroup.id..'`\n‹ : تم مسح جميع البيانات المتعلقه بالمجموعه',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end
if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(Therose.."rose:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Therose.."rose:PinMsegees:"..msg.chat_id)
end
end

elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(Therose.."rose:Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(Therose) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(Therose..'rose:Status:joinet'..data.message.chat_id) == 'true' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ انا لست بوت }', data = data.message.sender.user_id..'/UnKed'},
},
}
} 
LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(data.message.chat_id, data.message.id, '▽︙عليك اختيار انا لست بوت لتخطي نضام التحقق', 'md',false, false, false, false, reply_markup)
end

File_Bot_Run(data.message,data.message)

elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == Therose then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
Redis:incr(Therose..'rose:Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(Therose.."rose:Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
-- data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
if Text and Text:match('(%d+)/filme@') then
local UserId = Text:match('(%d+)/filme@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(4,80); 
local Text ='*‹ : تم اختيار الفلم لك*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. ChatId .. '&photo=https://t.me/MoviesWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/remexmp3@') then
local UserId = Text:match('(%d+)/remexmp3@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,400); 
local Text ='*‹ : تم اختيار الريمكس بصيغة MP3*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '‹ : مره اخرى 🔃 .', callback_data = IdUser..'/remexmp3@'},
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/RemixWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/remexvos@') then
local UserId = Text:match('(%d+)/remexvos@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,400); 
local Text ='*‹ : تم اختيار الريمكس بصيغة بصمة*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '‹ : مره اخرى 🔃 .', callback_data = IdUser..'/remexvos@'},
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/remixsource/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/source@') then
local UserId = Text:match('(%d+)/source@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,54); 
local Text ='* 𝘴𝘯𝘢𝘱 𝖲𝗈𝗎𝗋𝖼𝖾 \n— — — — — — — — —*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'S𝘰𝘶𝘳𝘤𝘦 rose ⁦ᯓ',url="https://t.me/s36468"},{text = ' Updates source ⁦ᯓ',url="https://t.me/ahmad_sors"}
},
{
{text = '  rose ⁦ᯓ',url="https://t.me/ahmad_sors"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. ChatId .. '&photo=https://t.me/BBSBP/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/gifes@') then
local UserId = Text:match('(%d+)/gifes@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,1075); 
local Text ='*‹ : تم اختيار المتحركه لك*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '‹ : مره اخرى 🔃 .', callback_data = IdUser..'/gifes@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. ChatId .. '&animation=https://t.me/https://t.me/GifWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(%d+)/mslsl@') then
local UserId = Text:match('(%d+)/mslsl@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,54); 
local Text ='*‹ : تم اختيار المسلسل لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '❲ 𝖾𝗂𝗅𝖺??ᴅ 𝖲𝗈𝗎𝗋𝖼𝖾 ❳',url="t.me/s36468"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. ChatId .. '&photo=https://t.me/SeriesWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/memz@') then
local UserId = Text:match('(%d+)/memz@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,220); 
local Text ='*‹ : تم اختيار مقطع الميمز لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦??𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/MemzWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/kne@') then
local UserId = Text:match('(%d+)/kne@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,140); 
local Text ='*‹ : تم اختيار الاغنيه لك*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/TEAMSUL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Re@') then
local UserId = Text:match('(%d+)/Re@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,140); 
local Text ='*‹ : تم اختيار الاغنيه لك*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re@'},
},
{
{text = '❲ ??𝘯𝘢𝘱 𝖲𝗈𝗎𝗋𝖼𝖾 ❳',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/TEAMSUL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
 if Text and Text:match('(%d+)/Re1@') then
local UserId = Text:match('(%d+)/Re1@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,140); 
local Text ='*‹ : تم اختيار الشعر لك فقط*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re1@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/shaarrose/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/gife@') then
local UserId = Text:match('(%d+)/gife@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,1075); 
local Text ='*‹ : تم اختيار المتحركه لك*'
local msg_id = Msg_id/2097152/0.5
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '❲ 𝘴𝘯𝘢𝘱 𝖲𝗈??𝗋𝖼𝖾 ❳',url="t.me/s36468"}
},
}
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. ChatId .. '&animation=https://t.me/GifWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/photos@') then
local UserId = Text:match('(%d+)/photos@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(4,1201); 
local Text ='*‹ : تم اختيار الصوره لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. ChatId .. '&photo=https://t.me/PhotosWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/aneme@') then
local UserId = Text:match('(%d+)/aneme@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(3,998); 
local Text ='*‹ : تم اختيار صورة الانمي لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. ChatId .. '&photo=https://t.me/AnimeWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/trt@(.*)') then
local UserId = {Text:match('(%d+)/trt@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'ا','ايدي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'م','رفع مميز')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'اد', 'رفع ادمن')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'مد','رفع مدير')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'من', 'رفع منشئ')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'اس', 'رفع منشئ اساسي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'مط','رفع مطور')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'تك','تنزيل الكل')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'ر','الرابط')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'رر','ردود المدير')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'،،','مسح المكتومين')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'رد','اضف رد')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'سح','مسح سحكاتي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'غ','غنيلي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'رس','رسائلي')
Redis:set(Therose.."rose:Get:Reides:Commands:Group"..UserId[2]..":"..'ثانوي','رفع مطور ثانوي')
LuaTele.answerCallbackQuery(data.id, "‹ :  تم ترتيب الاوامر", true)
end
end
if Text and Text:match('(%d+)/remex@') then
local UserId = Text:match('(%d+)/remex@')
if tonumber(IdUser) == tonumber(UserId) then
Abs = math.random(2,400); 
local Text ='*‹ : تم اختيار الريمكس لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- متحركه', callback_data = IdUser..'/gife@'},{text = '- صوره', callback_data = IdUser..'/photos@'},
},
{
{text = '- انمي', callback_data = IdUser..'/aneme@'},{text = '- ريمكس', callback_data = IdUser..'/remex@'},
},
{
{text = '- فلم', callback_data = IdUser..'/filme@'},{text = '- مسلسل', callback_data = IdUser..'/mslsl@'},
},
{
{text = '- ميمز', callback_data = IdUser..'/memz@'},{text = '- غنيلي', callback_data = IdUser..'/kne@'},
},
{
{text = '🔖 ! 𝗦𝙤𝙪𝙧𝘤𝙚 rose :',url="t.me/s36468"}
},
}
local msg_id = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. ChatId .. '&voice=https://t.me/RemixWaTaN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end

if Text and Text:match('(%d+)/UnKed') then
local UserId = Text:match('(%d+)/UnKed')
if tonumber(UserId) ~= tonumber(IdUser) then
return LuaTele.answerCallbackQuery(data.id, "▽︙الامر لا يخصك", true)
end
LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.editMessageText(ChatId,Msg_id,"▽︙تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
end


if Text and Text:match('(%d+)/unbanktmkid@(%d+)') then
local listYt = {Text:match('(%d+)/unbanktmkid@(%d+)')}
if tonumber(listYt[1]) == tonumber(IdUser) then
Redis:srem(Therose.."rose:SilentGroup:Group"..ChatId,listYt[2]) 
Redis:srem(Therose.."rose:BanGroup:Group"..ChatId,listYt[2]) 
LuaTele.setChatMemberStatus(ChatId,listYt[2],'restricted',{1,1,1,1,1,1,1,1,1})
LuaTele.setChatMemberStatus(ChatId,listYt[2],'restricted',{1,1,1,1,1,1,1,1})
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم رفع القيود عنه", 'md')
end
end

if Text and Text:match('(%d+)/delamrredis') then
local listYt = Text:match('(%d+)/delamrredis')
if tonumber(listYt) == tonumber(IdUser) then
Redis:del(Therose.."rose:Redis:Id:Group"..ChatId..""..IdUser) 
Redis:del(Therose.."rose1:Set:Rd"..IdUser..":"..ChatId)
Redis:del(Therose.."rose:Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(Therose.."rose:Set:Rd"..IdUser..":"..ChatId)
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم الغاء الامر", 'md')
end
end
if Text and Text:match('(%d+)/chenid') then
local listYt = Text:match('(%d+)/chenid')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(Therose.."rose:Redis:Id:Group"..ChatId..""..IdUser,true) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : ارسل لي الايدي الان", 'md', true)
end
end
if Text and Text:match('(%d+)/chengreplygg') then
local listYt = Text:match('(%d+)/chengreplygg')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(Therose.."rose1:Set:Rd"..IdUser..":"..ChatId, "true")
LuaTele.editMessageText(ChatId,Msg_id,"‹ : ارسل لي الرد الان", 'md', true)
end
end
if Text and Text:match('(%d+)/chengreplyg') then
local listYt = Text:match('(%d+)/chengreplyg')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(Therose.."rose:Set:Manager:rd"..IdUser..":"..ChatId,"true")
LuaTele.editMessageText(ChatId,Msg_id,"‹ : ارسل لي الرد الان", 'md', true)
end
end
if Text and Text:match('(%d+)/chengreplys') then
local listYt = Text:match('(%d+)/chengreplys')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(Therose.."rose:Set:Rd"..IdUser..":"..ChatId,true)
LuaTele.editMessageText(ChatId,Msg_id,"‹ : ارسل لي الرد الان", 'md', true)
end
end

if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(Therose.."rose:Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '*‹ : الف مبروك حظك حلو اليوم\n‹ : فزت ويانه وطلعت المحيبس بل عظمه رقم {'..NumMahibes..'}*'
else
MahibesText = '*‹ : للاسف لقد خسرت المحيبس بالعظمه رقم {'..NumMahibes..'}\n‹ : جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '??'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '👊'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { '..Mahibes1..' }', data = '/*'}, {text = '𝟐 » { '..Mahibes2..' }', data = '/*'}, 
},
{
{text = '𝟑 » { '..Mahibes3..' }', data = '/*'}, {text = '𝟒 » { '..Mahibes4..' }', data = '/*'}, 
},
{
{text = '𝟓 » { '..Mahibes5..' }', data = '/*'}, {text = '𝟔 » { '..Mahibes6..' }', data = '/*'}, 
},
{
{text = '{ اللعب مره اخرى }', data = '/MahibesAgane'},
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { 👊 }', data = '/Mahibes1'}, {text = '𝟐 » { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '?? » { 👊 }', data = '/Mahibes3'}, {text = '𝟒 » { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 » { 👊 }', data = '/Mahibes5'}, {text = '𝟔 » { 👊 }', data = '/Mahibes6'}, 
},
}
}
local TextMahibesAgane = [[*
‹ :  لعبه المحيبس هي لعبة الحظ 
‹ : جرب حظك ويه البوت واتونس 
‹ : كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]]
return LuaTele.editMessageText(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/songg') then
local UserId = Text:match('(%d+)/songg')
if tonumber(IdUser) == tonumber(UserId) then
Num = math.random(9,133)
au ={
type = "audio",
media = "https://t.me/F_6AA/"..Num.."",
caption = "[Ch : 𝐒𝐍𝐀𝐏 ](t.me/s36468)\n",
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'التالي 🎀🧸', callback_data=IdUser.."/songg"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(au).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty2') then
local UserId = Text:match('(%d+)/sorty2')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[2].sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = ph,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم 2\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty3"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty1"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty3') then
local UserId = Text:match('(%d+)/sorty3') 
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(UserId)
local ph = photo.photos[3].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={
type = "photo",
media = ph,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم 3\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty4"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty2"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty1') then
local UserId = Text:match('(%d+)/sorty1')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={
type = "photo",
media = ph,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم 1\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty2"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty4') then
local UserId = Text:match('(%d+)/sorty4')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[4].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={
type = "photo",
media = ph,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم 4\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty5"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty3"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty5') then
local UserId = Text:match('(%d+)/sorty5')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[5].sizes[#photo.photos[5].sizes].photo.remote.id
local pph ={
type = "photo",
media = ph,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم 5\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك السابقه', callback_data=IdUser.."/sorty4"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر الحمايه اتبع مايلي ...
— — — — — — — — —
‹ : قفل ، فتح ← الامر 
‹ : تستطيع قفل حمايه كما يلي ...
‹ : ← { بالتقيد ، بالطرد ، بالكتم }
— — — — — — — — —
‹ : الروابط
‹ : المعرف
‹ : التاك
‹ : الشارحه
‹ : التعديل
‹ : التثبيت
‹ : المتحركه
‹ : الملفات
‹ : الصور
— — — — — — — — —
‹ : الماركداون
‹ : البوتات
‹ : التكرار
‹ : الكلايش
‹ : السيلفي
‹ : الملصقات
‹ : الفيديو
‹ : الانلاين
‹ : الدردشه
— — — — — — — — —
‹ : التوجيه
‹ : الاغاني
‹ : الصوت
‹ : الجهات
‹ : الاشعارات
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر ادمنية المجموعه ...
— — — — — — — — —
‹ : رفع، تنزيل ← مميز
‹ : تاك للكل ، عدد الكروب
‹ : كتم ، حظر ، طرد ، تقيد
‹ : الغاء كتم ، الغاء حظر ، الغاء تقيد
‹ : منع ، الغاء منع 
— — — — — — — — —
‹ : عرض القوائم كما يلي ...
— — — — — — — — —
‹ : المكتومين
‹ : المميزين 
‹ : قائمه المنع
— — — — — — — — —
‹ : تثبيت ، الغاء تثبيت
‹ : الرابط ، الاعدادات
‹ : الترحيب ، القوانين
‹ : تفعيل ، تعطيل ← الترحيب
‹ : تفعيل ، تعطيل ← الرابط
‹ : جهاتي ،ايدي ، رسائلي
‹ : سحكاتي ، مجوهراتي
‹ : كشف البوتات
— — — — — — — — —
‹ : وضع ، ضع ← الاوامر التاليه 
‹ : اسم ، رابط ، صوره
‹ : قوانين ، وصف ، ترحيب
— — — — — — — — —
‹ : حذف ، مسح ← الاوامر التاليه
‹ : قائمه المنع ، المحظورين 
‹ : المميزين ، المكتومين ، القوانين
‹ : المطرودين ، البوتات ، الصوره
‹ : الرابط
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر المدراء في المجموعه
— — — — — — — — —
‹ : رفع ، تنزيل ← ادمن
‹ : الادمنيه 
‹ : ️︙رفع، كشف ← القيود
‹ : تنزيل الكل ← { بالرد ، بالمعرف }
— — — — — — — — —
‹ : لتغيير رد الرتب في البوت
— — — — — — — — —
‹ : تغير رد ← {اسم الرتبه والنص} 
‹ : المطور ، المنشئ الاساسي
‹ : المنشئ ، المدير ، الادمن
‹ : المميز ، العضو
— — — — — — — — —
‹ : تفعيل ، تعطيل ← الاوامر التاليه ↓
— — — — — — — — —
‹ : الايدي ، الايدي بالصوره
‹ : ردود المطور ، ردود المدير
‹ : اطردني ، الالعاب ، الرفع
‹ : الحظر ، الرابط ،
— — — — — — — — —
‹ : تعين ، مسح ←{ الايدي }
‹ : رفع الادمنيه ، مسح الادمنيه
‹ : ردود المدير ، مسح ردود المدير
‹ : اضف ، حذف ← { رد }
‹ : تنظيف ← { عدد }
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- ?? -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر المنشئ الاساسي
— — — — — — — — —
‹ : رفع ، تنزيل ←{ منشئ }
‹ : المنشئين ، مسح المنشئين
— — — — — — — — —
‹ : اوامر المنشئ المجموعه
— — — — — — — — —
‹ : رفع ، تنزيل ← { مدير }
‹ : المدراء ، مسح المدراء
‹ : اضف رسائل ← { بالرد او الايدي }
‹ : اضف مجوهرات ← { بالرد او الايدي }
‹ : اضف ، حذف ← { امر }
‹ : الاوامر المضافه ، مسح الاوامر المضافه
— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ S𝘰𝘶𝘳𝘤𝘦 S??𝘢𝘱 ⁦ᯓ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر المطور الاساسي  
— — — — — — — — —
‹ : حظر عام ، الغاء العام
‹ : اضف ، حذف ← { مطور } 
‹ : قائمه العام ، مسح قائمه العام
‹ : المطورين ، مسح المطورين
— — — — — — — — —
‹ : اضف ، حذف ← { رد للكل }
‹ : وضع ، حذف ← { كليشه المطور } 
‹ : مسح ردود المطور ، ردود المطور 
‹ : تحديث ،  تحديث السورس 
‹ : تعين عدد الاعضاء ← { العدد }
— — — — — — — — —
‹ : تفعيل ، تعطيل ← { الاوامر التاليه ↓}
‹ : البوت الخدمي ، المغادرة ، الاذاعه
‹ : ملف ← { اسم الملف }
— — — — — — — — —
‹ : مسح جميع الملفات 
‹ : المتجر ، الملفات
— — — — — — — — —
‹ : اوامر المطور في البوت
— — — — — — — — —
‹ : تفعيل ، تعطيل ، الاحصائيات
‹ : رفع، تنزيل ← { منشئ اساسي }
‹ : مسح الاساسين ، المنشئين الاساسين 
‹ : غادر ، غادر ← { والايدي }
‹ : اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
‹ : اذاعه خاص ، اذاعه خاص بالتوجيه 
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help7') then
local UserId = Text:match('(%d+)/help7')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ S𝘰𝘶𝘳𝘤 rose ⁦ᯓ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : اوامر التسلية : كالتالي ↞↡
— — — — — — — — —
‹ : (غنيلي) ↡
‹ : (متحركه) ↡
‹ : (ريمكس) ↡
‹ : (انمي) ↡
‹ : (شعر) ↡
‹ : (صوره) ↡
‹ : (ميمز) ↡
— — — — — — — — —
‹ : اوامر النسب : كالتالي↞↡
— — — — — — — — —
‹ :  (نسبه الحب) ↡
‹ :  (نسبه الرجوله) ↡
‹ : (نسبه الغباء) ↡
‹ :  (نسبه الذكاء)↡
‹ : (نسبه الانوثهه) ↡
— — — — — — — — —
‹ : اوامر التحشيش : كالتالي↞↡
— — — — — — — — —
‹ : (رزله) ↡
‹ : (هينه)↡
‹ : (مصه) ↡
‹ : (بوسه) ↡
‹ : (تفله) ↡
— — — — — — — — —
‹ : الابراج : كالتالي↞↡
— — — — — — — — —
‹ : (برج العقرب)↡↞  
‹ : (برج الدلو)↞↡
‹ : (برج الحوت)↞↡
‹ : (برج العذراء)↞↡
‹ : بقيه الابراج ع نفس النمط -
‹ : احسب لحساب العمر يحسبلك عمرك شكد بالتفصيل مثال↡
‹ : احسب 1999/2/2
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'العاب السورس RX', data = IdUser..'/normgm'}, {text = 'العاب متطورة 🎳', data = IdUser..'/degm'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : أهلا بك في قائمة العاب سورس الروكس اختر نوع الالعاب 
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- فلابي بيرد', url = 'http://t.me/awesomebot?game=FlappyBird'}, 
},
{
{text = '- تبديل النجوم ', url = 'http://t.me/gamee?game=Switchy'}, {text = '- دراجات', url = 'http://t.me/gamee?game=motofx'}, 
},
{
{text = '- اطلاق النار ', url = 'http://t.me/gamee?game=NeonBlaster'}, {text = '- كره القدم', url = 'http://t.me/gamee?game=Footballstar'}, 
},
{
{text = '- تجميع الوان ', url = 'http://t.me/awesomebot?game=Hextris'}, {text = '- المجوهرات', url = 'http://t.me/gamee?game=DiamondRows'}, 
},
{
{text = '- ركل الكرة ', url = 'http://t.me/gamee?game=KeepitUP'}, {text = '- بطولة السحق', url = 'http://t.me/gamee?game=SmashRoyale'}, 
},
{
{text = '- 2048', url = 'http://t.me/awesomebot?game=g2048'}, 
},
{
{text = '- كرة السلة ', url = 'http://t.me/gamee?game=BasketBoy'}, {text = '- القط المجنون', url = 'http://t.me/gamee?game=CrazyCat'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : مرحبا بك في الالعاب المتطورة الخاص بسورس الروكس 
‹ : اختر اللعبه ثم اختار المحادثة التي تريد اللعب بها
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/normgm') then
local UserId = Text:match('(%d+)/normgm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
‹ : قائمه الالعاب البوت
— — — — — — — — —
‹ : لعبة المختلف » المختلف
‹ : لعبة الامثله » امثله
‹ : لعبة العكس » العكس
‹ : لعبة الحزوره » حزوره
‹ : لعبة المعاني » معاني
‹ : لعبة البات » بات
‹ : لعبة التخمين » خمن
‹ : لعبه الاسرع » الاسرع
‹ : لعبة السمايلات » سمايلات
— — — — — — — — —
‹ : مجوهراتي ← لعرض عدد الارباح
‹ : بيع مجوهراتي ← { العدد } ← لبيع كل مجوهره مقابل {50} رساله
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- 𝟏 -', data = IdUser..'/help1'}, {text = '- 𝟐 -', data = IdUser..'/help2'}, 
},
{
{text = '- 𝟑 -', data = IdUser..'/help3'}, {text = '- 𝟒 -', data = IdUser..'/help4'}, 
},
{
{text = '- 𝟓 -', data = IdUser..'/help5'}, {text = '- 6 -', data = IdUser..'/help7'}, 
},
{
{text = '- الالعاب -', data = IdUser..'/help6'},
},
{
{text = '- القفل و الفتح -', data = IdUser..'/NoNextSeting'}, {text = '- التعطيل و التفعيل -', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '➪ ‌𝙨𝙤𝙪𝙧𝙘𝙚 rose ⁦ᯓ ', url = 't.me/s36468'}, 
},
}
}
local TextHelp = [[*
↜ توجد -› 8 اوامر في البوت
— — — — — — — — — 
‹ : ارسل م1 -› اوامر الحمايه↡
‹ : ارسل م2 -› اوامر الادمنيه↡
‹ : ارسل م3 -› اوامر المدراء↡
‹ : ارسل م4 -› اوامر المنشئين↡
‹ : ارسل م5 -› اوامر مطورين البوت↡
‹ : ارسل م6 -› اوامر التسليه+التحشيش↡
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الدخول").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Therose.."rose:Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Therose.."rose:Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Therose.."rose:Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Therose.."rose:Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر ردود المدير").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر ردود المطور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر ردود المدير").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر ردود المطور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Therose.."rose:Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/addAdmins@(.*)') then
local UserId = {Text:match('(%d+)/addAdmins@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Therose.."rose:TheBasics:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Therose.."rose:Addictive:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "‹ : تم ترقيه {"..y.."} ادمنيه \n‹ : تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(Therose.."rose:Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Therose..'rose:'..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "‹ : تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "‹ : تم مغادره البوت من المجموعه", true)
LuaTele.leaveChat(UserId)
end


if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ❌ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✔️ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ❌ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✔️ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ❌ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✔️ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ❌ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✔️ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ❌ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✔️ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "‹ : تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ❌ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "‹ : تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✔️ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل ردود المدير', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل ردود المدير', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل ردود المطور', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود المطور', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,'‹ : اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n‹ : اعدادات المجموعه ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n🔓︙علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n‹ : اعدادات المجموعه ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n‹ : علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل النلفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملقات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملقات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الدخول", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر التثبيت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الاشعارات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الماركدون", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : عليك اختيار نوع القفل او الفتح على امر التكرار", 'md', true, false, reply_markup)
end



elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الروابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الكلايش").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الكيبورد").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الاغاني").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح المتحركات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الملفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الدردشه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الصور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح المعرفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح التاك").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح البوتات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح التوجيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الصوت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الملصقات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الجهات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الدخول").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الاضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح بصمه الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح التثبيت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الاشعارات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الماركدون").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح التعديل").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(Therose.."rose:Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"‹ : تم فتح التكرار").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Developers') then
local UserId = Text:match('(%d+)/Developers')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Developers:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح مطورين البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/DevelopersQ') then
local UserId = Text:match('(%d+)/DevelopersQ')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:DevelopersQ:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح مطورين الثانوين من البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/TheBasicsQ') then
local UserId = Text:match('(%d+)/TheBasicsQ')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:TheBasicsQ:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المالكين", 'md', false)
end
elseif Text and Text:match('(%d+)/TheBasics') then
local UserId = Text:match('(%d+)/TheBasics')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:TheBasics:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المنشئين الاساسيين", 'md', false)
end
elseif Text and Text:match('(%d+)/Originators') then
local UserId = Text:match('(%d+)/Originators')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Originators:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح منشئين المجموعه", 'md', false)
end
elseif Text and Text:match('(%d+)/Managers') then
local UserId = Text:match('(%d+)/Managers')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Managers:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المدراء", 'md', false)
end
elseif Text and Text:match('(%d+)/Addictive') then
local UserId = Text:match('(%d+)/Addictive')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Addictive:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح ادمنيه المجموعه", 'md', false)
end
elseif Text and Text:match('(%d+)/DelDistinguished') then
local UserId = Text:match('(%d+)/DelDistinguished')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:Distinguished:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المميزين", 'md', false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:BanAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المحظورين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:BanGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المحظورين", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Therose.."rose:SilentGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"‹ : تم مسح المكتومين", 'md', false)
end
end

end
end


luatele.run(CallBackLua)
 





