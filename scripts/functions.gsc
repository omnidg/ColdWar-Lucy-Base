
function get_lookat_origin( player )
{
    angles = player getplayerangles();
    forward = anglestoforward( angles );
    dir = vectorscale( forward, 8000 );
    eye = player geteye();
    trace = bullettrace( eye, eye + dir, 0, undefined );
    return trace[ #"position" ];
}

function get_spawn_list_items( MainItem )
{
    arrItems = [];
    index = 0;
    itemspawnlist = getscriptbundle( MainItem );
    if(isdefined(itemspawnlist))
    {
        foreach ( item in itemspawnlist.itemlist )
        {
            if (IsSubStr(item.itementry, "item_sr")) {
                index = arrItems.size;
                arrItems[index] = item.itementry;
            }
            if (IsSubStr(item.itementry, "_list")) {
                childspawnlist = getscriptbundle( item.itementry );
                foreach ( itemchild in childspawnlist.itemlist )
                {
                    if (IsSubStr(itemchild.itementry, "item_sr")) {
                        index = arrItems.size;
                        arrItems[index] = itemchild;
                    }
                    if (IsSubStr(itemchild.itementry, "_list")) {
                        childtwospanlist = getscriptbundle( itemchild.itementry );
                        foreach ( itemchildtwo in childtwospanlist.itemlist )
                        {
                            if (IsSubStr(itemchildtwo.itementry, "item_sr")) {
                                index = arrItems.size;
                                arrItems[index] = itemchildtwo;
                            }
                            if (IsSubStr(itemchildtwo.itementry, "_list")) {
                                childthreespawnlist = getscriptbundle( itemchildtwo.itementry );
                                foreach ( itemchildthree in childthreespawnlist.itemlist )
                                {
                                    if (IsSubStr(itemchildthree.itementry, "item_sr")) {
                                        index = arrItems.size;
                                        arrItems[index] = itemchildthree;
                                    }
                                    if (IsSubStr(itemchildthree.itementry, "_list"))
                                    {
                                        childfourspawnlist = getscriptbundle( itemchildthree.itementry );
                                        foreach ( itemchildfour in childfourspawnlist.itemlist )
                                        {
                                            if (IsSubStr(itemchildfour.itementry, "item_sr")) {  
                                                index = arrItems.size;
                                                arrItems[index] = itemchildfour;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return arrItems;
}

function get_pap_level( weapon )
{
    lvl = self item_inventory::function_230ceec4( weapon );
    
    if ( isdefined( lvl.paplv ) ) return lvl.paplv;
    else return 0;
}

function spawn_zombies(count)
{
    zombies = GetActiveZombieList();
    for(i=0;i<count;i++)
    {
        origin = get_lookat_origin(self);
        angle = self getangles() + (0, -180, 0);
        rand = randomInt(zombies.size);
        
        round_number = zm_round_logic::get_round_number();
        zombie = zombies[rand];
        if(isSubStr(zombies[rand], "heavy") || isSubStr(zombies[rand], "medium"))
        {
            if(isSubStr(zombies[rand], "heavy")){
                if(round_number < 25) zombie = zombies[randomInt(5)];
            }

            if(isSubStr(zombies[rand], "medium")){
                if(round_number >= 15 && round_number <= 25) zombie = zombie;
                else zombie = zombies[randomInt(5)];
            }
        }
        ai =  spawnactor( zombie, origin, angle );

        if ( isdefined( ai ) )
        {
            ai.var_c9b11cb3 = #"hash_5d96e8e3ed203968";
            ai.var_7a5e475 = 0;
            ai.never_hide = 1;
            ai.zombie_think_done = 1;
            ai.ignore_enemy_count = 1;
            ai.b_ignore_cleanup = undefined;
            ai.exclude_cleanup_adding_to_total = 1;
            ai.completed_emerging_into_playable_area = 1;
            ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
            ai pathmode( "move allowed" );
            ai forceteleport( origin, angle );
            self PrintToLevel("^5Zombie Spawned");
        }
        else{
            self PrintToLevel("^1Zombie Not Found!");
        }
        wait .2;
    }
}

function GetActiveZombieList()
{
    array = "";
    switch(level.script)
    {
        case "zm_silver":
            array = StrTok("spawner_zm_zombie,spawner_zm_zombie_silver,spawner_zm_zombie_silver_dp,spawner_bo5_zombie_zm_silver,spawner_bo5_zombie_zm_silver_armor_medium,spawner_bo5_zombie_zm_silver_armor_heavy", ",");
        break;
        case "zm_gold": 
            array = StrTok("spawner_bo5_zombie_zm_gold,spawner_bo5_zombie_zm_gold_soldiers,spawner_bo5_zombie_zm_gold_female,spawner_bo5_zombie_zm_gold_armor_medium,spawner_bo5_zombie_zm_gold_armor_heavy", ",");
        break;
        case "zm_platinum":
            array = StrTok("spawner_bo5_zombie_zm_platinum,spawner_bo5_zombie_zm_platinum_omega_soldier,spawner_bo5_zombie_zm_platinum_german_soldier,spawner_bo5_zombie_zm_platinum_german_soldier_pap_03,spawner_bo5_zombie_zm_platinum_german_soldier_pap_02,spawner_bo5_zombie_zm_platinum_german_soldier_pap_01,spawner_bo5_zombie_zm_platinum_female,spawner_bo5_zombie_zm_platinum_american_soldier,spawner_bo5_zombie_zm_platinum_amor_medium,spawner_bo5_zombie_zm_platinum_armor_heavy", ",");
        break;
        case "zm_tungsten":
            array = StrTok("spawner_bo5_zombie_zm_platinum,spawner_bo5_zombie_zm_tungsten,spawner_bo5_zombie_zm_tungsten_omega_soldier,spawner_bo5_zombie_zm_tungsten_german_soldier,spawner_bo5_zombie_zm_tungsten_german_soldier_pap_03,spawner_bo5_zombie_zm_tungsten_german_soldier_pap_02,spawner_bo5_zombie_zm_tungsten_armor_medium,spawner_bo5_zombie_zm_tungsten_armor_heavy", ",");
        break;
        default:
            array = StrTok("spawner_zm_zombie,spawner_zm_zombie_onslaught,spawner_zm_zombie_onslaught_xmas,spawner_zm_zombie_ndu_xmas,spawner_bo5_zombie_sr,spawner_bo5_zombie_sr_female,spawner_bo5_zombie_sr_female_alt,spawner_bo5_zombie_sr_charred,spawner_bo5_zombie_sr_american_soldier,spawner_bo5_zombie_sr_alt,spawner_bo5_zombie_sr_armor_medium,spawner_bo5_zombie_sr_armor_heavy,spawner_bo5_zombie_zm_silver_armor_heavy_xmas,spawner_bo5_zombie_sr_omega_soldier,spawner_bo5_zombie_sr_ronnie_raygun", ",");
        break;
    }

    return array;
}

function spawn_elite( ai_type, var_85422c0e )
{
    origin = get_lookat_origin(self);
    angle = self getangles() + (0, -180, 0);

    ai = spawnactor( ai_type, origin, angle );

    if ( isdefined( ai ) )
    {
        ai.var_7a5e475 = 0;
        ai.never_hide = 1;
        ai.b_ignore_cleanup = 1;
        ai.ignore_enemy_count = 1;
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai forceteleport( origin, angle );
        self PrintToLevel("^5Elite Spawned");
    }
    else{
        self PrintToLevel("^1Elite Not Found!");
    }
}