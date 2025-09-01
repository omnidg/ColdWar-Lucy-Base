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

CompleteActiveContracts(player)//works now, ive unlocked 2x double XP tokens with it.
{
    foreach(index, contract in player.pers[#"contracts"])
    {
        self PrintToLevel("Contract: "+index+", Value: "+contract.current_value);
        contractValueCurrent = contract.current_value;
        contractValueTarget = contract.target_value;
        if(isDefined(contract.target_value) && contractValueCurrent < contractValueTarget)
            contract.current_value = contract.target_value;
        wait .01;
    }
}
Level55()//still iffy, need to work on this
{
    // Amount of XP to add
    new_xp = 1476000;
    currXP = rank::getrankxp();
    // Add XP using the standard function
    self.pers["hash_43ad5d1b08145b1f"] += new_xp;
    self addRankXPValue(#"kill", new_xp, 3);
    //self stats::set_stat(#"hash_43ad5d1b08145b1f",#"rankxp",currXP + new_xp);
    uploadstats(self);
    //self zm_devgui::function_cbdab30d(new_xp);//devgui_add_xp(addXPVal);
    // Optional: print a confirmation message to the level
    self PrintToLevel("^2Rank and XP Set");
}

SetCustomPrestige(newPrestige)
{
    self SetRank(self.pers[#"rank"], newPrestige);
    self PrintToLevel("Your Prestige has been set to: "+newPrestige);
}

UnlockAllWeapons()
{
    levels = self LookupWeaponLevels();
    self PrintToLevel("Weapon Groups: "+levels.size);
    foreach(groupname,wps in levels){
        self PrintToLevel("GroupName: "+groupname+", Weapon Size: "+wps.size);
        foreach(w, lvl in wps){
            if (!isdefined(w.name)) {
                continue;
            }
            weapon = w.name;
            self PrintToLevel("Weapon: "+weapon);
            if(!isDefined(w))
            {
                 break;
            }

            curr = self getCurrentWeapon();
            if(isDefined(curr) && self hasWeapon(curr)){
                self takeWeapon(curr);
            }

            self giveWeapon(w);
            self switchToWeapon(w);

            killsneeded = 15;
            while(killsneeded){
                foreach(zombie in getaiteamarray(level.zombie_team)){
                    if(isDefined(zombie)){
                        zombie doDamage(zombie.maxHealth+999,zombie.origin,self,"none","MOD_HEADSHOT",0,w);
                        killsneeded--;
                    }
                    if(!killsneeded)
                    {
                        break;
                    }
                }
                waitframe(1);
            }

            //now we have the xp neeed, we can set stats
            for(tableid=2;tableid<3;tableid++)
            {
                tablename = #"gamedata/stats/zm/statmilestones"+tableid+".csv";//haha dummy, this shouldnt have a slash at the end
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
    levels = self LookupWeaponLevels();
    weapon_groups = array(#"weapon_assault", #"weapon_smg", #"weapon_tactical", #"weapon_lmg", #"weapon_sniper", #"weapon_pistol", #"weapon_launcher", #"weapon_cqb", #"weapon_knife", #"weapon_special");
    files = 6;
    for(tableid=1;tableid<files;tableid++)
    {
        tablename = #"gamedata/stats/zm/statmilestones"+tableid+".csv";
        rows = tablelookuprowcount(tablename);
        columns = tablelookupcolumncount(tablename);

        if (!isdefined(rows) || !isdefined(columns) || rows * columns == 0) {
            continue; // empty
        }

        for (row = 0; row < rows; row++) {
            lvl = tablelookupcolumnforrow(tablename, row, 1);
            value = tablelookupcolumnforrow(tablename, row, 2);
            group = tablelookupcolumnforrow(tablename, row, 3);
            name = tablelookupcolumnforrow(tablename, row, 4);

            self PrintToLevel(lookup_group_name(group)+"/"+name+"("+(row+1)+"/"+rows+")");

            switch(group)
            {
                case #"global":
                    self stats::function_dad108fa(name,value);
                    break;
                case #"common":
                    self stats::function_42277145(name,value);
                    break;
                case #"group":
                    foreach (grpname, wps in levels) {
                        foreach (weapon, xplvl in wps) {
                            self stats::function_e24eec31(weapon, name, value);
                            break;
                        }
                        wait 0.01;
                    }
                    break;
                default:
                    if (isdefined(levels[group])) 
                    {
                        foreach (weapon, xplvl in levels[group]) 
                        {
                            self stats::set_stat(#"hash_60e21f66eb3a1f18", weapon.name, #"xp", xplvl);
                            self stats::function_e24eec31(weapon, name, value);
                            wait 0.01;
                        }
                    }
                    break;
            }
            wait 0.1;
            uploadstats(self);
        }
    }
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