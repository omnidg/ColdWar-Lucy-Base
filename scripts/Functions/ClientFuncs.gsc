

ClientOpts(func, player)//all work
{
    switch(func)
    {
        case 1: player thread Godmode(); level.players[0] PrintToLevel("^5God Mode Toggle for: "+player.name);break;
        case 2: player thread UnlimitedAmmo(); level.players[0] PrintToLevel("^5 Unlimited Ammo Toggle for ^2"+player.name); break;
        case 3: self thread KickPlayer(player); level.players[0] PrintToLevel("^5"+player.name+"^2 Was Kicked"); break;
        case 4: self thread UnlockDarkAether(player); level.players[0] PrintToLevel("^5"+player.name+"^2 Now has Dark Aether");break;
        case 5: self thread UnlockAchievs(player); level.players[0] PrintToLevel("^5"+player.name+"^2 Now has All Achievements"); break;
        case 6: self thread GiveCrystals(player); level.players[0] PrintToLevel("^5"+player.name+" Is now ^2Receiving Crystals!"); break;
    }
}

AllClientOpts(func)//all work
{
    foreach(player in level.players)
    {
        if(player isHost()) continue;//lets just skip the host, so we don't mess with them
        else
        switch(func)
        {
            case 1: player thread Godmode(); break;
            case 2: player thread UnlimitedAmmo(); break;
            case 3: self thread KickPlayer(player); break;
            case 4: self thread UnlockDarkAether(player); break;
            case 5: self thread UnlockAchievs(player); break;
            case 6: self thread GiveCrystals(player); break;
        }
    }
}

KickPlayer(player)
{
    if(self isHost())
    {
        kick(player getEntityNumber());
        self PrintToLevel(player.name+" Was Kicked!");
    }
    else 
    {
        self PrintToLevel("You cannot Kick a Player Unless You are Host!");
    }
}