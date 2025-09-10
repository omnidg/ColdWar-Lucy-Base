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
Level55(player)//still iffy, need to work on this
{
    // Amount of XP to add
    new_xp = 1476000;
    currXP = rank::getrankxp();
    // Add XP using the standard function
    player.pers["hash_43ad5d1b08145b1f"] += new_xp;
    player addRankXPValue(#"kill", new_xp, 3);
    //self stats::set_stat(#"hash_43ad5d1b08145b1f",#"rankxp",currXP + new_xp);
    player rank::updaterank();
    wait .1;
    uploadstats(player);
    //self zm_devgui::function_cbdab30d(new_xp);//devgui_add_xp(addXPVal);
    // Optional: print a confirmation message to the level
    player PrintToLevel("^2Rank and XP Set");
}

SetCustomPrestige(newPrestige)
{
    self stats::set_stat(#"playerstatslist","plevel","StatValue", newPrestige);
    self rank::updaterank();
    uploadstats(self);
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
    self PrintToLevel("^5Unlock All ^2Starting");
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
                    self PrintToLevel(group+", Name: "+name+", Value: "+value);
                    self stats::function_dad108fa(name,value);
                    break;
                case #"common":
                    self PrintToLevel(group+", Name: "+name+", Value: "+value);
                    self stats::function_42277145(name,value);
                    break;
                case #"group":
                    foreach (grpname, wps in levels) {
                        foreach (weapon, xplvl in wps) {
                            self PrintToLevel("Weapon: "+weapon+", Name: "+name+", Value: "+value);
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
    self PrintToLevel("^5Unlock All ^2Completed");
}

GiveCrystals(player)
{
    if (!isdefined(player))
    {
        return;
    }
    
    // Config
    maxValue   = 1000;
    stepAmount = 100;

    // Build rarity stat list
    statList = array(
    array(#"hash_65febbdf3f1ab4d7", "Rare"),
    array(#"hash_65febbdf3f1ab4d7", "Epic"),
    array(#"hash_65febbdf3f1ab4d7", "Legendary"),
    array(#"hash_51b649399e73640c", "Rare"),
    array(#"hash_51b649399e73640c", "Epic"),
    array(#"hash_51b649399e73640c", "Legendary")
    );
    
    foreach (statEntry in statList)
    {
        statName  = statEntry[0]; // stat hash reference
        rarityKey = statEntry[1]; // "Rare" / "Epic" / "Legendary"

        // Human-readable rarity
        if (rarityKey == #"Rare")            rarityText = "Rare";
        else if (rarityKey == #"Epic")       rarityText = "Epic";
        else if (rarityKey == #"Legendary")  rarityText = "Legendary";
        else                                 rarityText = "Unknown";

        // Progress loop
        currentValue = 0;
        while (currentValue < maxValue)
        {
            currentValue += stepAmount;
            if (currentValue > maxValue)
                currentValue = maxValue;
            
            // Apply stat increment
            player stats::set_stat(statName, rarityKey, currentValue);

            // Print progress to first player
            player iPrintLn("^5Crystals (" + rarityText + "^5): ^2" + currentValue + " / " + maxValue);

            wait 1;
        }

        wait 2;
    }

    // Final message
    self iPrintLn("^2Crystals unlocked for ^5" + player.name);
}

//stats::function_e24eec31(getweapon(weapon),stat.name,stat.value);

grab_stats_from_table(player)
{
    player endon("disconnect");
    player.isUnlockingAll = true;
    player PrintToLevel("^5Unlock All ^2Started");

}

get_weapon_max_xp(weapon) {
    prefix = "zm";


    tablename = #"gamedata/weapons/" + prefix + "/" + prefix + "_gunlevels.csv";

    rows = tablelookuprowcount(tablename);
    columns = tablelookupcolumncount(tablename);

    if (!isdefined(rows) || !isdefined(columns) || rows * columns == 0) {
        return 0;
    }

    max = 0;

    for (row = 0; row < rows; row++) {
        xp = tablelookupcolumnforrow(tablename, row, 1);
        name = tablelookupcolumnforrow(tablename, row, 2);

        if (name !== weapon || !isint(xp)) {
            continue;
        }

        if (xp > max) {
            max = xp;
        }
    }
    return max;
}

UnlockAchievs(player)
{
    Achievs = Array(#"hash_8d1920cf39e4c14",#"hash_b97db915a42a356",#"hash_be13d1076856219",#"hash_1215c0ed5cbc40b2",#"hash_12bde4bff49c66ca",#"hash_1734e93ba3a2bcc5",#"hash_20e72f8d6f572262",#"hash_21ba7b916636a235",#"hash_26c877bc3e2d96e7",#"hash_2cd993420c84660c",#"hash_2e8492b0fa87ecf6",#"hash_2f586e4c7661915f",#"hash_351cedf964a5cf11",#"hash_53a13cdbd8cdf8d7",#"hash_54fff7449654db1a",#"hash_59fd1356bba820b2",#"hash_6436e34c054bc185",#"hash_6564dfd45c6715ce",#"hash_6d9871f78dd8004a",#"hash_6e3165439b9bf116",#"hash_779bbce9266d0ae6",#"hash_77ead6a0a6cb5248",#"hash_7b24bebf11150d62",#"hash_7cfe4a58cd11b4f5",#"hash_7f83a4601ad1744d",#"hash_c33cd90f4b67bfe",#"hash_16b2ec90fb2e0c3b",#"hash_309368ef8f9b86a3",#"hash_47d5fff4205db171",#"hash_53c6bfe9f5d68f47",#"hash_5faa668391e3d463",#"hash_5fb48c8391ec697a",#"hash_6567a09c3046170f",#"hash_69455e37009492aa",#"hash_ed510979375c908",#"hash_284d0b2a070bfb79",#"hash_3f780d94296c68c6",#"hash_4ab5f04a4e88fd55",#"hash_5f4e85a66456e98b",#"hash_134e3e238f070bf6",#"hash_2670a9f559576876",#"hash_4fd5239967bfd36e",#"hash_79b5e565395ad617",#"hash_7fc3515d8479dc7a",#"hash_3c8fbebec2f463f5",#"hash_6703984223a2809c",#"hash_2deb5f76757c411d");

    foreach (chievo in Achievs)
    {
        player thread zm_utility::give_achievement(chievo);
        wait .1;
    }
    player PrintToLevel("^5All Achievements ^2Unlocked");
}