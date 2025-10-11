CW_ToggleAimbot()
{
    self.aimbot = isDefined(self.aimbot) ? undefined : true;
    if (isDefined(self.aimbot))
    {
        self thread AimBot();
        self iPrintLn("Aimbot ^2Enabled");
    } 
    else 
    {
        self notify("StopAimbotting");
        self iPrintLn("Aimbot ^1Disabled");
    }
}

AimBot()
{
    self endon("disconnect");
    self endon("StopAimbotting");
    while(isDefined(self.aimbot))
    {
        ClosestZombie = Array::get_all_closest(self.origin, GetAITeamArray(level.zombie_team));
        if(self isFiring() && ClosestZombie.size > 0 && isAlive(ClosestZombie[0]) && !self IsMeleeing())
        {
            Loc = ClosestZombie[0] gettagorigin("tag_origin");

            self setplayerangles(VectorToAngles((Loc) - (self gettagorigin("tag_origin"))));
            wait .05;
            ClosestZombie[0] kill();
        }
        wait .05;
    }
}

ToggleForgeON()
{
    self.ForgeModeON = isDefined(self.ForgeModeON) ? undefined : true;
    if(isDefined(self.ForgeModeON)){
        self PrintToLevel("Forge[^2ON^7]");
        self thread MonitorForgeLoop();
    }
    else
    {
        self PrintToLevel("Forge[^1Off^7]");
        self notify("stop_forge");
    }
}

MonitorForgeLoop()
{
    self endon("death");
    self endon("stop_forge");
    for(;;)
    {
        while(self adsbuttonpressed())
        {
            trace = bulletTrace( self GetTagOrigin( "j_head" ), self GetTagOrigin( "j_head" ) + anglesToForward( self GetPlayerAngles() ) * 1000000, true, self );
            while(self adsbuttonpressed())
            {
                trace["entity"] setOrigin( self GetTagOrigin( "j_head" ) + anglesToForward( self GetPlayerAngles() ) * 200 );
                trace["entity"].origin = self GetTagOrigin( "j_head" ) + anglesToForward( self GetPlayerAngles() ) * 200;
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

BoxPrice(value)
{
    foreach(chest in level.chests) chest.zombie_cost = value;
    self PrintToLevel("^5Mystery Box is Now: ^2"+value);
}

SetBoxPrice(newPrice)
{
    foreach(chest in level.chests) chest.zombie_cost = newPrice;
    self PrintToLevel("^5Mystery Boxes in the Map are now Set to Cost: ^2"+newPrice);
}

FreezeBox()
{
    level.chests[level.chest_index].no_fly_away = (!isDefined(level.chests[level.chest_index].no_fly_away) ? true : undefined);
}

SuperJump()
{
    level.SuperJump = isDefined(level.SuperJump) ? undefined : true;
    if(isDefined(level.SuperJump))
    {
        foreach(player in level.players)
            player thread AllSuperJump();
    }
}

AllSuperJump()
{
    self endon("disconnect");
    while(isDefined(level.SuperJump))
    {
        if(self JumpButtonPressed())
        {
            for(i=0;i<5;i++)
                self SetVelocity(self GetVelocity() + (0, 0, 140));

            while(!self IsOnGround())
                wait .05;
        }
        wait .05; 
    }
}

LowGrav()
{
    level.newGrav = isDefined(level.newGrav) ? undefined : true;
    if(isDefined(level.newGrav))
        SetDvar("bg_gravity", 100);
    else
        SetDvar("bg_gravity", 350);
}