ReturnAIArray()//works
{
    return GetAITeamArray(level.zombie_team);
}

KillAllZombies()//works, just may take a couple of runs while it goes through the arrays.
{
    level.zombie_total = 0;
    for(a=0;a<3;a++)
    {
        zombies = ReturnAIArray();
        for(z=0;z<zombies.size;z++)
        {
            if(isDefined(zombies[z]) && IsAlive(zombies[z]))
                zombies[z] doDamage(zombies[z].health + 99, zombies[z].origin);
        }
    }
    self PrintToLevel("^5All Zombies ^2Eliminated", true);
}

EditRound(newRound)//works fine, just need to fix killallzombies properly
{
    level zm_game_module::zombie_goto_round(newRound);
    self PrintToLevel("^5Round Set To: "+newRound); 
}

StartZombiePosition() //works fine
{
    self.ZombiePos = isDefined(self.ZombiePos) ? undefined : true;
    if (isDefined(self.ZombiePos))
    {
        self thread SetZombiePosition();
    } 
    else 
    {
        self notify("stop_zombiepos");
    }
}
SetZombiePosition()//works fine
{
    self endon("stop_zombiepos");
    self endon("game_ended");

    for (;;)
    {
        forward = anglesToForward(self.angles); // convert player angles to forward vector

        foreach (zombo in GetAITeamArray(level.zombie_team)) 
        {
            // teleport zombie 70 units in front of player
            zombo ForceTeleport(self.origin + (forward[0]*70, forward[1]*70, forward[2]*70));
        }

        wait .1;
    }
}