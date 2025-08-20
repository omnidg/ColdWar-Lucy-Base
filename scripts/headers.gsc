#include scripts\core_common\struct;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\zm_common\gametypes\dev.gsc;
#include scripts\zm_common\zm_score.gsc;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio.gsc;
#include scripts\zm_common\zm_powerups.gsc;
#include scripts\zm_common\zm_stats.gsc;
#include scripts\zm_common\zm_power.gsc;
#include scripts\zm_common\zm_pack_a_punch_util.gsc;
#include scripts\zm_common\zm_pack_a_punch.gsc;
#include scripts\zm_common\zm_weapons.gsc;
#include scripts\core_common\aat_shared.gsc;
#include scripts\core_common\ai\zombie_utility.gsc;
#include scripts\zm_common\zm_utility.gsc;
#include scripts\zm_common\zm_equipment.gsc;
#include scripts\zm_common\zm_perks.gsc;
#include scripts\zm_common\zm_magicbox.gsc;
#include scripts\core_common\rank_shared.gsc;
#include scripts\zm_common\zm_blockers.gsc;
#include scripts\core_common\exploder_shared.gsc;
#include scripts\core_common\challenges_shared.gsc;
#include scripts\zm_common\zm_round_logic.gsc;
#include scripts\zm_common\gametypes\globallogic_score.gsc;
#include scripts\zm_common\gametypes\globallogic.gsc;
#include scripts\core_common\contracts_shared.gsc;
#include scripts\core_common\player\player_stats;
#include scripts\zm_common\zm_loadout.gsc;
#include scripts\core_common\match_record.gsc;
#include scripts\zm_common\zm_laststand.gsc;
#include scripts\core_common\laststand_shared.gsc;
#include scripts\zm_common\zm_bgb.gsc;

#namespace synergycw;

autoexec __init__sytem__()
{
	system::register("synergycw", &__init__, undefined, undefined);
    
    //XP Multiplier
    thread get_xp_multiplier_late();
    // disable ee
#ifdef _SUPPORTS_DETOURS
    init_detours();
#endif
}
__init__()
{
    callback::on_start_gametype(&init);
    callback::on_spawned(&onPlayerSpawned);
    callback::add_callback(#"on_end_round", &on_round_end);//on_round_end gets undefined for some weird reason, lets define as something else.
}
get_xp_multiplier_late() {
    wait 10;
    level.var_3426461d = &GetXPMultiplier;
}

on_round_end() {
    level endon(#"hash_3e765c26047c9f54", #"end_game");
    
    wait 10;

    level setFlag("rbz_exfil_allowed");//set exfil on each round
}
GetXPMultiplier() 
{
    if(isDefined(level.customXPValue) && level.customXPValue >= 1){ return level.customXPValue;}
    else return 99;//reality this can be a max limit, and its weird. I've been reset to level one multiple times with it too high
}

setFlag( str_flag )
{
    if ( !isdefined( self.flag ) )
    {
        self.flag = [];
    }
    
    self.flag[ str_flag ] = 1;
    self notify( str_flag );
    
    if ( isdefined( level.var_53af20e ) )
    {
        [[ level.var_53af20e ]]( str_flag );
    }
}
