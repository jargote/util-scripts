import System.IO
import System.Exit
import XMonad
import qualified Data.Map as M
import XMonad.Actions.WindowBringer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
--import XMonad.Layout.Spiral
--import XMonad.Layout.Tabbed
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

-- Preferred terminal program; used in a binding below and in certain contrib
-- modules
--
myTerminal      = "urxvt"

-- modMask allows you to specify the modkey; default is mod1Mask (left alt)
--
myModMask       = mod1Mask

-- Default number of workspaces and their names.
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Width of the window border in pixels
--
myBorderWidth   = 1

-- Border colours for unfocused and focused windows
--

myNormalBorderColor     = "#002B36"
myFocusedBorderColor    = "#EBAC54"

-- Keybindings
--myKeys :: XConfig Layout -> M.Map (ButtonMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = 
	[ ((modMask .|. controlMask, xK_l     ), spawn "slock") -- screen lock
    , ((modMask .|. shiftMask, xK_g       ), gotoMenu)      -- goto dMenu
    , ((modMask .|. shiftMask, xK_b       ), bringMenu)]    -- bringFrom dMenu

-- Join default keys to myKeys
newKeys x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts. Note that each layout is separated by |||,
-- which denotes layout choice.
--
--myTabConfig = defaultTheme { activeBorderColor = "#7C7C7C"
--							, activeTextColor = "#CEFFAC"
--							, activeColor = "#000000"
--							, inactiveBorderColor = "#7C7C7C"
--							, inactiveTextColor = "#EEEEEE"
--							, inactiveColor = "#000000" }
--myLayout = avoidStruts (tiled ||| Mirror tiled ||| tabbed shrinkText myTabConfig ||| Full ||| spiral (6/7))
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio = 1/2

     -- Percent of screen to increment by when resizing panes
     delta = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Inkscape" --> doFloat
    , className =? "Gimp" --> doFloat
    , stringProperty "WM_WINDOW_ROLE" =? "Komodo_find2" --> doFloat
    , className =? "VLC media player" --> doFloat
    , className =? "Skype" --> doFloat
    , resource =? "compose" --> doFloat
    , resource =? "Write" --> doFloat ]
--  , className =? "Terminal" --> doShift "code"
--  , className =? "Google-chrome" --> doShift "web"
--  , className =? "chromium-browser" --> doShift "web"
--  , className =? "Iceweasel" --> doShift "web"
--  , className =? "Icedove" --> doShift "email"
--  , className =? "Skype" --> doShift "im"
--  , className =? "vmplayer" --> doShift "vm"
--  , resource =? "desktop_window" --> doIgnore
--  , resource =? "plasma-desktop" --> doIgnore
--  , resource =? "kdesktop" --> doIgnore ]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q. Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()


------------------------------------------------------------------------
-- Status bars
--

-- PP formatting
myDzenPP h = defaultPP {
    -- display current workspace as darkgrey on light grey (opposite of default colors)
      ppCurrent         = dzenColor "#FDF6E3" "#002B36" . pad 
    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#93A1A1" "#002B36" . pad 
    -- display other workspaces with no windows as a normal grey
    --, ppHiddenNoWindows = dzenColor "#606060" "" . pad 
    -- display the current layout as a brighter grey
    , ppLayout          = dzenColor "#586E75" "#002B36" . pad 
    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#DC322F" "#002B36" . dzenStrip
    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 200  
    -- no separator between workspaces
    , ppWsSep           = ""
    -- put a few spaces between each object
    , ppSep             = "  "
    , ppOutput          = hPutStrLn h -- ... must match the h here
    }

myWorkspaceBar = "dzen2 -ta l -w 840 -fg '#93A1A1' -bg '#002B36'"
myDateBar = "conky -c ~/.conky_dzen | dzen2 -ta r -w 840 -x 840 -fg '#93A1A1' -bg '#002B36'"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
main = do
	workspaceBar <- spawnPipe myWorkspaceBar
	dateBar <- spawnPipe myDateBar
	xmonad $ withUrgencyHook NoUrgencyHook $ defaults {
		logHook = dynamicLogWithPP $ myDzenPP workspaceBar
		, manageHook = manageDocks <+> myManageHook
		, startupHook = setWMName "LG3D"
		}

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
	-- simple stuff
	terminal = myTerminal,
	focusFollowsMouse = myFocusFollowsMouse,
	borderWidth = myBorderWidth,
	modMask = myModMask,
	-- numlockMask = myNumlockMask,
	workspaces = myWorkspaces,
	normalBorderColor = myNormalBorderColor,
	focusedBorderColor = myFocusedBorderColor,
	
	
	-- key bindings
	keys = newKeys,
	--  mouseBindings = myMouseBindings,
	
	-- hooks, layouts
	layoutHook = smartBorders $ myLayout,
	manageHook = myManageHook,
	startupHook = myStartupHook
}
