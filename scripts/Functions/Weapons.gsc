GiveClientWeapon(WeaponName, player)//needs work, as some things don't work well
{
    Weapon = getweapon(ishash(WeaponName) ? WeaponName : hash(WeaponName));
    if(!isDefined(Weapon)) return;
    if(zm_loadout::is_melee_weapon(Weapon)) slotIndex = 2;
    else slotIndex = 0;
    player zm_weapons::weapon_give(
    Weapon,      // Weapon object
    0,           // No sound override
    1,           // Auto Switch to Weapon
    slotIndex,          //slot index? 
    1,       // give as build kit weapon
    #"orange",   // Rarity level
    [],          // manual attachments
    1            // Build kit flag = 1
    );

    player switchtoweapon(Weapon); // Optional: equip immediately
    player giveMaxAmmo(Weapon);
    player switchToWeapon(Weapon);
    
}

UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();
    wait .1;
    UpgradeWeap = !(zm_weapons::is_weapon_upgraded(weapon));
    if(UpgradeWeap && !zm_weapons::can_upgrade_weapon(weapon)) return;
    newWeap = (UpgradeWeap ? zm_weapons::get_upgrade_weapon(weapon) : zm_weapons::get_base_weapon(weapon));
    self takeWeapon(weapon);
    self zm_weapons::give_build_kit_weapon(newWeap);
    self SwitchToWeapon(newWeap);
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

magicbullets()
{
    self.magicBullets = isDefined(self.magicBullets) ? undefined : true;
    if(isDefined(self.magicBullets))
    {
        self.bulletEffectType = "ray_gun";
        self PrintToLevel("Magic Bullets Enabled, Effect: Ray Gun");
        while(isDefined(self.magicBullets))
        {
            self waittill(#"weapon_fired");
            MagicBullet(getWeapon(self.bulletEffectType), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
            wait .25;
        }
    }
    else 
    {
        self PrintToLevel("Magic Bullets ^1Disabled");
        self.bulletEffectType=undefined;
    }
}

changeBulletType(val)
{
    if(isDefined(self.bulletEffectType))
    {
        switch(val)
        {
            case 0: self.bulletEffectType=  "minigun"; self PrintToLevel("Bullet Effect Set To: Minigun"); break;
            case 1: self.bulletEffectType = "special_ballisticknife_t9_dw_upgraded"; self PrintToLevel("Bullet Effect Set To: Ballistic Knife"); break;
            case 2: self.bulletEffectType = "launcher_standard_t9_upgraded"; self PrintToLevel("Bullet Effect Set To: Rocket Launcher"); break;
            case 3: self.bulletEffectType = "ray_gun"; self PrintToLevel("Bullet Effect Set To: Ray Gun"); break;
        }
    }
    else
    {
        self PrintToLevel("Custom Bullet Effects are not Enabled");
    }
}