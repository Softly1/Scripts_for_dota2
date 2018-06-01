local legion = {}
legion.optionEnable = Menu.AddOptionBool({"Hero Specific", "Legion by Softly"}, "Enable", false)
legion.optionKey = Menu.AddKeyOption({"Hero Specific", "Legion by Softly"}, "Combo Key", Enum.ButtonCode.KEY_Z)
legion.optionEnablePressTheAttack = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Press the Attack", false)
legion.optionEnableBlademail = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Blade Mail", false)
legion.optionEnableBlink = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Blink", false)
legion.optionEnableBkb = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "BKB", false)
legion.optionEnableArmlet = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Armlet", false)
legion.optionEnableMjolnir = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Mjolnir", false)
legion.optionEnableSatanic = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Combo"}, "Satanic", false)
legion.optionEnablePoopLinken = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Poop Linken"}, "Enable", false)
legion.optionEnablePoopAbysalBlade = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Poop Linken"}, "Abyssal Blade", false)
legion.optionEnablePoopBlood = Menu.AddOptionBool({"Hero Specific", "Legion by Softly", "Poop Linken"}, "Bloodthorn", false)


LastTarget = nil
lastAttackTime2 = 0
function legion.OnUpdate()
  if not Menu.IsEnabled(legion.optionEnable) or not Engine.IsInGame() or not Heroes.GetLocal() then return end
  local myHero = Heroes.GetLocal()
  if NPC.GetUnitName(myHero) ~= "npc_dota_hero_legion_commander" then return end
  local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
  if Menu.IsKeyDown(legion.optionKey) then
    legion.Combo(myHero, enemy) end
  end
  
   function legion.Combo(myHero, enemy)
    local odds = NPC.GetAbilityByIndex(myHero, 0)
    local pressTheAttack = NPC.GetAbilityByIndex(myHero, 1)
    local duel = NPC.GetAbility(myHero, "legion_commander_duel")
    local Blademail = NPC.GetItem(myHero, "item_blade_mail", true)
    local blink = NPC.GetItem(myHero, "item_blink", true)
    local bkb = NPC.GetItem(myHero, "item_black_king_bar", true)
    local mjolnir = NPC.GetItem(myHero, "item_mjollnir", true)
    local satanic = NPC.GetItem(myHero, "item_satanic", true)
    local myMana = NPC.GetMana(myHero)
    if enemy and Entity.IsAlive(enemy) then
	
	
	
	  if legion.heroCanCastSpells(myHero, enemy) == true then
          if not NPC.IsEntityInRange(myHero, enemy, Menu.GetValue(legion.optionBlinkRange)) and Ability.IsCastable(duel, myMana) then
            if pressTheAttack and Menu.IsEnabled(legion.optionEnablePressTheAttack) and NPC.IsEntityInRange(myHero, enemy, 1199) and Ability.IsCastable(pressTheAttack, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastTarget(pressTheAttack, myHero)
              return
            end
            if Blademail and Menu.IsEnabled(legion.optionEnableBlademail) and NPC.IsEntityInRange(myHero, enemy, 1199) and Ability.IsCastable(Blademail, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastNoTarget(Blademail)
              return
            end
            if bkb and Menu.IsEnabled(legion.optionEnableBkb) and NPC.IsEntityInRange(myHero, enemy, 1199) and Ability.IsCastable(bkb, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastNoTarget(bkb)
              return
            end
            if blink and Ability.IsReady(blink) and NPC.IsEntityInRange(myHero, enemy, 1199) then
              Ability.CastPosition(blink, Entity.GetAbsOrigin(enemy))
              return
            end
            if mjolnir and Menu.IsEnabled(legion.optionEnableMjolnir) and Ability.IsCastable(mjolnir, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastTarget(mjolnir, myHero)
              return
            end
          end
          if NPC.IsEntityInRange(myHero, enemy, 150) then
            if NPC.IsLinkensProtected(enemy) then legion.PoopLinken(myHero, enemy, duel, myMana) end
            if Blademail and Menu.IsEnabled(legion.optionEnableBlademail) and Ability.IsCastable(Blademail, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastNoTarget(Blademail)
              return
            end
            if pressTheAttack and Menu.IsEnabled(legion.optionEnablePressTheAttack) and Ability.IsCastable(pressTheAttack, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastTarget(pressTheAttack, myHero)
              return
            end
            if satanic and Menu.IsEnabled(legion.optionEnableSatanic) and Ability.IsCastable(satanic, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastNoTarget(satanic)
              return
            end
            if bkb and Menu.IsEnabled(legion.optionEnableBkb) and Ability.IsCastable(bkb, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastNoTarget(bkb)
              return
            end
            if blood and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and Menu.IsEnabled(legion.optionEnableBlood) and Ability.IsCastable(blood, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastTarget(blood, enemy)
              return
            end
            if mjolnir and Menu.IsEnabled(legion.optionEnableMjolnir) and Ability.IsCastable(mjolnir, myMana) and Ability.IsCastable(duel, myMana) then
              Ability.CastTarget(mjolnir, myHero)
              return
            end
            if duel and Ability.IsCastable(duel,myMana) and NPC.IsEntityInRange(myHero, enemy, 150) then
              Ability.CastTarget(duel,enemy)
              return
            end
          end
        end
      end

	  if duel and Ability.IsReady(duel) and Ability.IsCastable(duel, myMana) and legion.heroCanCastSpells(myHero, enemy) == true and not NPC.IsEntityInRange(myHero, enemy, 150) then
        local rotationVec = Entity.GetRotation(enemy):GetForward():Normalized()
        local pos = Entity.GetAbsOrigin(enemy) + rotationVec:Scaled(100)
        	legion.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION", nil, pos)
      else
        	legion.GenericMainAttack(myHero, "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET", enemy, nil)
      end
    end
  end
  
  
  
  unction legion.PoopLinken(myHero, enemy, duel, myMana)
    if not Menu.IsEnabled(legion.optionEnablePoopLinken) then return end
    local blood = NPC.GetItem(myHero, "item_bloodthorn", true)
    local abyssal = NPC.GetItem(myHero, "item_abyssal_blade", true)
    end

    if duel and Ability.IsCastable(duel, myMana) then
      if blood and Menu.IsEnabled(legion.optionEnablePoopBlood) and Ability.IsCastable(blood, myMana) then
        Ability.CastTarget(blood, enemy)
        return
      end
      if abyssal and Menu.IsEnabled(legion.optionEnablePoopAbysalBlade) and Ability.IsCastable(abyssal, myMana) then
        Ability.CastTarget(abyssal, enemy)
        return
      end
    end
  end
  return legion
  
  