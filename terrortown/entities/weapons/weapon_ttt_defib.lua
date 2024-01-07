--[[function SWEP:HandleRespawn()
  local ply, ragdoll = self.TargetPly, self.TargetRagdoll
  local spawnPos = self:FindPosition(self.Owner)

  if not spawnPos then
    return false
  end

  local credits = CORPSE.GetCredits(ragdoll, 0)

  ply:SpawnForRound(true)
  ply:SetCredits(credits)
  ply:SetPos(spawnPos)
  ply:SetEyeAngles(Angle(0, ragdoll:GetAngles().y, 0))
  ply:SetNWBool("body_found",false)
  ply:SendLua([[ roundarert() ]])
  ragdoll:Remove()
  ]]--
  ply:PlayDefibSound()
--[[
  return true
end]]--