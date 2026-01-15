state("Escape Academy")
{
    int gameState : 0;
    int roomState : 0;
}

startup
{
    refreshRate = 60;
    vars.lastLoading = false;
    vars.readSuccess = false;
    
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    
    vars.lastGameState = -1;
    vars.lastRoomState = -1;
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var mgm = mono["Escape.Metagame.MetagameManager"];
        vars.Helper["gameState"] = mono.Make<int>(mgm, "_instance", "_currentMetaGameState");
        
        var rm = mono["Escape.Rooms.RoomManager"];
        vars.Helper["roomState"] = mono.Make<int>(rm, "Instance", "currentState");
        
        return true;
    });
}

update
{
    // LTR: Read loading state from EA-LTR-Helper's exported boolean
    var monoDll = modules.FirstOrDefault(m => m.ModuleName.ToLower() == "mono-2.0-bdwgc.dll");
    if (monoDll == null)
    {
        if (vars.readSuccess)
        {
            vars.readSuccess = false;
        }
        return false;
    }
    
    try
    {
        IntPtr ptr = memory.ReadPointer(monoDll.BaseAddress + 0x49E168);
        if (ptr == IntPtr.Zero) 
        {
            if (vars.readSuccess) vars.readSuccess = false;
            return false;
        }
        
        ptr = memory.ReadPointer(ptr + 0x10);
        if (ptr == IntPtr.Zero) return false;
        
        ptr = memory.ReadPointer(ptr + 0x8);
        if (ptr == IntPtr.Zero) return false;
        
        ptr = memory.ReadPointer(ptr + 0x8);
        if (ptr == IntPtr.Zero) return false;
        
        ptr = memory.ReadPointer(ptr + 0x58);
        if (ptr == IntPtr.Zero) return false;
        
        ptr = memory.ReadPointer(ptr + 0x98);
        if (ptr == IntPtr.Zero) return false;
        
        ptr = memory.ReadPointer(ptr + 0x10);
        if (ptr == IntPtr.Zero) return false;
        
        bool newValue = memory.ReadValue<bool>(ptr + 0x68);
        
        if (!vars.readSuccess)
        {
            vars.readSuccess = true;
        }
        
        if (newValue != vars.lastLoading)
        {
            vars.lastLoading = newValue;
        }
        
        current.isLoading = newValue;
    }
    catch
    {
        if (vars.readSuccess)
        {
            vars.readSuccess = false;
        }
        return false;
    }
    
    // Update state watchers
    vars.Helper.Update();
    
    current.gameState = vars.Helper["gameState"].Current;
    current.roomState = vars.Helper["roomState"].Current;
    
    if (current.gameState != vars.lastGameState)
    {
        vars.lastGameState = current.gameState;
    }
    
    if (current.roomState != vars.lastRoomState)
    {
        vars.lastRoomState = current.roomState;
    }
}

isLoading
{
    return current.isLoading;
}

start
{
    // Start run when transitioning from MainMenu (2) to ChapterCard (9)
    return old.gameState == 2 && current.gameState == 9;
}

split
{
    // Split when room state becomes Won (3)
    return old.roomState != 3 && current.roomState == 3;
}

reset
{
    // Reset when transitioning from MainMenu (2) to ChapterCard (9)
    return old.gameState == 2 && current.gameState == 9;
}