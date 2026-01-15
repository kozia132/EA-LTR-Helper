using MelonLoader;
using Escape.Metagame;
using Escape.Rooms;
using UnityEngine;
[assembly: MelonInfo(typeof(EA.LTR.LtrMod), "EA-LTR-Helper", "1.0.3", "connienw")]
[assembly: MelonGame("CoinCrewGames", "Escape Academy")]

namespace EA.LTR
{
    public static class LtrData
    {
        public static bool FullLoadingState = false;
#if DEBUG
        public static bool DebugOverride = false;
#endif
    }
    public class LtrMod : MelonMod
    {
#if DEBUG
        bool _last;
        GameState _lastGameState;
        RoomManager.State _lastRoomState;
#endif
        public override void OnUpdate()
        {
#if DEBUG
            // toggle override with ctrl+shift+G, purely for testing and finding a pointer faster
            if (Input.GetKey(KeyCode.LeftControl) &&
                Input.GetKey(KeyCode.LeftShift) &&
                Input.GetKeyDown(KeyCode.G))
            {
                LtrData.DebugOverride = !LtrData.DebugOverride;
                MelonLogger.Msg($"DebugOverride toggled: {LtrData.DebugOverride}");
            }
#endif
            var wipe = TransitionWipeSequence.Instance;
            bool loading = (wipe != null && (wipe.TransitionActive || wipe.IsLoadingScreenUp));
#if DEBUG
            // override forces true when active
            LtrData.FullLoadingState = LtrData.DebugOverride ? true : loading;
#else
            LtrData.FullLoadingState = loading;
#endif
#if DEBUG
            if (LtrData.FullLoadingState != _last)
            {
                _last = LtrData.FullLoadingState;
                MelonLogger.Msg($"FullLoadingState = {_last}");
            }

            GameState currentGameState = MetagameManager.CurrentMetaGameState;
            if (currentGameState != _lastGameState)
            {
                _lastGameState = currentGameState;
                MelonLogger.Msg($"GameState = {_lastGameState}");
            }

            RoomManager.State currentRoomState = RoomManager.Instance.CurrentState;
            if (currentRoomState != _lastRoomState)
            {
                _lastRoomState = currentRoomState;
                MelonLogger.Msg($"RoomState = {_lastRoomState}");
            }
#endif
        }
    }
}