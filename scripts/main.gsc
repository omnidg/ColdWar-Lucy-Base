init()
{
    level thread InitializeVarsPrecaches();
    level.player_out_of_playable_area_monitor = undefined;
}

onPlayerSpawned()
{
        if(!isDefined(self.menuThreaded))
            self thread playerSetup();

        if(isDefined(level.player_too_many_weapons_monitor))
        level.player_too_many_weapons_monitor = undefined;
}

InitializeVarsPrecaches()
{
    if(isDefined(level.InitializeVarsPrecaches))
        return;
    level.InitializeVarsPrecaches = true;
    level.menuName = "The Lucy Base";
    level._SynWeapons = getArrayKeys(level.zombie_weapons);
    level._SynBGB          = getArrayKeys(level.bgb);
    level.menuDeveloper = "MrFawkes1337 | CF499";
    level.AutoVerify = 0;
    level.MenuStatus = StrTok("None, Verified, VIP, Co-Host, Admin, Host, Developer", ",");
    
}
CacheGobbleGums()
{
    level._BGBNames = [];
    for(e=0;e<level._SynBGB.size;e++)
        level._BGBNames[e] = constructString(replaceChar(getSubStr(level._SynBGB[e], 7), "_", " "));
}
replaceChar(string, substring, replace)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(string[e] == substring)
            final += replace;
        else 
            final += string[e];
    }
    return final;
}

constructString(string)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(e == 0)
            final += toUpper(string[e]);
        else if(string[e-1] == " ")
            final += toUpper(string[e]);
        else 
            final += string[e];
    }
    return final;
}
playerSetup()
{
    if(isDefined(self.menuThreaded))
        return;
    
    self defineVariables();
    if(!self IsHost())
    {
        if(!isDefined(self.playerSetting["verification"]))
            self.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
    }
    else {
        self.playerSetting["verification"] = level.MenuStatus[(level.MenuStatus.size - 2)];
    }
    if(self hasMenu())
    {
        wait 20;
        self PrintToLevel(".");
        self PrintToLevel("^9Welcome To " + level.menuName);
        self PrintToLevel("^1Developed By: ^2" + level.menuDeveloper);
        self PrintToLevel("^0Verification Status: " + self.playerSetting["verification"]);
    }
    
    self thread menuMonitor();
    self.menuThreaded = true;
}
 
defineVariables()
{
    if(isDefined(self.DefinedVariables))
        return;
    self.DefinedVariables = true;
    
    if(!isDefined(self.menu))
        self.menu = [];
    if(!isDefined(self.playerSetting))
        self.playerSetting = [];
    if(!isDefined(self.menu["curs"]))
        self.menu["curs"] = [];
    
    self.playerSetting["isInMenu"] = undefined;
    self.menu["currentMenu"] = "Main";
    self.menu["curs"][self.menu["currentMenu"]] = 0;
}