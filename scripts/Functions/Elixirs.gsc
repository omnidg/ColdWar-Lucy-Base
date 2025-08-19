GiveTimedElixir(BGBid)//Works for Timed Elixirs
{
    BGBid = level._SynBGB[BGBid];
    self thread bgb::function_62f40b0d(BGBid);//Gives Timed Elixir, Doesnt work for Single Use Elixirs.
    self thread bgb::give(BGBid);//Just for elixir popup
}
GiveInstantElixir(name) //Works for Instant Elixirs
{
    BGBid = level._SynBGB[BGBid];
    self thread bgb::function_62f40b0d(BGBid);//Actually gives instant use elixir like Perkaholic etc, Doesnt work for timed Elixirs.
    self thread bgb::give(BGBid);//gives popup for the Elixir on screen, should work for all
}