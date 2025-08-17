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