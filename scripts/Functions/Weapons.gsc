GiveClientWeapon(WeaponName, player)
{
    self zm_weapons::give_build_kit_weapon(getweapon(WeaponName));
    self switchtoweapon(getweapon(WeaponName));
    wait .1;
    player giveMaxAmmo(getweapon(WeaponName));
    wait .1;
    player switchToWeapon(getweapon(WeaponName));
    player PrintToLevel("You received "+WeaponName);
}

UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();
    self TakeWeapon(weapon);
    wait .1;
    self zm_weapons::give_build_kit_weapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self SwitchToWeapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self PrintToLevel("^2Your current weapon has been upgraded!");
}

acquireaat(id) {// ammomod_shatterblast, ammomod_brainrot
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_e1fd87b0(weapon, id);
    self PrintToLevel("You Just Got: "+id);
}

RemoveAat()
{
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_51897592(weapon);
}