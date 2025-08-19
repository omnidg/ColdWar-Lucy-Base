runMenuIndex(menu)
{
    self endon("disconnect");

    if(!isDefined(menu))
        menu = "Main";
    
    switch(menu)
    {
        case "Main":
            self addMenu(menu, level.menuName);
            if(self getVerification() > 0)
            {
                self addOpt("Personal Menu", &newMenu, "Personal Menu");
                if(self getVerification() > 1)
                {
                    self addOpt("Weapon Options", &newMenu, "Weapon Options");
                    if(self getVerification() > 2)
                    {
                        self addOpt("Zombies Options", &newMenu, "Zombies Options");
                        self addOpt("Powerups Menu", &newMenu, "Powerups");
                        self addOpt("Lobby Manipulation", &newMenu, "Lobby Manipulation");
                        if(self getVerification() > 3)
                        {
                            if(self IsHost() || self getVerification() > 3)
                                self addOpt("Host Menu", &newMenu, "Host Menu");
                                self addOpt("Player Menu", &newMenu, "Players");
                                self addOpt("All Players Options", &newMenu, "AllClient");
                        }
                    }
                }
            }
            break;
        case "AllClient":
            self addMenu(menu, "All Client Options");
                self addOpt("God Mode", &AllClientOpts, 1);
                self addOpt("Unlimited Ammo", &AllClientOpts, 2);
        break;
        case "Host Menu":
            self addMenu(menu, "Host Menu");
                self addOpt("Test Add XP", &Level55);
                self addOptIncSlider("Set XP Scale", &SetCustomXPMultiplier, 0,0,100,1);
                self addOpt("Unlock All Test", &TestOption);
                self addOptBool(self.ForcingTheHost, "Force Host", &ForceHostToggle); 
                self addOpt("3arc Tag", &SetClanTag, "3arc");
            break;
        case "Personal Menu":
            self addMenu(menu, "Personal Menu");
                self addOptBool(self.godmode, "God Mode", &Godmode);
                self addOptBool(self.UnlimitedAmmo, "Unlimited Ammo", &UnlimitedAmmo);
                self addOpt("Score Menu", &newMenu, "Score Menu");
                self addOpt("Give All Perks", &GiveAllPerksZM);
                self addOptBool(self.KillAura, "KillAura", &ToggleKillAura);
        break;
        case "Score Menu":
            self addMenu(menu, "Score Menu");
                self addOpt("Max Out Score", &EditPlayerScore, 99999,self, 1);
                self addOpt("Take All Score", &EditPlayerScore, 0, self, 2);
                self addOptIncSlider("Add to Player Score", &EditPlayerScore, 0, self.score, 99999, 1000, self, 3);
                self addOptIncSlider("Take from Player Score", &EditPlayerScore, 0, self.score, 99999, 1000, self, 4);
        break;
        case "Zombies Options":
            self addMenu(menu, "Zombies Options");
                self addOpt("Open All Doors", &OpenAllDoors);
                self addOpt("Kill All Zombies", &KillAllZombies);
                self addOptIncSlider("Edit Round: ", &EditRound, 0,0,999,1);
                self addOptBool(self.ZombiePos, "Teleport to Crosshair Loop", &StartZombiePosition);
            
        break;
        case "Weapon Options":
            self addMenu(menu, "Weapon Options");
                self addOpt("Weapon Selection", &newMenu, "Weapon Selection 1");
                self addOpt("Upgrade Weapon", &UpgradeWeapon);
                self addOpt("Pack Effects", &newMenu, "Pack Effects");
        break;
        case "Pack Effects":
            self addMenu(menu, "PAP Effects");
                self addOpt("Cryofreeze", &acquireaat, "ammomod_cryofreeze");
                self addOpt("Napalm Burst", &acquireaat, "ammomod_napalmburst");
                self addOpt("Dead Wire", &acquireaat, "ammomod_deadwire");
                self addOpt("Shatter Blast", &acquireaat, "ammomod_shatterblast");
                self addOpt("Electric Cherry", &acquireaat, "ammomod_electriccherry");
                self addOpt("Brain Rot", &acquireaat, "ammomod_brainrot");
        break;
        case "Weapon Selection 1":
            self addMenu(menu, "Weapon Selection");
                self addOpt("Normal Weapons", &newMenu, "Normal Weapons");
        break;
        case "Normal Weapons":
            self addMenu(menu, "Normal Weapons");
                self addOpt("Assault Rifles", &newMenu, "Assault Rifles 1");
        break;
        case "Assault Rifles 1":
            self addMenu(menu, "Assault Rifles");
                self addOpt("Give ar_accurate_t9", &GiveClientWeapon, "ar_accurate_t9", self);
        break;
        case "Lobby Manipulation":
            self addMenu(menu, "Lobby Manipulation");
                self addOpt("Test", &TestOption);
        break;
        case "Powerups":
            self addMenu(menu, "Powerups");
                self addOpt("Spawn Nuke", &GivePowerup, "nuke");
                self addOpt("Spawn Max Ammo", &GivePowerup, "full_ammo");
                self addOpt("Spawn Free Perk", &GivePowerup, "free_perk");
                self addOpt("Spawn Full Power", &GivePowerup, "hero_weapon_power");
                self addOpt("Spawn Bonus Points", &GivePowerup, "bonus_points_player");
                self addOpt("Spawn Insta Kill", &GivePowerup, "insta_kill");
        break;
        case "Players":
            self addMenu(menu, "Players");
                foreach(player in level.players)
                {
                    if(!isDefined(player.playerSetting["verification"]))
                        player.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
                    
                    self addOpt("[^5" + player.playerSetting["verification"] + "^6]" + player getName(), &newMenu, "Options " + player GetEntityNumber());
                }
        break;
        default:
            foundplayer = false;
            for(a=0;a<level.players.size;a++)
            {
                sepmenu = StrTok(menu, " ");
                if(int(sepmenu[(sepmenu.size - 1)]) == level.players[a] GetEntityNumber())
                {
                    foundplayer = true;
                    self MenuOptionsPlayer(menu, level.players[a]);
                }
            }
            
            if(!foundplayer)
            {
                self addMenu(menu, "404 ERROR");
                    self addOpt("Page Not Found");
            }
            break;
    }
}

MenuOptionsPlayer(menu, player)
{
    self endon("disconnect");
    
    sepmenu = StrTok(menu, " " + player GetEntityNumber());
    newmenu = "";
    for(a=0;a<sepmenu.size;a++)
    {
        newmenu += sepmenu[a];
        if(a != (sepmenu.size - 1))
            newmenu += " ";
    }
    
    switch(newmenu)
    {
        case "Options":       
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("Verification", &newMenu, "Verification " + player GetEntityNumber());
                self addOpt("Personal Mods", &newMenu, "ClientPMods " + player GetEntityNumber());
                self addOpt("Client Stat Manipulation", &newMenu, "ClientStats " + player GetEntityNumber());
                self addOpt("Trolling Options", &newMenu, "Trolling " + player GetEntityNumber());
        break;
         case "Verification":
            self addMenu(menu, "Verification");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
            break;
        case "ClientPMods":
            self addMenu(menu, "Client Modifications");
                self addOptBool(player.godmode, "God Mode", &ClientOpts, 1, player);
                self addOptBool(player.UnlimitedAmmo, "Unlimited Ammo", &ClientOpts, 2, player);
        break;
        case "ClientStats":
            self addMenu(menu, "ClientStats");
                self addOpt("Test", &TestOption);
        break;
        case "Trolling":
            self addMenu(menu, "Trolling Options");
                self addOpt("Test", &TestOption);
        break;
        default:
            self addMenu(menu, "404 ERROR");
                self addOpt("Page Not Found");
            break;
    }
}

menuMonitor()
{
    self endon("disconnect");
    
    while(true)
    {
        if(self getVerification() > 0)
        {
            if(!self isInMenu())
            {
                if(self AdsButtonPressed() && self MeleeButtonPressed() && !isDefined(self.menu["DisableMenuControls"]))
                {
                    if(isDefined(self.menu["currentMenu"]) && self.menu["currentMenu"] != "")
                        menu = self.menu["currentMenu"];
                    else
                        menu = "Main";
                    
                    self openMenu1(menu);
                    wait .25;
                }
            }
            else if(self isInMenu() && !isDefined(self.menu["DisableMenuControls"]))
            {
                if(self AdsButtonPressed() || self AttackButtonPressed())
                {
                    if(!self AdsButtonPressed() || !self AttackButtonPressed())
                    {
                        curs = self getCursor();
                        menu = self getCurrent();
                        
                        self.menu["curs"][menu] += self AttackButtonPressed();
                        self.menu["curs"][menu] -= self AdsButtonPressed();
                        
                        arry = self.menu["items"][self getCurrent()].name;
                        curs = self getCursor();

                        if(curs < 0 || curs > (arry.size - 1))
                            self setCursor((curs < 0) ? (arry.size - 1) : 0);

                        self drawText();
                        wait .13;
                    }
                }
                else if(self UseButtonPressed())
                {
                    menu = self getCurrent();
                    curs = self getCursor();
                    
                    if(isDefined(self.menu["items"][menu].func[curs]))
                    {
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], isDefined(self.menu["items"][menu].slider[curs]) ? self.menu_S[menu][curs][self.menu_SS[menu][curs]] : int(self.menu_SS[menu][curs]), self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        else
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        if(isDefined(isDefined(self.menu["items"][menu].bool[curs])))
                            self RefreshMenu();
                        wait .25;
                    }
                }
                else if(self SecondaryOffhandButtonPressed() || self FragButtonPressed())
                {
                    if(!self SecondaryOffhandButtonPressed() || !self FragButtonPressed())
                    {
                        menu = self getCurrent();
                        curs = self getCursor();
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                        {
                            inc = isDefined(self.menu["items"][menu].incslider[curs]) ? self.menu["items"][menu].intincrement[curs] : 1;
                            self.menu_SS[menu][curs] += self FragButtonPressed() ? inc : (inc * -1);
                            
                            if(isDefined(self.menu["items"][menu].slider[curs]))
                                self SetSlider(self.menu_SS[menu][curs]);
                            else
                                self SetIncSlider(self.menu_SS[menu][curs]);
                            self RefreshMenu();
                            wait .15;
                        }
                    }
                }
                else if(self MeleeButtonPressed())
                {
                    if(self getCurrent() == "Main")
                        self closeMenu1();
                    else
                        self newMenu();
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

ExecuteFunction(function, i1, i2, i3, i4, i5, i6)
{
    if(!isDefined(function))
        return;
    
    if(isDefined(i6))
        return self thread [[ function ]](i1, i2, i3, i4, i5, i6);
    if(isDefined(i5))
        return self thread [[ function ]](i1, i2, i3, i4, i5);
    if(isDefined(i4))
        return self thread [[ function ]](i1, i2, i3, i4);
    if(isDefined(i3))
        return self thread [[ function ]](i1, i2, i3);
    if(isDefined(i2))
        return self thread [[ function ]](i1, i2);
    if(isDefined(i1))
        return self thread [[ function ]](i1);
    
    return self thread [[ function ]]();
}

drawText()
{
    self endon("menuClosed");
    self endon("disconnect");
    
    if(!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;
    
    menu = self getCurrent();
    text = self.menu["items"][self getCurrent()].name;
    curs = self getCursor();
    start = 0;

    if (curs > 2 && curs < (text.size - 3) && text.size > 5)
        start = curs - 2;
    if (curs > (text.size - 4) && text.size > 5)
        start = text.size - 5;
    
    if(text.size > 0)
    {
        if(isDefined(self.menu["items"][menu].title))
            self iPrintlnBold("^4[ " + self.menu["items"][menu].title + " ]");
        self.lastRefresh = getTime();

        numOpts = text.size;
        if(numOpts >= 5)
            numOpts = 5;
        
        for(a=0;a<numOpts;a++)
        {
            text = self.menu["items"][menu].name;
            str = text[(a + start)];
            if(isDefined(self.menu["items"][menu].bool[(a + start)]))
                str += (isDefined(self.menu_B[menu][(a + start)]) && self.menu_B[menu][(a + start)]) ? " ^2[ON]" : " ^1[OFF]";
            else if(isDefined(self.menu["items"][menu].incslider[(a + start)]))
                str += "^1 < " + self.menu_SS[menu][(a + start)] + " >";
            else if(isDefined(self.menu["items"][menu].slider[(a + start)]))
                str += " < " + self.menu_S[menu][(a + start)][self.menu_SS[menu][(a + start)]] + " >";
            
            if(curs == (a + start))
                self iPrintlnBold("^2   -> " + str + " ^0<-");
            else
                self iPrintlnBold("^." + str);
        }

        if(numOpts < 5)
        {
            printSize = 5 - numOpts;
            for(a=0;a<printSize;a++)
                self iPrintlnBold(".");
        }
    }
}

RefreshMenu()
{
    if(self hasMenu() && self isInMenu())
    {
        self runMenuIndex(self getCurrent());
        self drawText();
    }
}

openMenu1(menu)
{
    if(!isDefined(menu))
        menu = "Main";
    if(!isDefined(self.menu["curs"][menu]))
        self.menu["curs"][menu] = 0;
    
    self.menu["currentMenu"] = menu;
    self runMenuIndex(menu);
    self.playerSetting["isInMenu"] = true;
    self thread MonitorMenuRefresh();
}

MonitorMenuRefresh()
{
    self endon("disconnect");
    self endon("menuClosed");

    if(self isInMenu())
    {
        self drawText();
        while(self isInMenu())
        {
            if(self.lastRefresh < GetTime() - 4000)
                self drawText();
            wait 1;
        }
    }
}

closeMenu1()
{
    self DestroyOpts();
    self notify("menuClosed");
    self.playerSetting["isInMenu"] = undefined;
}

DestroyOpts()
{
    for(a=0;a<9;a++)
        self iPrintlnBold(".");
}
