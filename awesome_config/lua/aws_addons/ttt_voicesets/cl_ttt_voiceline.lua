local cfg = Awesome.Config

CreateClientConVar( cfg.VLEnableComm, "1", true, false, "Включение VoiceLine." )
CreateClientConVar( cfg.URLVLEnableComm, "1", true, false, "Включение custom VoiceLine." )

Awesome.VoiceSets = Awesome.VoiceSets or {}

	local files, _ = file.Find("ttt_voicesets/*.lua", "LUA")
	table.sort(files)
	
		for _, filename in ipairs(files) do
				include("ttt_voicesets/"..filename)
		end
	
	local pDownload = Awesome.postDownload

	function UrlVoiceLine(VoiceLine) 
			
		local url = cfg.voiceLineURL..VoiceLine
		local folder = VoiceLine:sub(0,VoiceLine:find("/")-1)
		local fileFormat = cfg.FileFormatVLURL
						
		return pDownload.GetDownloadedSound(url)
		
	end
	
	
	
	
	local meta = FindMetaTable("Player")
		
	
	function meta:GetVoiceLines(line_type)
	
		local VoiceSet = self:GetNWString("VoiceSet")
		local URLVoiceSet = self:GetNWString("URLVoiceSet")
		
		local IsURL = false
		local returnVL
	
		if line_type == "" or  line_type == "default" then 
			IsURL = false
			returnVL = Awesome.VoiceSets["default"][line_type]
		
			return IsURL, returnVL
		end
	
		if cfg.URLVLEnableComm == 0 then URLVoiceSet = nil end
	
		if URLVoiceSet and URLVoiceSet!= "" then 
			IsURL = true
			returnVL = Awesome.VoiceSets[URLVoiceSet][line_type]
		elseif VoiceSet and VoiceSet!= ""  then 
			IsURL = false
			returnVL = Awesome.VoiceSets[VoiceSet][line_type]
		else
			IsURL = false
			returnVL = Awesome.VoiceSets["default"][line_type]
		end
		
		return IsURL, returnVL
	end


	function meta:PlayPainSound(health)
	    local VLEnable = tobool(GetConVar( cfg.VLEnableComm ):GetInt())
	    if !VLEnable then return end
	
		local VoiceSet
		local IsURL		
		local URLEnable = tobool(GetConVar( cfg.URLVLEnableComm ):GetInt())
	
		if health >= 70 then
			IsURL, VoiceSet = self:GetVoiceLines("PainSoundsLight")
		elseif health >= 35 then
			IsURL, VoiceSet = self:GetVoiceLines("PainSoundsMed")
		elseif health >= 10 then
			IsURL, VoiceSet = self:GetVoiceLines("PainSoundsHeavy")
		end

		if VoiceSet then
			local VoiceLine = VoiceSet[math.random(#VoiceSet)]
			if VoiceLine and !IsURL then		
				self:EmitSound(VoiceLine)		
			elseif VoiceLine and IsURL and URLEnable then
			    self:EmitSound(UrlVoiceLine(VoiceLine))
			end
		end
	end


	function meta:PlayDeathSound(soundPos)

		local VLEnable = tobool(GetConVar( cfg.VLEnableComm ):GetInt())
		if !VLEnable then 
		    sound.Play(table.Random(cfg.defaultDeathVL), soundPos, 90, 100)
			return
		end
		
		local URLEnable = tobool(GetConVar( cfg.URLVLEnableComm ):GetInt())
		local IsURL, VoiceSet = self:GetVoiceLines("DeathSounds")
	
		if VoiceSet == {} then	
	    	sound.Play(table.Random(cfg.defaultDeathVL), soundPos, 90, 100)
			return
		end
	
		if VoiceSet then
			local VoiceLine = VoiceSet[math.random(#VoiceSet)]
			if VoiceLine and !IsURL then		
				sound.Play(Sound(VoiceLine), soundPos, 90, 100)		
			elseif VoiceLine and IsURL and URLEnable then
				local vlSound = tostring(UrlVoiceLine(VoiceLine))
				sound.Play(UrlVoiceLine(VoiceLine), soundPos, 90, 100)
			end
		end
	
	end

	function meta:PlayDefibSound()

		local VLEnable = tobool(GetConVar( cfg.VLEnableComm ):GetInt())
		local URLEnable = tobool(GetConVar( cfg.URLVLEnableComm ):GetInt())
	
		if !VLEnable then return end
		
		local IsURL, VoiceSet = self:GetVoiceLines("DefibSounds")
		
		if VoiceSet then
			local VoiceLine = VoiceSet[math.random(#VoiceSet)]
			if VoiceLine and !IsURL then		
				self:EmitSound(VoiceLine)		
			elseif VoiceLine and IsURL and URLEnable then
				self:EmitSound(UrlVoiceLine(VoiceLine))
			end
		end
	end




	net.Receive("voice_pain", function(len)
		local ent = net.ReadEntity()
		local health = net.ReadUInt(4) * 25
	
		if GetConVar( cfg.VLEnableComm ):GetInt() == 0 then
			return
		end
	
		if ent:IsValid() then
			ent:PlayPainSound(health)
		end
	end)


	net.Receive("voice_death", function(len)
		local soundPos = net.ReadVector()
		local ent = net.ReadEntity()
		if ent:IsValid() then
			ent:PlayDeathSound(soundPos)
		end
	end)

	net.Receive("voice_defib", function(len)
		local ent = net.ReadEntity()
	
		if GetConVar( cfg.VLEnableComm ):GetInt() == 0 then
			return
		end
	
		if ent:IsValid() then
			ent:PlayDefibSound()
		end
	end)