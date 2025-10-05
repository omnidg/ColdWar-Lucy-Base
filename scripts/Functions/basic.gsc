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
    self zm_powerups::specific_powerup_drop(Powerup, get_lookat_origin(self), undefined, undefined, undefined, 1);
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

DropItem(Item, Type)
{
    angle = self getweaponforwarddir();
    origin = get_lookat_origin(self);
    if(isdefined( self.markerobj )) origin = self.markerobj.origin;
    
    switch (Type) {
        case "spawnlist":
            itemspawnlist = getscriptbundle( Item );
            if(isdefined(itemspawnlist))
            {
                foreach ( item in itemspawnlist.itemlist )
                {
                    if (IsSubStr(item.itementry, "item_sr")) {
                        point = getscriptbundle( item.itementry );
                        DropItem(item.itementry, isdefined(point.weapon) ? "weapon" :"item"); 
                    }

                    if (IsSubStr(item.itementry, "_list")) {
                        childspawnlist = getscriptbundle( item.itementry );
                        foreach ( itemchild in childspawnlist.itemlist )
                        {
                            if (IsSubStr(itemchild.itementry, "item_sr")) {
                                point = getscriptbundle( itemchild.itementry );
                                DropItem(itemchild.itementry, isdefined(point.weapon) ? "weapon" :"item");   
                            }

                            if (IsSubStr(itemchild.itementry, "_list")) {
                                childtwospanlist = getscriptbundle( itemchild.itementry );
                                foreach ( itemchildtwo in childtwospanlist.itemlist )
                                {
                                    if (IsSubStr(itemchildtwo.itementry, "item_sr")) {
                                        point = getscriptbundle( itemchildtwo.itementry );
                                        DropItem(itemchildtwo.itementry, isdefined(point.weapon) ? "weapon" :"item");  
                                    }

                                    if (IsSubStr(itemchildtwo.itementry, "_list")) {
                                        childthreespawnlist = getscriptbundle( itemchildtwo.itementry );
                                        foreach ( itemchildthree in childthreespawnlist.itemlist )
                                        {
                                            if (IsSubStr(itemchildthree.itementry, "item_sr")) {
                                                point = getscriptbundle( itemchildthree.itementry );
                                                DropItem(itemchildthree.itementry, isdefined(point.weapon) ? "weapon" :"item");  
                                            }

                                            if (IsSubStr(itemchildthree.itementry, "_list"))
                                            {
                                                childfourspawnlist = getscriptbundle( itemchildthree.itementry );
                                                foreach ( itemchildfour in childfourspawnlist.itemlist )
                                                {
                                                    if (IsSubStr(itemchildfour.itementry, "item_sr")) {
                                                        point = getscriptbundle( itemchildfour.itementry );
                                                        DropItem(itemchildfour.itementry, isdefined(point.weapon) ? "weapon" :"item");  
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        default:        
            point = function_4ba8fde( Item );
            if (isdefined(point))
            {
                Item = StrReplace(Item, "_item_sr", "");
                Item = StrReplace(Item, "_orange", "");
                Item = StrReplace(Item, "_purple", "");
                Item = StrReplace(Item, "_blue", "");
                Item = StrReplace(Item, "_white", "");
                self item_drop::drop_item( 0, (Type == "weapon" ? getweapon(Item) : undefined), 1, 0, point.id, origin, angle, 3 );
                self PrintToLevel("Item Dropped: ^2"+ Item);
            }
            else self PrintToLevel("Item Not Found: ^1"+ Item);
        break;
    }
}

SuperDrop()
{
    //Drop all wonder weapons
    for(z=0;z<level._PlatinumWonders.size;z++)
    {
        DropItem("gold_chalice_item_sr", "item");
        DropItem(level._PlatinumWonders[z] + "_item_sr", "weapon");
    }

    //Drop some Items
    DropItem("aether_tool_item_sr", "item");
    DropItem("aether_tool_item_sr", "item");
    DropItem("aether_tool_item_sr", "item");
    DropItem("armor_item_lv3_t9_sr", "item");
    DropItem("armor_item_lv3_t9_sr", "item");
    DropItem("armor_item_lv3_t9_sr", "item");

    //Drop some Scrap
    for(z=0;z<31;z++)
    {
        DropItem("scrap_legendary_item_sr", "item");
        DropItem("scrap_epic_item_sr", "item");
        DropItem("scrap_rare_legendary_item_sr", "item");
        DropItem("scrap_item_sr", "item");
    }

}