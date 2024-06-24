--importing modules
   --Base
import XMonad
import System.Exit
import qualified XMonad.StackSet as W
   --Layout
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.ResizableTile
import XMonad.Layout.CenteredIfSingle
   --Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
   --Util
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
   --Actions
import XMonad.Actions.NoBorders
   --Data
import Data.Monoid
import qualified Data.Map        as M

toggleFull = withFocused (\windowId -> do
{
   floats <- gets (W.floating . windowset);
   if windowId `M.member` floats
   then do
       withFocused $ toggleBorder
       withFocused $ windows . W.sink
   else do
       withFocused $ toggleBorder
       withFocused $  windows . (flip W.float $ W.RationalRect 0 0 1 1)    }    )

-- The preferred terminal program,
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False 

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1 

-- Modkey
-- mod1Mask = "left alt" , mod3Mask = "right alt", mod4Mask= "windows key" 
--
myModMask       = mod4Mask --super key

--workspaces init
--
myWorkspaces    = ["1:main", "2:web", "3:code", "4:docs", "5:chat", "6:music", "7:video", "8:gfx", "9:other"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#545454"

-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((mod1Mask, xK_t), spawn $ XMonad.terminal conf)
    , ((modm,  xK_g ),   withFocused toggleBorder)
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")
    --fullscreen    
    , ((mod4Mask, xK_f), sendMessage ToggleStruts)
    --screenshot
    , ((modm, xK_Print), spawn "gnome-screenshot")
    --thunar
    , ((modm, xK_o), spawn "thunar")
    , ((controlMask .|. shiftMask, xK_Escape), spawn "alacritty -e htop")

    --multimedia
    -- Volume_UP
    , ((0, xK_Page_Up), spawn "amixer -q sset Master 2%+")
    --Volume_Down
    , ((0, xK_Page_Down), spawn "amixer -q sset Master 2%-")
    --Toggle_VOlume
    , ((controlMask, xK_Page_Down), spawn "amixer -D pulse set Master 1+ toggle")
    --Pause-Play
    , ((0, xK_F13), spawn "playerctl play-pause")
    -- player next
    , ((0, xK_End), spawn "playerctl next")
    -- player prev
    , ((0, xK_Home), spawn "playerctl previous")

--cmus control
    -- seek +5 cmus
    , ((controlMask, xK_End), spawn "cmus-remote -C 'seek +5'")
    --seek -5 cmus
    , ((controlMask, xK_Home), spawn "cmus-remote -C 'seek -5'")
    --cmus start from beg
    , ((controlMask .|. mod1Mask, xK_Home), spawn "cmus-remote -C player-play")
    --cmus repeat
    , ((controlMask .|. mod1Mask, xK_End), spawn "cmus-remote -C 'toggle repeat_current'")
    --lock-screen
    , ((controlMask .|. mod1Mask, xK_Delete), spawn "xscreensaver-command -lock")
    --toggle fullscreen
    ,((modm,               xK_f     ), toggleFull)

---------------------------------------------------
    -- Switch between workspaces 
    , ((modm, xK_ampersand), windows $ W.greedyView "1:main")
    , ((modm, xK_eacute), windows $ W.greedyView "2:web")
    , ((modm, xK_quotedbl), windows $ W.greedyView "3:code")
    , ((modm, xK_apostrophe), windows $ W.greedyView "4:docs")
    , ((modm, xK_parenleft), windows $ W.greedyView "5:chat")
    , ((modm, xK_minus), windows $ W.greedyView "6:music")
    , ((modm, xK_egrave), windows $ W.greedyView "7:video")
    , ((modm, xK_underscore), windows $ W.greedyView "8:gfx")
    , ((modm, xK_ccedilla), windows $ W.greedyView "9:other")

--moving windows to a cetain workspace layout FR

    , ((modm .|. shiftMask, xK_ampersand), windows $ W.shift "1:main")
    , ((modm .|. shiftMask, xK_eacute), windows $ W.shift "2:web")
    , ((modm .|. shiftMask, xK_quotedbl), windows $ W.shift "3:code")
    , ((modm .|. shiftMask, xK_apostrophe), windows $ W.shift "4:docs")
    , ((modm .|. shiftMask, xK_parenleft), windows $ W.shift "5:chat")
    , ((modm .|. shiftMask, xK_minus), windows $ W.shift "6:music")
    , ((modm .|. shiftMask, xK_egrave), windows $ W.shift "7:video")
    , ((modm .|. shiftMask, xK_underscore), windows $ W.shift "8:gfx")
    , ((modm .|. shiftMask, xK_ccedilla), windows $ W.greedyView "9:other")

---------------------------------------------------
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    --, ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_semicolon ), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

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
    [ className =? "MPlayer"          --> doFloat
    , className =? "Gimp"             --> doFloat
    , className =? "freecad"          --> doFloat
    , className =? "Tk"               --> doCenterFloat
    , className =? "GParted"          --> doCenterFloat
    , isDialog                        --> doCenterFloat --chi window sghira etc 
    , className =? "picocad"          --> doFloat
    , className =? "mGBA"             --> doFloat
    , className =? "Blender"          --> doFloat
    , className =? "feh"              --> doFloat
    , className =? "Nitrogen"         --> doFloat
    , className =? "XCalc"            --> (doF W.focusDown <+> doFloat)
    , className =? "mpv"              --> doFloat
    , className =? "file_progress"    --> doFloat
    , className =? "dialog"           --> doFloat
    , className =? "download"         --> doFloat
    , className =? "error"            --> doFloat
    , className =? "xmessage"         --> doFloat
    , className =? "confirm"          --> doFloat
    , className =? "Firefox-esr"      --> doShift ( myWorkspaces !! 0 )
    , className =? "qutebrowser"      --> doShift ( myWorkspaces !! 1 )
    , resource  =? "desktop_window"   --> doIgnore
    , resource  =? "kdesktop"         --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty



------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do 
	spawnOnce "xmodmap $HOME/.config/X11/xmodmap &"
	spawnOnce "nitrogen --restore &"
	spawnOnce "compton --config $HOME/.config/compton/compton.conf &"
	spawnOnce "xscreensaver -no-splash &"
        spawnOnce "nm-applet &"
        spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 100 --tint 0x292d3e --height 17 &"
 



------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobar.conf"  
  xmonad $ docks defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
--        layoutHook         = myLayout,
        layoutHook         = spacingWithEdge 10 $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
