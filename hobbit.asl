//Created by FlamingLazer and Biksel
//Works on DX9 Version
state("LEGOHobbit")
{
    uint endCutscene: 0x169CA48;
    int bricks: 0x0167BB70, 0x1C, 0x168;
    int levelLoad: 0x167A828;
    int load: 0x17D8844;
    int loadOld: 0x18006E0;
    int statusScreen: 0x01792BC8, 0x10, 0x14, 0x574;
    int roomNumber: 0x1802B08;
}
startup{
    settings.Add("startGKME", true, "Start timer on loading GKME");
    settings.Add("any", true, "Any%");
    settings.Add("restrictedAny", false, "Restricted Any%");
    settings.Add("freeplay", false, "Freeplay");
}

isLoading
{
    return current.load == 0 && current.statusScreen == 0;
}

init {
  vars.count = 0;
}

onStart{
    vars.count = 0;
}
start {
    return settings["startGKME"] && ((current.roomNumber == 1 || current.roomNumber == 2) && current.bricks == 0 && old.loadOld == 1 && current.loadOld == 0);
}

update {
    if (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1){
        vars.count++;
    }
}
split {
    return (settings["restrictedAny"] || settings["any"]) && ((old.endCutscene != current.endCutscene) && current.endCutscene == 3515856204 && current.bricks != 0) ||
    (settings["restrictedAny"] || settings["any"] || settings["freeplay"]) && (old.statusScreen != current.statusScreen && old.statusScreen == 1) ||
    settings["any"] && (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1 && vars.count != 2);
}
