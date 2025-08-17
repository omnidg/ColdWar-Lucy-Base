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
    
    // no contract
    level.var_aa2d5655 = undefined;
    // can xp
    level.var_5164a0ca = undefined;
    // xp multi
    level.var_3426461d = &get_xp_multiplier_late; // seems to be the same for both BO4 and cold war? Hmmm
}

__init__()
{
    callback::on_start_gametype(&init);
    callback::on_spawned(&onPlayerSpawned);
    callback::add_callback(#"on_round_end", &on_round_end, undefined);
}
get_xp_multiplier_late() {
    wait 10;
    level.var_3426461d = &GetXPMultiplier;
}

on_round_end() {
    level endon(#"hash_3e765c26047c9f54", #"end_game");
    
    wait 10;

    level flag::set("rbz_exfil_allowed");//set exfil on each round
    foreach(player in level.players)
    {
        if(player.score < 5000) player.score = 5000;//lock score at 5000
    }
}