local Bloodseeker = {}
Bloodseeker.optionEnable = Menu.AddOptionBool({ "Hero Specific", "Bloodseeker" }, "Combo", false)
Bloodseeker.optionComboKey = Menu.AddKeyOption({ "Hero Specific", "Bloodseeker" }, "Combo Key", Enum.ButtonCode.BUTTON_CODE_NONE)



function Bloodseeker.OnUpdate
     if not Menu.IsEnabled( Bloodseeker.optionEnable ) then return end
	 
	 Bloodseeker.Hero = Heroes.GetLocal()
	 if not Bloodseeker.Hero or NPC.GetUnitName(Bloodseeker.Hero) ~= "npc_dota_hero_bloodseeker" then return end
	 
	 Bloodseeker.Mana = NPC.GetMana(Bloodseeker.Hero)
	 Bloodseeker.Rupture = NPC.GetAbility(Bloodseeker.Hero, "bloodseeker_rupture")
	 Bloodseeker.Eul = NPC.GetItem(Bloodseeker.Hero, "item_cyclone")
	 if not Bloodseeker.Eul then Bloodseeker.Eul = nil end
	 
	 
	 if Menu.IsKeyDown( Bloodseeker.optionComboKey ) then
	     Log.Write("1")
		 local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(Bloodseeker.Hero), Enum.TeamType.TEAM_ENEMY)
		 if enemy and not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) and Entity.GetHealth(enemy) > 0 then
		     Log.Write("2")
			 Bloodseeker.LockTarget(enemy)
			 if Bloodseeker.Target == nil then return end
			 
			 local pos = Entity.GetAbsOrigin( Bloodseeker.Target )
			 
			 if Bloodseeker.Eul and Bloodseeker.heroCanCast( Bloodseeker.Hero ) and Ability.IsCastable( Bloodseeker.Eul, Bloodseeker.Mana ) and Ability.IsReady(Bloodseeker.Eul) then
              Bloodseeker.CastTime = os.clock() + 2.5
			  end
			  
			  if NPC.HasModifier(Bloodseeker.Target, "modifier_eul_cyclone") then
				local castRupture = NPC.GetTimeToFacePosition(Bloodseeker.Hero, pos) + (Ability.GetCastPoint(Bloodseeker.Rupture) + 0.5) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				local cycloneDieTime = Modifier.GetDieTime(NPC.GetModifier(Bloodseeker.Target, "modifier_eul_cyclone"))
				
				if Ability.IsReady( Bloodseeker.Rupture ) and Ability.IsCastable( Bloodseeker.Rupture, Bloodseeker.Mana ) and cycloneDieTime - GameRules.GetGameTime() <= castRupture then
					Ability.CastPosition(Bloodseeker.Rupture, pos, true)

			    end


		 		 end
		end	 
	end		 
return Bloodseeker