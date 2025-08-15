ReturnAIArray()
{
    return GetAITeamArray(level.zombie_team);
}

KillAllZombies()
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

EditRound(newRound)
{
    thread zm_round_logic::set_round_number(newRound);
    thread KillAllZombies();
    self PrintToLevel("^5Round Set To: "+newRound); 
}