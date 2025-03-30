state("harry2")
{
    bool isLoading: 0xC59978;
    bool VoldemortHead: 0x00C38554, 0x4, 0x28, 0x18, 0x20, 0xA8, 0x94, 0x44;
    bool start: 0x00C4EA2C, 0x8, 0x40, 0x2F8;
    byte goldBrickCount: 0x00C5B5FC, 0x0;
    int statusScreen: 0xB271E4;
}

startup {
    settings.Add("split_save", true, "Split on saving (Standard/N0CUT5 With Saves/NG+)");
    settings.Add("split_nosave", false, "Split on continue without saving (N0CUT5 Without Saves)");

    vars.preventSplit = new Stopwatch();
}

update {
  if (vars.preventSplit.ElapsedMilliseconds > 4000) vars.preventSplit.Reset();
}

onStart {
  vars.preventSplit.Start();
}

onReset {
    vars.preventSplit.Reset();
}

onSplit {
  vars.preventSplit.Start();
}

isLoading
{
    return current.isLoading;
}

split
{
   return (settings["split_save"] && current.VoldemortHead && !old.VoldemortHead) ||
   (settings["split_nosave"] && old.goldBrickCount != current.goldBrickCount && current.goldBrickCount != 0 && current.goldBrickCount != 18) ||
   (settings["split_nosave"] && old.statusScreen == 1 && current.statusScreen == 0 && !vars.preventSplit.IsRunning);+
}
start
{
    return current.start && !old.start;
}