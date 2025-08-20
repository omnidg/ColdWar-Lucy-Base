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