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

EditPlayerScore(val, player, which)//works fine
{
    switch (which)
    {
        case 1: self zm_score::add_to_player_score(400000000);self.var_595a11bc = 9999; self.var_72d64cfd = 9999;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("^5Score Maxed Out");break;
        case 2: self zm_score::minus_to_player_score(self.score); oldcommon = self.var_595a11bc; oldrare = self.var_72d64cfd; self.var_595a11bc = 0; self.var_72d64cfd = 0;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc); self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Set To ^10"); break;
        case 3: self zm_score::add_to_player_score(val); self.var_595a11bc += val; self.var_72d64cfd += val; self PrintToLevel("^5Added ^2"+val+" ^5To Score"); break;
        case 4: self zm_score::minus_to_player_score(val); if(self.var_595a11bc >= val) self.var_595a11bc -= val; if(self.var_72d64cfd >= val)self.var_72d64cfd -= val; self PrintToLevel("^5Taken ^2"+val+" ^5from Score"); break;
    }
}

UnlimitedAmmo()
{
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;
    if(isDefined(self.UnlimitedAmmo))
    {
        self PrintToLevel("^5Unlimited Ammo ^2On");   
        self endon("disconnect");

        while(isDefined(self.UnlimitedAmmo))
        {
            weapons = self getweaponslist();
            foreach(weapon in weapons)
            {
                if(weapon.isgadget){
                    slot = self gadgetgetslot(weapon);
                    if(self gadgetpowerget(slot) < 100 && !self getcurrentweapon().isgadget || self gadgetpowerget(slot) < 10){
                        self gadgetpowerset(slot,100);
                    }
                }
                else{
                    self givemaxammo(weapon);
                    self setweaponammoclip(weapon,weapon.clipsize);
                }
            }
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

DropItem(Item, AddedAbbrv, Type)
{
    switch (Type) {
        case "weapon":
            point = function_4ba8fde( Item + AddedAbbrv); 
            if (isdefined(point)) self item_drop::drop_item( 0, getweapon(Item), 1, 0, point.id, self.origin, self.angles, 3 );
            break;
        case "spawnlist":
            itemspawnlist = getscriptbundle( Item );
            foreach ( item in itemspawnlist.itemlist )
            {
                point = getscriptbundle( item.itementry );
                if ( isdefined( point.weapon ) )
                {
                    DropItem(item.itementry, "_orange_item_sr", "weapon");
                }
                else{
                    DropItem(item.itementry, "", "item");
                }
            }
        default:
            point = function_4ba8fde( Item ); 
            if (isdefined(point)) self item_drop::drop_item( 0, undefined, 1, 0, point.id, self.origin, self.angles, 3 );
        break;
    }
}