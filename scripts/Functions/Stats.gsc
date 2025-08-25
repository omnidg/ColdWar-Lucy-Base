LookupWeaponLevels()//credit ate47 / the atian menu
{
    levels = [];
    tablename = #"gamedata/weapons/zm/zm_gunlevels.csv";
    rows = tablelookuprowcount(tablename);
    columns = tablelookupcolumncount(tablename);
    if(!isDefined(rows) || !isDefined(columns) || rows * columns == 0) return levels;

    for(row=0;row<rows;row++)
    {
        xp = tablelookupcolumnforrow(tablename, row, 1);
        name = tablelookupcolumnforrow(tablename,row,2);

        weap = getweapon(name);

        if(!isDefined(weap)) continue;

        class = util::getweaponclass(weap);
        if(!isDefined(levels[class])) levels[class] = [];

        levels[class][weap] = xp;
    }
    return levels;
}

lookup_group_name(str) {
    if (!ishash(str)) {
        return str;
    }
    switch (str) {
    case #"weapon_assault": return "weapon_assault";
    case #"weapon_smg": return "weapon_smg";
    case #"weapon_tactical": return "weapon_tactical";
    case #"weapon_lmg": return "weapon_lmg";
    case #"weapon_sniper": return "weapon_sniper";
    case #"weapon_pistol": return "weapon_pistol";
    case #"weapon_launcher": return "weapon_launcher";
    case #"weapon_cqb": return "weapon_cqb";
    case #"weapon_knife": return "weapon_knife";
    case #"weapon_special": return "weapon_special";
    case #"group": return "group";
    case #"common": return "common";
    case #"global": return "global";
    default: return "" + str;
    }
}
CompleteActiveContracts(player)
{
    foreach(index, contract in player.pers["contracts"])
    {
        contractValue = contract.target_value;
        if(isDefined(contractValue) && contractValue)
            contract.current_value = contractValue;
    }
}

Level55()
{
    // Amount of XP to add
    new_xp = 25160000;

    // Add XP using the standard function
    self addRankXPValue(#"match_end_xp", new_xp, 3);
    self match_record::inc_stat(#"players",self.clientid,#"rankxp" ,new_xp);
    // Also update the persistent rank XP field
    self.pers[#"rankxp"] += new_xp;

    // Force a rank recalculation
    self rank::updaterank();

    // Wait a tiny bit to let the game register the changes
    wait .1;

    // Upload stats to ensure the server saves the new XP and rank
    uploadStats(self);

    // Optional: print a confirmation message to the level
    self PrintToLevel("^2Rank and XP Set");

    wait 0.2;
    self rank::updaterank();
}

UnlockAllWeapons()
{
    levels = LookupWeaponLevels();
    self PrintToLevel("Weapon Groups: "+levels.size);
    foreach(groupname,wps in levels){
        self PrintToLevel("GroupName: "+groupname+", Weapon Size: "+wps.size);
        foreach(weap, lvl in wps){
            if(!isDefined(weap.name)){
                continue;
            }
            weapon = weap.name;
            self PrintToLevel("Weapon: "+weapon);
            if(!isDefined(weap)){ break;}
            curr = self getCurrentWeapon();
            if(isDefined(curr) && self hasWeapon(curr)){
                self takeWeapon(curr);
            }
            self giveWeapon(weap);
            self switchToWeapon(weap);
            killsneeded = 15;
            while(killsneeded){
                foreach(zombie in getaiteamarray(level.zombie_team)){
                    if(isDefined(zombie)){
                        zombie doDamage(zombie.maxHealth+999,zombie.origin,self,"none","MOD_HEADSHOT",0,weap);
                        killsneeded--;
                    }
                    if(!killsneeded) break;
                }
                wait 1;
            }
            //now we have the xp neeed, we can set stats
            for(tableid=2;tableid<3;tableid++)
            {
                tablename = #"gamedata/stats/zm/statmilestones/"+tableid+".csv";
                rows = tablelookuprowcount(tablename);
                columns = tablelookupcolumncount(tablename);

                if(!isDefined(rows) || !isDefined(columns) || rows * columns == 0) continue;//empty table

                for (row = 0; row < rows; row++) {
                    value = tablelookupcolumnforrow(tablename, row, 2);
                    group = tablelookupcolumnforrow(tablename, row, 3);
                    name = tablelookupcolumnforrow(tablename, row, 4);
                    if(group == #"group"){
                        self stats::function_e24eec31(weapon,name,value);
                        wait .01;
                    }
                }
            }
            break;
        }
        wait 1;
    }
}

UnlockAll()
{

}

GiveCrystals(player) {
    player stats::set_stat(#"hash_65febbdf3f1ab4d7", #"rare", 999);
    player stats::set_stat(#"hash_65febbdf3f1ab4d7", #"epic", 999);
    player stats::set_stat(#"hash_65febbdf3f1ab4d7", #"legendary", 999);

    player stats::set_stat(#"hash_51b649399e73640c", #"rare", 999);
    player stats::set_stat(#"hash_51b649399e73640c", #"epic", 999);
    player stats::set_stat(#"hash_51b649399e73640c", #"legendary", 999);

    player PrintToLevel("Crystals Unlocked");

}