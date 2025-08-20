GiveClientWeapon(WeaponName, player)//needs work, as some things don't work well
{
    Weapon = getweapon(ishash(WeaponName) ? WeaponName : hash(WeaponName));
    if (isdefined(Weapon)) {
        self zm_weapons::weapon_give(Weapon,0, 0, 0, 0,#"orange");
        self switchtoweapon(Weapon);
        wait .1;
        player giveMaxAmmo(Weapon);
        wait .1;
        player switchToWeapon(Weapon);
        player PrintToLevel("You received "+Weapon.Name);
    }
}

UpgradeWeapon()//same as above, if weapon is packed once, it wont let you do 2x or 3x yet
{
    Weapon = self GetCurrentWeapon();
    if(self zm_weapons::can_upgrade_weapon(Weapon)){
        upgraded = self zm_weapons::get_upgrade_weapon(Weapon, zm_weapons::weapon_supports_aat(Weapon));
        self zm_weapons::weapon_give(upgraded,0, 0, 0,0,#"orange");
        self SwitchToWeapon(upgraded);
        self PrintToLevel("^2Your current weapon has been upgraded!");
    }
    else self PrintToLevel("^1Your Current Weapon is already Upgraded");
}

acquireaat(id) {// works fine
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_e1fd87b0(weapon, id);
    self PrintToLevel("You Just Got: "+id);
}

RemoveAat()//works fine
{
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_51897592(weapon);
}