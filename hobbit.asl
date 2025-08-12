//Created by FlamingLazer, Biksel and Siedemnastek
//Works on DX9 Version
state("LEGOHobbit")
{
    int bricks: 0x0167BB70, 0x1C, 0x168;
    int levelLoad: 0x167A828;
    int load: 0x17D8844;
    int loadOld: 0x18006E0;
    int statusScreen: 0x01792BC8, 0x10, 0x14, 0x574;
    int roomNumber: 0x1802B08;
    string80 roomName: 0x017926A4, 0xC4, 0x0;
    string3 roomName2: 0x017926A4, 0xC4, 0x0;
    int cutscene: 0x16D14D8;
    int resetPrevention: 0x172C0C8;
}
startup{
    settings.Add("startGKME", true, "Start timer on loading GKME");
    settings.Add("any", true, "Any%");
    settings.Add("restrictedAny", false, "Restricted Any%");
    settings.Add("freeplay", false, "Freeplay");
    settings.Add("roomSplits", false, "Room Splits (RAny%)");

    vars.roomValues = new List<string> {
        "1_1prologueb_tech_scene",
        "1_1prologuec_tech_scene",
        "1_1prologue_midtro1c2",
        "1_1prologued_mechanism_scene",
        "cut\\1_auj\\1_1prologue\\1_1prologue_midtro1b.led",
        "1_1prologue_midtro1c2",
        "1_1prologuee_damaged_tech_scene",
        "1_1prologue_midtro3_vfxart_scene",
        "1_1prologueg_tech_scene",
        "2_6tomb_tech_scene",
        "2_6dolguldur_midtro2_vfxart_scene",
        "2_7ereborb_tech_scene"
        };
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
    return ((settings["restrictedAny"] || settings["any"] || settings["roomSplits"]) && ((old.cutscene != current.cutscene) && (current.cutscene == 1)) && current.bricks != 0 && current.roomName == "cut\\2_tdos\\2_8smaugslair\\2_8smaugslair_outro.led_vfxart") ||
    (settings["restrictedAny"] || settings["any"] || settings["freeplay"] || settings["roomSplits"]) && (old.statusScreen != current.statusScreen && old.statusScreen == 1) ||
    settings["any"] && (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1 && vars.count != 2) ||
    (settings["roomSplits"] && vars.roomValues.Contains(current.roomName) && current.roomNumber != old.roomNumber && current.resetPrevention == 0) ||
    (settings["roomSplits"] && (old.levelLoad == 0 && current.levelLoad == 1 && current.statusScreen != 1 && current.roomName != "2_6dolguldurd_tech_scene")) ||
    (settings["roomSplits"] && current.roomName == "2_6dolguldurd_tech_scene" && current.roomNumber != old.roomNumber && current.roomNumber < 4 && current.roomNumber > 0) ||
    (settings["roomSplits"] && current.roomName == "tier5_tech_scene" && old.cutscene == 0 && current.cutscene == 1)||
    (settings["roomSplits"] && current.roomNumber == 3 && current.roomName == "2_8smaugslair_midtro3a_vfxart" && old.cutscene == 0 && current.cutscene == 1);
}
