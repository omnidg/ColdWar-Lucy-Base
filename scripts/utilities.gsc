getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a=(name.size - 1);a>=0;a--)
        if(name[a] == "]")
            break;
    return GetSubStr(name, (a + 1));
}

isInMenu()
{
    if(!isDefined(self.playerSetting["isInMenu"]))
        return false;
    return true;
}

GetTheMap()
{
    switch(level.script)
    {
        case "zm_silver": return "Die Maschine"; break;
        case "zm_gold": return "Firebase Z"; break;
        case "zm_platinum": return "Mauer Der Toten"; break;
        case "zm_tungsten": return "Forsaken"; break;
        case "zm_deadops3": return "Dead Ops Arcade 3"; break;
        case "outbreak_alpine": return "Alpine"; break;
        case "outbreak_ruka": return "Ruka"; break;
        case "outbreak_golova": return "Golova"; break;
        case "outbreak_sanatorium": return "Sanatorium"; break;
        case "outbreak_duga": return "Duga"; break;
        case "outbreak_zoo": return "Zoo"; break;
        case "outbreak_collateral": return "Collateral"; break;
        case "outbreak_armada": return "Armada"; break;
        case "onslaught_thepines": return "The Pines"; break;
        case "onslaught_raid": return "Raid"; break;
        case "onslaught_express": return "Express"; break;
        case "onslaught_kgb": return "KGB"; break;
        case "onslaught_icbm": return "ICBM"; break;
        case "onslaught_ubahn": return "U-Bahn"; break;
        case "onslaught_sanatorium": return "Sanatorium"; break;
        case "onslaught_mansion": return "Mansion"; break;
        default: return "Unknown Map"; break;
    }
}

GetTheMapName(mapname)
{
    switch(mapname)
    {
        case "zm_silver": return "Die Maschine"; break;
        case "zm_gold": return "Firebase Z"; break;
        case "zm_platinum": return "Mauer Der Toten"; break;
        case "zm_tungsten": return "Forsaken"; break;
        case "zm_deadops3": return "Dead Ops Arcade 3"; break;
        case "outbreak_alpine": return "Alpine"; break;
        case "outbreak_ruka": return "Ruka"; break;
        case "outbreak_golova": return "Golova"; break;
        case "outbreak_sanatorium": return "Sanatorium"; break;
        case "outbreak_duga": return "Duga"; break;
        case "outbreak_zoo": return "Zoo"; break;
        case "outbreak_collateral": return "Collateral"; break;
        case "outbreak_armada": return "Armada"; break;
        case "onslaught_thepines": return "The Pines"; break;
        case "onslaught_raid": return "Raid"; break;
        case "onslaught_express": return "Express"; break;
        case "onslaught_kgb": return "KGB"; break;
        case "onslaught_icbm": return "ICBM"; break;
        case "onslaught_ubahn": return "U-Bahn"; break;
        case "onslaught_sanatorium": return "Sanatorium"; break;
        case "onslaught_mansion": return "Mansion"; break;
        default: return "Unknown Map"; break;
    }
}
isInArray(array, text)
{
    for(a=0;a<array.size;a++)
        if(array[a] == text)
            return true;
    return false;
}

arrayRemove(array, value)
{
    if(!isDefined(array) || !isDefined(value))
        return;
    
    newArray = [];
    for(a=0;a<array.size;a++)
        if(array[a] != value)
            newArray[newArray.size] = array[a];
    return newArray;
}

getCurrent()
{
    return self.menu["currentMenu"];
}

getCursor()
{
    return self.menu["curs"][self getCurrent()];
}

setCursor(curs)
{
    self.menu["curs"][self getCurrent()] = curs;
}
SetSlider(slider)
{
    menu = self getCurrent();
    curs = self getCursor();
    max  = (self.menu_S[menu][curs].size - 1);
    
    if(slider > max)
        self.menu_SS[menu][curs] = 0;
    if(slider < 0)
        self.menu_SS[menu][curs] = max;
}

SetIncSlider(slider)
{
    menu = self getCurrent();
    curs = self getCursor();
    
    max = self.menu["items"][menu].incslidermax[curs];
    min = self.menu["items"][menu].incslidermin[curs];
    
    if(slider > max)
        self.menu_SS[menu][curs] = min;
    if(slider < min)
        self.menu_SS[menu][curs] = max;
}
BackMenu()
{
    return self.menuParent[(self.menuParent.size - 1)];
}

PlayerExitLevel()
{
    ExitLevel(false);
}

FastRestart()
{
    map_restart(false);//dont save dvars on reboot
}

PrintToLevel(message, allplayers = false)//works fine
{
    if(allplayers) { foreach (player in level.players) player iPrintLn(message);}
    else { self iPrintLn(message);}
}

spawnSM(origin, model, angles)//wpn_t9_streak_care_package_friendly_world, not sure if working
{
    ent = Spawn("script_model", origin);
    ent SetModel(model);
    if(isDefined(angles))
        ent.angles = angles;
    
    return ent;
}