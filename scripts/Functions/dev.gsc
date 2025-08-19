/*
###########################################
Developer Modifications
Most of these are likely untested
###########################################
*/

SetCustomXPMultiplier(value)
{
    if(value > 1)
    {
        self PrintToLevel("Custom XP Rate Enabled at "+value+"x", true);
        level.customXPValue = value;
        level.var_3426461d = level.customXPValue;
        
    }
    else
    {
        level.customXPValue = undefined;
        self PrintToLevel("^5XP Modifier ^1Disabled");
        level.var_3426461d = &GetXPMultiplier; 
    }
}

TestOption()
{
    self PrintToLevel("Test");
}

OpenAllDoors() {
    setdvar(#"zombie_unlock_all", 1);
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 1);
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::set("power_on" + trig.script_int);
            level clientfield::set("zombie_power_on", trig.script_int + 1);
        }
    }
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!is_true(zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait(1);
    setdvar(#"zombie_unlock_all", 0);
}

SetClanTag(newTag)
{
    self stats::set_stat(#"clanTagStats",#"clanName", newTag);
}

ToggleKillAura()
{
    self.killAura = isDefined(self.killAura) ? undefined: true;
    if(self.killAura)
    {
        self thread KillAura();
        self iPrintLnBold("Kill Aura ^2Enabled");
    }
    else
    {
        self notify("end_kill_aura");
        self iPrintLnBold("Kill Aura ^1Disabled");
    }
}

KillAura()//Shaolin Shuffle Glitch on BO4??
{
    self endon("end_kill_aura");
    self endon("disconnect");

    for(;;)
    {
        zombies = GetAITeamArray(level.zombie_team);
        foreach (zombie in zombies)
        {
            if(distanceSquared(zombie.origin, self.origin) < 150 * 150)
            {
                zombie dodamage(zombie.health+1,self.origin,self,undefined,"MOD_EXPLOSIVE");
                playfx( "zm_weapons/fx9_aat_bul_impact_explosive", zombie.origin+ (0,0,30) );
            }
        }
        wait .05;
    }
}