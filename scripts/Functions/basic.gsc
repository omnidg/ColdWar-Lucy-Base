/*
###########################################
Basic Modifications
###########################################
*/

Godmode()
{
    self.godmode = isDefined(self.godmode) ? undefined : true;
 
    if(isDefined(self.godmode))
    {
        self endon("disconnect");
 
        while(isDefined(self.godmode)) 
        {
            self EnableInvulnerability();
            wait 0.1;
        }
    }
    else
        self DisableInvulnerability();
}

Level55()
{
    self AddRankXpValue("kill", 25160000);
    self rank::updaterank();
    wait .1;
    uploadStats();
    self PrintToLevel("^2In order for the rank to save, please end the game via the pause menu and not the fast end!!!");
}

EditPlayerScore(val, player, which)
{
    switch (which)
    {
        case 1: self zm_score::add_to_player_score(400000000);self.var_595a11bc = 9999; self.var_72d64cfd = 9999;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Maxed Out");break;
        case 2: self zm_score::minus_to_player_score(self.score); oldcommon = self.var_595a11bc; oldrare = self.var_72d64cfd; self.var_595a11bc = 0; self.var_72d64cfd = 0;self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc); self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd); self PrintToLevel("Score Set To ^10"); break;
        case 3: self zm_score::add_to_player_score(val); self.var_595a11bc += val; self.var_72d64cfd += val; self PrintToLevel("Score Set To: ^2"+val); break;
        case 4: self zm_score::minus_to_player_score(val); if(self.var_595a11bc >= val) self.var_595a11bc -= val; if(self.var_72d64cfd >= val)self.var_72d64cfd -= val; self PrintToLevel("Score Set To: ^2"+val); break;
    }
}