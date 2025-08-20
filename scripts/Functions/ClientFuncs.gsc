

ClientOpts(func, player)//all work
{
    switch(func)
    {
        case 1: player thread Godmode(); level.players[0] PrintToLevel("Toggle for: "+player.name);break;
        case 2: player thread UnlimitedAmmo(); level.players[0] PrintToLevel("Toggle for ^2"+player.name); break;
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