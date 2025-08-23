LookupWeaponLevels()//credit ate47 / the atian menu
{
    levels = [];
    tablename = #"gamedata/weapons/zm/zm_gunlevels.csv";
    rows = tablelookuprowcount(tablename);
    columns = tablelookupcolumncount(tablename);
    if(!isDefined(rows) || !isDefined(columns) || rows * columns == 0) return levels;

    for(row=0;row<rows;row++)
    {
        xp = tablelookupcolumnforrow(tablename, row, 1);
        name = tablelookupcolumnforrow(tablename,row,2);

        weap = getweapon(name);

        if(!isDefined(weap)) continue;

        class = util::getweaponclass(weap);
        if(!isDefined(levels[class])) levels[class] = [];

        levels[class][weap] = xp;
    }
    return levels;
}

Level55()//what the frick, treyarch
{
    self addRankXPValue(#"match_end_xp", 1457200, 3);
    //self.var_361d484b += 25160000;
    self rank::updaterank();
    wait .1;
    uploadStats(self);
    self PrintToLevel("^2In order for the rank to save, please end the game via the pause menu and not the fast end!!!");
}
