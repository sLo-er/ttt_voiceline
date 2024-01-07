util.AddNetworkString( "voice_pain" )
util.AddNetworkString( "voice_death" )
util.AddNetworkString( "voice_defib" )

local files, _ = file.Find("ttt_voicesets/*.lua", "LUA")
table.sort(files)
	for _, filename in ipairs(files) do
			AddCSLuaFile("ttt_voicesets/"..filename)
	end

	local meta = FindMetaTable("Player")

	function meta:PlayPainSound()
		if CurTime() < self.NextPainSound then return end
		self.NextPainSound = CurTime() + 0.5

		local rf = RecipientFilter()
		rf:AddPAS(self:GetPos())
		net.Start("voice_pain")
		net.WriteEntity(self)
		net.WriteUInt(math.ceil(self:Health() / 25), 4)
		net.Send(rf)
	end

	function meta:PlayDeathSound()
		local rf = RecipientFilter()
		rf:AddPAS(self:GetPos())
		net.Start("voice_death")
		net.WriteVector(self:GetShootPos())
		net.WriteEntity(self)
		net.Send(rf)
	end

	function meta:PlayDefibSound()
		local rf = RecipientFilter()
		rf:AddPAS(self:GetPos())
		net.Start("voice_defib")
		net.WriteEntity(self)
		net.Send(rf)
	end

	hook.Add( "EntityTakeDamage", "PlayPainSound", function( target, dmginfo )
		if  IsValid( target ) and target:IsPlayer() and target:IsActive() and target:Health() > dmginfo:GetDamage() then
			target:PlayPainSound()
		end
	end ) 