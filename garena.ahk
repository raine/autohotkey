;
; Easy-to-use AutoHotkey script intended to make joining
; full rooms on Garena effortless (and in the long run less time consuming)
;
; How to use:
; * Run script, press F1 and click room you want to join.
; * Pressing F2 at any time will reset the script to the state it was upon launch.
;
; Author: Raine Virta <rane@kapsi.fi>
;

F1::Gosub, JoinRoom
F2::Reload

JoinRoom:
  Loop
  {
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%

    if color = 0xFF9933
      break
  }
  Gosub, LeaveRoom
  Loop
  {
    Click, %MouseX%, %MouseY%, 2
    joinedAt := A_TickCount
    Loop
    {
      SetTitleMatchMode, Slow
      ; Got into the room
      if WinExist("Garena", "System Message")
        return
      if WinExist("", "room is full")
      {
        Send {Escape}
        break
      }
    }

    ; Wait until 5 seconds have passed since
    ; the latest join attempt
    Loop
    {
      elapsed := A_TickCount - joinedAt
      if elapsed >= 5000
        break
    }
  }
return

LeaveRoom:
  ControlClick, Leave Room, Garena
  Loop
  {
    if WinExist("Garena", "still in room")
    {
      ControlClick, OK, Garena
      break
    }
  }
return