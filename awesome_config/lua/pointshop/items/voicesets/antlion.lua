ITEM.Name = 'Aantlion'
ITEM.VoiceLineID = "antlion"
ITEM.Price = 0
ITEM.WebMaterial = "https://kikai.myarena.site/g-mod/matweb/vl_antlion.png"
ITEM.SubCategory = "Войс лайны"

function ITEM:OnEquip(ply)

	timer.Simple(1, function() 
		ply:SetNWString("VoiceSet",self.VoiceLineID)
		ply:SetNWString("URLVoiceSet","")
	end)
	
end

function ITEM:OnHolster(ply)

	timer.Simple(1, function() 
		if ply:GetNWString("VoiceSet") == self.VoiceLineID then
		ply:SetNWString("VoiceSet","default")
		ply:SetNWString("URLVoiceSet","")
		end
	end)

end