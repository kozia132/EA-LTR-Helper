# Escape Academy LTR Helper
Simple helper mod for the accompanying LiveSplit autosplitter made for Escape Academy

# Installation
## Pre-Reqs
### Un-Stripped DLLs
Modloaders do not seem to work well with Escape Academy due to some missing / stripped unity DLLs.

Download the [Required DLLs](https://drive.google.com/file/d/1S3K9YNka_Qbd2bUUSx7m4HlLNvCZUrXh/view?usp=sharing)

Browse to Escape Academy's installation directory
- Steam: Right click Escape Academy -> Manage -> Browse Local Files
- Epic: Right click Escape Academy -> Manage -> Installation -> File Browse icon

Navigate to `EscapeAcademy_Data/Managed` and extract the above DLL files here. You should be asked to replace files (say yes to this)

### Melon Loader
Install the MelonLoader mod loader using the MelonLoader.Installer.exe from the [github repo](https://github.com/LavaGang/MelonLoader/releases)

When choosing a version in the launcher, choose `0.5.7`

Run Escape Academy. You should now see the Melon Loader splash screen while launching.

## Installing the mod

Download the mod from the [Releases Page](https://github.com/kozia132/EA-LTR-Helper/releases) (EA-Ltr-Helper.dll)

Browse to Escape Academy's installation directory
- Steam: Right click Escape Academy -> Manage -> Browse Local Files
- Epic: Right click Escape Academy -> Manage -> Installation -> File Browse icon

Drop the `EA-LTR-Helper` file into the `Mods` folder 

## Installing the Autosplitter

The autosplitter currently built-in to LiveSplit is outdated, and will be replaced by this autosplitter in the near future.

Download the autosplitter from the [Releases Page](https://github.com/kozia132/EA-LTR-Helper/releases) (EscapeAcademy-Autosplitter.asl)

First, make sure the outdated autosplitter is disabled:
In LiveSplit:
1. Right click
2. Click `Edit Splits`
3. Make sure the outdated autosplitter is deactivated by pressing the `Deactivate` button if it's there

To use this autosplitter,
1. Right click LiveSplit
2. Click `Edit Layout`
3. add a `Scriptable Auto Splitter`
4. Double click the Scriptable Auto Splitter to go into it's settings
5. Next to `Script Path`, click `Browse`
6. Select the `EscapeAcademy-Autosplitter.asl` you downloaded
7. Ensure `Start`, `Split`, and `Reset` are all checked
8. Right click LiveSplit
9. Compare Against -> Game Time

## Please note the current version of the helper mod and autosplitter are incompatible with newer versions of UnityExplorer
The only version ive tested UnityExplorer on is [4.5.0](https://github.com/sinai-dev/UnityExplorer/releases/tag/4.5.0)
