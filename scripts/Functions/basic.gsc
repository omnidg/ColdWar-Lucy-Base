/*
###########################################
Basic Modifications
###########################################
*/

Godmode()//works fine
{
    self.godmode = isDefined(self.godmode) ? undefined : true;
 
    if(isDefined(self.godmode))
    {
        self endon("disconnect");
        self PrintToLevel("^5God Mode ^2ON");
        while(isDefined(self.godmode)) 
        {
            self EnableInvulnerability();
            wait 0.1;
        }
    }
    else
    {
        self PrintToLevel("^5God Mode ^1OFF");
        self DisableInvulnerability();
    }
}

Level55()//need to look at this
{
    self AddRankXpValue("hash_43ad5d1b08145b1f", 25160000);
    //self.var_361d484b += 25160000;
    self rank::updaterank();
    wait .1;
    uploadStats(self);
    self PrintToLevel("^2In order for the rank to save, please end the game via the pause menu and not the fast end!!!");
}

EditPlayerScore(val, player, which)//works fine
{
    switch (which)
    {
        case 1: self zm_score::add_to_player_score(400000000);self.var_595a11bc = 9999; self.var_72d64cfd = 9999;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Maxed Out");break;
        case 2: self zm_score::minus_to_player_score(self.score); oldcommon = self.var_595a11bc; oldrare = self.var_72d64cfd; self.var_595a11bc = 0; self.var_72d64cfd = 0;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc); self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Set To ^10"); break;
        case 3: self zm_score::add_to_player_score(val); self.var_595a11bc += val; self.var_72d64cfd += val; self PrintToLevel("Score Set To: ^2"+val); break;
        case 4: self zm_score::minus_to_player_score(val); if(self.var_595a11bc >= val) self.var_595a11bc -= val; if(self.var_72d64cfd >= val)self.var_72d64cfd -= val; self PrintToLevel("Score Set To: ^2"+val); break;
    }
}

UnlimitedAmmo()//works, need to look at gadgets
{
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;
    if(isDefined(self.UnlimitedAmmo))
    {
        self PrintToLevel("^5Unlimited Ammo ^2On");   
        self endon("disconnect");

        while(isDefined(self.UnlimitedAmmo))
        {
            weapon  = self GetCurrentWeapon();
            offhand = self GetCurrentOffhand();
            if(!(!isdefined(weapon) || weapon === level.weaponNone || !isdefined(weapon.clipSize) || weapon.clipSize < 1))
            {
                self SetWeaponAmmoClip(weapon, 1337);
                self givemaxammo(weapon);
                self givemaxammo(offhand);
                self gadgetpowerset(2, 100);
                self gadgetpowerset(1, 100);
                self gadgetpowerset(0, 100);
            }
            if(isdefined(offhand) && offhand !== level.weaponNone) self givemaxammo(offhand);
            wait .05;
        }
    }
    else self PrintToLevel("^5Unlimited Ammo ^1Off");
}

GivePowerup(Powerup)//works
{
    self zm_powerups::specific_powerup_drop(Powerup, self.origin, undefined, undefined, undefined, 1);
    self PrintToLevel("^5Spawned Powerup: "+powerup);
}

GiveAllPerksZM()//works
{
	a_str_perks = getarraykeys( level._custom_perks );
	foreach(str_perk in a_str_perks)
	{
		if(!self hasperk(str_perk))
		{
			self zm_perks::wait_give_perk(str_perk);
			if(isdefined(level.perk_bought_func))
			{
				self [[level.perk_bought_func]](str_perk);
			}
		}
        wait .1;
	}
    self PrintToLevel("All Perks ^2Given");
}