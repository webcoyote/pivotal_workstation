import XMonad
import XMonad.Config.Gnome

main = xmonad gnomeConfig {
  -- Alt (default)
  -- modMask = mod1Mask

  -- Use mod3 key to activate XMonad instead of Alt or Ctrl since
  -- they are widely used by applications. The mod3 key is mapped
  -- by ~/.config/autostart/xmodmap.desktop
  modMask = mod3Mask    
}

