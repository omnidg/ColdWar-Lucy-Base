init()
{
    level thread InitializeVarsPrecaches();
    level.player_out_of_playable_area_monitor = undefined;
    if(isDefined(level.player_too_many_weapons_monitor))
            level.player_too_many_weapons_monitor = undefined;
}

onPlayerSpawned()
{
    if (!level flag::get("start_zombie_round_logic"))
    {
        level flag::wait_till("start_zombie_round_logic");
    }
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
    level.menuName = "The Lucy Menu (CW)";
    level._SynWeapons = getArrayKeys(level.zombie_weapons);
    level._SynBGB          = getArrayKeys(level.bgb);
    level._SynKillstreaks = getArrayKeys(level.killstreaks);
    level.menuDeveloper = "TheUnknownCod3r";
    level.menuVersion = "v0.2.1";
    level.AutoVerify = 0;
    level.MenuStatus = StrTok("None, Verified, VIP, Co-Host, Admin, Host, Developer", ",");
    //SUBMENUS! Eventually, everything will be defined this way, to free up on mem space for errors (Specifically BO4 Crash error)
    level._WeapsCategs = StrTok("Assault Rifles,Tactical Rifles,Sniper Rifles,Submachine Guns,Shotguns,Light Machine Guns,Melee,Pistols", ",");
    level._WeapsCategsUpg = StrTok("Upgraded Assault Rifles,Upgraded Tactical Rifles,Upgraded Sniper Rifles,Upgraded Submachine Guns,Upgraded Shotguns,Upgraded Light Machine Guns,Upgraded Pistols", ",");
    level._assaultweaps = StrTok("ar_accurate_t9,ar_standard_t9,ar_damage_t9,ar_mobility_t9,ar_fastfire_t9,ar_fasthandling_t9,ar_slowhandling_t9,ar_slowfire_t9,ar_british_t9,ar_season6_t9,ar_soviet_t9", ",");
    level._AssaultNames = StrTok("Krig C,XM4,AK-47,QBZ-83,FFAR,Groza,Fara 83,C58,EM2,Grav,Vargo 52",",");
    level._tacticalweaps = StrTok("tr_longburst_t9,tr_damagesemi_t9,tr_precisionsemi_t9,tr_powerburst_t9,tr_fastburst_t9", ",");
    level._TacticalNames = StrTok("M16,Type 63,DMR 14,Aug,Carv.2", ",");
    level._sniperweaps = StrTok("sniper_quickscope_t9,sniper_standard_t9,sniper_powersemi_t9,sniper_cannon_t9,sniper_accurate_t9", ",");
    level._SniperNames = StrTok("Pelington 703,LW3-Tundra,M82,ZRG 20MM,Swiss K31", ",");
    level._smgweaps = StrTok("smg_standard_t9,smg_heavy_t9,smg_burst_t9,smg_handling_t9,smg_capacity_t9,smg_accurate_t9,smg_fastfire_t9,smg_spray_t9,smg_cqb_t9,smg_semiauto_t9,smg_flechette_t9,smg_season6_t9", ",");
    level._SmgNames = StrTok("MP5,AK-74u,KSP 45,Milano 821,Bullfrog,LC10,MAC-10,PPSH41,OTS 9,TEC-9,UGR,LAPA", ",");
    level._shotgunweaps = StrTok("shotgun_pump_t9,shotgun_semiauto_t9,shotgun_fullauto_t9,shotgun_leveraction_t9", ",");
    level._ShotgunNames = StrTok("Hauer 77,Gallo SA12,Streetsweeper,410 Ironhide",",");
    level._lmgweaps = StrTok("lmg_light_t9,lmg_accurate_t9,lmg_slowfire_t9,lmg_fastfire_t9", ",");
    level._LmgNames = StrTok("RPD,Stoner 63,M60,MG 82",",");
    level._meleeweaps = StrTok("knife,knife_loadout,melee_sledgehammer_t9,melee_wakizashi_t9,melee_etool_t9,melee_machete_t9,melee_baseballbat_t9,melee_sai_t9_dw,melee_coldwar_t9_dw,melee_battleaxe_t9,melee_cane_t9,melee_mace_t9,melee_scythe_t9", ",");
    level._MeleeNames = StrTok("Knife,Loadout Knife,Sledgehammer,Wakizashi,Shovel,Machete,Baseball Bat,Sai DW,Hammer and Sickle,Battleaxe,Cane,Mace,Scythe", ",");
    level._pistolweaps = StrTok("pistol_semiauto_t9,pistol_burst_t9,pistol_revolver_t9,pistol_fullauto_t9,pistol_shotgun_t9,pistol_semiauto_t9_dw,pistol_revolver_t9_dw,pistol_burst_t9_dw,pistol_fullauto_t9_dw,pistol_shotgun_t9_dw", ",");
    level._PistolNames = StrTok("1911,Diamatti,Magnum,AMP63,Marshal,1911 DW,Magnum DW,Diamatti DW,AMP DW,Marshal DW", ",");
    level._SkinNames = StrTok("Invisible,Adler,Portnova,Garcia,Baker,Sims,Hunter,Vargas,Stone,Song,Powers,Baker (2),Zeyna,Wolf,Beck,Knight,Antonov,Park,Stitch,Bulldozer,CDL,CDL (2),Woods,Rivas,Naga,Maxis,John Doe (BO4),Jane Doe (BO4),Nude (M),Nude (F),Wraith,Baker (3),Park (2),Price,John McClane,Rambo,Weaver,Jackal,Salah,Kitsune,Stryker,Arthur Kingsley,Hudson,Mason,Scream,Fuze,Zombies (F),Zombies (M),Lazar",",");
    level._tungstenAudio = StrTok("round_start_first,round_start,round_end,round_start_special,game_over,ee_song,flood_spawning",",");
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
        wait 5;
        self PrintToLevel(".");
        self PrintToLevel("^9Welcome To " + level.menuName);
        self PrintToLevel("^1Developed By: ^2" + level.menuDeveloper+", "+level.menuVersion);
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