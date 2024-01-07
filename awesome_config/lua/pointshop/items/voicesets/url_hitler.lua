ITEM.Name = 'Hitler'
ITEM.VoiceLineID = "url_hitler"
ITEM.Price = 0
ITEM.WebMaterial = "https://kikai.myarena.site/g-mod/matweb/vl_hitler.png"
ITEM.SubCategory = "Кастомные войс лайны"

function ITEM:OnEquip(ply)

	timer.Simple(1, function() 
		ply:SetNWString("URLVoiceSet",self.VoiceLineID)
	end)
	
end

function ITEM:OnHolster(ply)

	timer.Simple(1, function() 
		if ply:GetNWString("URLVoiceSet") == self.VoiceLineID then
		ply:SetNWString("VoiceSet","default")
		ply:SetNWString("URLVoiceSet","")
		end
	end)

end