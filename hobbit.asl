//Created by FlamingLazer, Biksel and Siedemnastek
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
    string80 roomName: 0x017926A4, 0xC4, 0x0;
    int cutscene: 0x16D14D8;
}
startup{
    settings.Add("startGKME", true, "Start timer on loading GKME");
    settings.Add("any", true, "Any%");
    settings.Add("restrictedAny", false, "Restricted Any%");
    settings.Add("freeplay", false, "Freeplay");

    vars.endScreens = new List<uint> {3515856204,3516911497,3517025118,3517479369,3518080411,3518534662,3518648283};
}

isLoading
{
    return current.load == 0 && current.statusScreen == 0;
}

init {
  vars.count = 0;
  vars.count2 = 0;
}

onStart{
    vars.count = 0;
    
}
start {
    return settings["startGKME"] && ((current.roomName == "1_1prologueb_tech_scene" || current.roomName == "1_1prologuea_tech_scene") && current.bricks == 0 && old.loadOld == 1 && current.loadOld == 0) ||
    settings["startGKME"] && (current.roomName == "1_1prologueb_tech_scene" || current.roomName == "1_1prologuea_tech_scene") && current.load != 0 && old.cutscene == 1 && current.cutscene == 0;
}

update {
    if (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1){
        vars.count++;
    }
}
split {
    return ((settings["restrictedAny"] || settings["any"]) && ((old.cutscene != current.cutscene) && (current.cutscene == 1)) && current.bricks != 0 && current.roomName == "cut\\2_tdos\\2_8smaugslair\\2_8smaugslair_outro.led_vfxart") ||
    (settings["restrictedAny"] || settings["any"] || settings["freeplay"]) && (old.statusScreen != current.statusScreen && old.statusScreen == 1) ||
    settings["any"] && (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1 && vars.count != 2);
}
