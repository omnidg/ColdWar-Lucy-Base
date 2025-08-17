
ClientOpts(func, player)
{
    switch(func)
    {
        case 1: player thread Godmode(); level.players[0] PrintToLevel("Toggle for: "+player.name);break;
        case 2: player thread UnlimitedAmmo(); level.players[0] PrintToLevel("Toggle for ^2"+player.name); break;
    }
}

TestOption()
{
    self PrintToLevel("Test");
}
