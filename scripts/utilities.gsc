getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a=(name.size - 1);a>=0;a--)
        if(name[a] == "]")
            break;
    return GetSubStr(name, (a + 1));
}

isInMenu()
{
    if(!isDefined(self.playerSetting["isInMenu"]))
        return false;
    return true;
}

isInArray(array, text)
{
    for(a=0;a<array.size;a++)
        if(array[a] == text)
            return true;
    return false;
}

arrayRemove(array, value)
{
    if(!isDefined(array) || !isDefined(value))
        return;
    
    newArray = [];
    for(a=0;a<array.size;a++)
        if(array[a] != value)
            newArray[newArray.size] = array[a];
    return newArray;
}

getCurrent()
{
    return self.menu["currentMenu"];
}

getCursor()
{
    return self.menu["curs"][self getCurrent()];
}

setCursor(curs)
{
    self.menu["curs"][self getCurrent()] = curs;
}

BackMenu()
{
    return self.menuParent[(self.menuParent.size - 1)];
}

PlayerExitLevel()
{
    ExitLevel(false);
}