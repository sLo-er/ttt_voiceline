--[[	if self.Data["Category"] == "Жихад звуки" then
		menu:AddOption("Прослушать",function()
			RunConsoleCommand("stopsound")
			timer.Simple(0.1,function()
				surface.PlaySound(self.Data.jihadsound)
			end)
		end)
	end]]--
	
	if self.Data["SubCategory"] == "Кастомные войс лайны" then
	
	    local cfg = Awesome.Config
		local fileFormat = cfg.FileFormatVLURL
		
		local vs_translation = {
			["Смерть"] = {"DeathSounds"},
			["Урон"] = {"PainSoundsLight", "PainSoundsMed",	"PainSoundsHeavy",},
			["Воскрешение"] = {"DefibSounds"}
		}
		
		for k, tr_key in ipairs(table.GetKeys( vs_translation )) do
		
		    local VoiceSet = Awesome.VoiceSets[self.Data.VoiceLineID][vs_translation[tr_key][math.random( #vs_translation[tr_key] )]]
		
			if VoiceSet != "npc/combine_soldier/vo/_comma.wav" then
				menu:AddOption(tr_key,function()
				RunConsoleCommand("stopsound")
					timer.Simple(0.1,function()
					
					
					local VoiceLine = VoiceSet[math.random(#VoiceSet)]
					
					surface.PlaySound(Awesome.postDownload.GetDownloadedSound(VoiceLine))
					end)
		    	end)
		
			end
		end
	
	end
	
	if self.Data["SubCategory"] == "Войс лайны" then
	
	    local cfg = Awesome.Config
		local fileFormat = cfg.FileFormatVLURL
		local useProxy = cfg.URLCustVLProxyComm
		
		local vs_translation = {
			["Смерть"] = {"DeathSounds"},
			["Урон"] = {"PainSoundsLight", "PainSoundsMed",	"PainSoundsHeavy",},
			["Воскрешение"] = {"DefibSounds"}
		}
		
		for k, tr_key in ipairs(table.GetKeys( vs_translation )) do
		
		    local VoiceSet = Awesome.VoiceSets[self.Data.VoiceLineID][vs_translation[tr_key][math.random( #vs_translation[tr_key] )]]
		
			if VoiceSet != "npc/combine_soldier/vo/_comma.wav" then
				menu:AddOption(tr_key,function()
				RunConsoleCommand("stopsound")
					timer.Simple(0.1,function()
					
					
					local VoiceLine = VoiceSet[math.random(#VoiceSet)]
					
					surface.PlaySound(VoiceLine)
					end)
		    	end)
		
			end
		end
	
	end
	
	
	--[[
	if !LocalPlayer():PS_HasItem(self.Data.ID) and self.Data["Category"] == "Шапки"  then
		if !primerka[self.Data.ID] then
			menu:AddOption("Примерить",function()
				LocalPlayer():PS_AddClientsideModel(self.Data.ID)
				primerka[self.Data.ID] = true
			end)
			else
			menu:AddOption("Снять с примерки",function()
				LocalPlayer():PS_RemoveClientsideModel(self.Data.ID)
				primerka[self.Data.ID] = nil
			end)
		end
	end]]--
	
	
	...
	
	--[[
	function PANEL:SetData(data)
	self.Data = data
	self.Info = data.Name
	
	if data.Model then
		local DModelPanel = vgui.Create('SpawnIcon', self)
		DModelPanel:SetModel(data.Model)
		
		
		DModelPanel:Dock(FILL)
		DModelPanel:SetTooltip(self.Data.Name.." - "..PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data))
		
		function DModelPanel:DoClick()
			self:GetParent():DoClick()
		end
		
		function DModelPanel:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end
		
		function DModelPanel:OnCursorExited()
			self:GetParent():OnCursorExited()
		end

	elseif data.Material then
	

		local DImageButton = vgui.Create('DImageButton', self)
		
		DImageButton:SetMaterial(data.Material)
		DImageButton.m_Image.FrameTime = 0
		DImageButton:SetTooltip(self.Data.Name.." - "..PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data))
		
		DImageButton:Dock(FILL)
		
		function DImageButton:DoClick()
			self:GetParent():DoClick()
		end
		
		function DImageButton:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end
		
		function DImageButton:OnCursorExited()
			self:GetParent():OnCursorExited()
		end

		function DImageButton.m_Image:Paint(w, h)
			if not self:GetParent():GetParent().Data.NoScroll and self:GetParent():GetParent().Hovered then
				self.FrameTime = self.FrameTime + 1
			end

			self:PaintAt( 0, self.FrameTime % self:GetTall() - self:GetTall() , self:GetWide(), self:GetTall() )
			self:PaintAt( 0, self.FrameTime % self:GetTall(), 					self:GetWide(), self:GetTall() )
		end]]--
		
	else
	
		local DImageButton = vgui.Create('DImageButton', self)
				
		DImageButton.m_Image.FrameTime = 0
		DImageButton:SetTooltip(self.Data.Name.." - "..PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data))
		
		DImageButton:Dock(FILL)
		
		function DImageButton:DoClick()
			self:GetParent():DoClick()
		end
		
		function DImageButton:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end
		
		function DImageButton:OnCursorExited()
			self:GetParent():OnCursorExited()
		end

		function DImageButton.m_Image:Paint(w, h)
			local mat = Awesome.postDownload.GetDownloadedImage(data.WebMaterial, "awshop/", ".png")

			if (mat) then
				DImageButton.m_Image:SetMaterial(mat)
			end
			
			if not self:GetParent():GetParent().Data.NoScroll and self:GetParent():GetParent().Hovered then
				self.FrameTime = self.FrameTime + 1
			end

			DImageButton.m_Image:PaintAt( 0, self.FrameTime % self:GetTall() - self:GetTall() , self:GetWide(), self:GetTall() )
			DImageButton.m_Image:PaintAt( 0, self.FrameTime % self:GetTall(), 					self:GetWide(), self:GetTall() )
		end
    end
	--[[
	if data.Description then
		self:SetTooltip(data.Description)
	end
end]]--