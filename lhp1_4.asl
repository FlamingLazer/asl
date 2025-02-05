//For more information, find a readme file on speedrun.com/mlg/resources
//Load Removal and Splitting by Heki and WiiSuper, No Save Splitting by FlamingLazer and Room Splitting by Tfresh
state("LEGOHarryPotter")
{
    bool Loading: 0xA28510;
    bool Head: 0x00B1BA54, 0x18, 0x8, 0x80, 0x100, 0x770;
    bool NewGame: 0x76C6800; //Not Working
    int goldBrickCount: 0x00CBACF8, 0x32C, 0x1A82;
}

startup {
    settings.Add("split_save", true, "Split on saving (Standard/N0CUT5 With Saves/NG+)");
    settings.Add("split_nosave", false, "Split on status screen and lesson completion (N0CUT5 Without Saves)");
    settings.Add("split_room", false, "Split on room transitions");
    //settings.Add("start_newgame", false, "Start on New Game");
}

isLoading
{
    return current.Loading;
}

start
{
//return settings["start_newgame"] && current.NewGame && !old.NewGame;
}

split
{
    return (settings["split_save"] && current.Head && !old.Head) ||
    (settings["split_nosave"] && old.goldBrickCount != current.goldBrickCount && current.goldBrickCount != 0) ||
    (settings["split_room"] && current.Loading && !old.Loading);
}

exit 
{
timer.IsGameTimePaused = false;
}

//1-4 16822272