--[[function GM:PlayerSpawn(ply)
   -- stop bleeding
   util.StopBleeding(ply)

   -- Some spawns may be tilted
   ply:ResetViewRoll()

   -- Clear out stuff like whether we ordered guns or what bomb code we used
   ply:ResetRoundFlags()

   -- latejoiner, send him some info
   if GetRoundState() == ROUND_ACTIVE then
      SendRoundState(GetRoundState(), ply)
   end

   ply.spawn_nick = ply:Nick()
   ply.has_spawned = true

   -- let the client do things on spawn
   net.Start("TTT_PlayerSpawned")
      net.WriteBit(ply:IsSpec())
   net.Send(ply)

   if ply:IsSpec() then
      ply:StripAll()
      ply:Spectate(OBS_MODE_ROAMING)
      return
   end

   ply:UnSpectate()

   -- ye olde hooks
   hook.Call("PlayerLoadout", GAMEMODE, ply)
   hook.Call("PlayerSetModel", GAMEMODE, ply)
   hook.Call("TTTPlayerSetColor", GAMEMODE, ply)

   ply:SetupHands()

   SCORE:HandleSpawn(ply)
   ]]--
   ply.NextPainSound = CurTime() --VoiceSet
   
   ply:SetNWString("VoiceSet","default")
   ply:SetNWString("URLVoiceSet","")
   --[[
end]]--

...

--[[
local function PlayDeathSound(victim)
--  if not IsValid(victim) then return end

-- sound.Play(table.Random(deathsounds), victim:GetShootPos(), 90, 100) 
   ]]--
   local dVoiceSet = victim:GetNWString("VoiceSet")
   local dURLVoiceSet = victim:GetNWString("URLVoiceSet")
	
	if !dVoiceSet and !dURLVoiceSet then
		sound.Play(table.Random(deathsounds), victim:GetShootPos(), 90, 100)
		
		return
	end
	
	victim:PlayDeathSound()   
   --[[
end
]]--