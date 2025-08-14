/*
###########################################
Developer Modifications
Most of these are likely untested
###########################################
*/


GetXPMultiplier() 
{
    if(isDefined(level.customXPValue) && level.customXPValue >= 1){ return level.customXPValue;}
    n_multiplier = 2;
    if (zm_utility::is_standard()) 
    {
        switch (level.players.size) 
        {
        case 1:
            n_multiplier = n_multiplier * 0.55;
            break;
        case 2:
            n_multiplier = n_multiplier * 0.75;
            break;
        case 3:
            n_multiplier = n_multiplier * 0.9;
            break;
        case 4:
            n_multiplier = n_multiplier * 1.1;
            break;
        }
    } 
    else 
    {
        switch (level.players.size) 
        {
        case 1:
            n_multiplier = n_multiplier * 0.63;
            break;
        case 2:
            n_multiplier = n_multiplier * 0.75;
            break;
        case 3:
            n_multiplier = n_multiplier * 0.8;
            break;
        case 4:
            n_multiplier = n_multiplier * 0.95;
            break;
        }
    }
    return n_multiplier;
}

SetCustomXPMultiplier(value)
{
    if(value > 1)
    {
        self S("Custom XP Rate Enabled at "+value+"x"); 
        if(zm_utility::is_standard())
        {
            switch(level.players.size)
            {
                case 1: level.CustomXPValue = value * 0.55;
                        break;
                case 2: level.CustomXPValue = value * 0.75;
                        break;
                case 3: level.CustomXPValue = value * 0.9;
                        break;
                case 4: level.CustomXPValue = value * 1.1;
                        break;
            }
        }
        else 
        {
            switch (level.players.size) 
            {
                case 1:
                    level.CustomXPValue = value * 0.63;
                    break;
                case 2:
                    level.CustomXPValue = value * 0.75;
                    break;
                case 3:
                    level.CustomXPValue = value * 0.8;
                    break;
                case 4:
                    level.CustomXPValue = value * 0.95;
                    break;
            }
        }
        level.var_3426461d = &GetXPMultiplier;
        
    }
    else
    {
        level.customXPValue = undefined;
        self S("Custom XP Rate ^1Disabled");
        level.var_3426461d = &GetXPMultiplier; 
    }
}