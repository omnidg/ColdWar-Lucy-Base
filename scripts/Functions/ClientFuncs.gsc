

ClientOpts(func, player)//all work
{
    switch(func)
    {
        case 1: player thread Godmode(); level.players[0] PrintToLevel("Toggle for: "+player.name);break;
        case 2: player thread UnlimitedAmmo(); level.players[0] PrintToLevel("Toggle for ^2"+player.name); break;
        case 3: self thread KickPlayer(player); level.players[0] PrintToLevel("^2"+player.name+"^5 Was Kicked"); break;
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