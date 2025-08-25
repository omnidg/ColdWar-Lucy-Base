GiveClientWeapon(WeaponName, player)//needs work, as some things don't work well
{
    Weapon = getweapon(ishash(WeaponName) ? WeaponName : hash(WeaponName));
    if (isdefined(Weapon)){
        player zm_weapons::weapon_give(
        Weapon,      // Weapon object
        0,           // No sound override
        1,           // Auto Switch to Weapon
        0, 0,       // Internal flags
        #"orange",   // Rarity
        [],          // No attachments
        1            // Build kit flag = 1
    );

    player switchtoweapon(Weapon); // Optional: equip immediately
    player giveMaxAmmo(Weapon);
    player switchToWeapon(Weapon);
    }
}

UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();
    wait .1;
    self zm_weapons::give_build_kit_weapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self SwitchToWeapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self PrintToLevel("^5Your current weapon has been ^2upgraded!");
}

acquireaat(id) {// works fine
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_e1fd87b0(weapon, id);
    self PrintToLevel("^5AAT ^2Enabled "+id);
}

RemoveAat()//works fine
{
    weapon = self getCurrentWeapon();
    self thread zm_weapons::function_51897592(weapon);
    self PrintToLevel("^5AAT ^1Removed");
}