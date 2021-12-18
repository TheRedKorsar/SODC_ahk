#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
critical on
Thread, Interrupt, .00005, 2

Gui, -0x30000
Gui, Add, Text, x2 y9 w80 h20 +Right, Left KEY:
Gui, Add, Text, x2 y29 w80 h20 +Right, Right KEY:
Gui, Add, Hotkey, x82 y9 w70 h20 glevent vlhk, A
Gui, Add, Hotkey, x82 y29 w70 h20 grevent vrhk, D
Gui, Add, DropDownList, x2 y49 w150 h60 gChangeMode vModeSelect, Mode 0||Mode 1|Mode 2
Gui, Add, Button, x2 y69 w150 h20 gModesInfo, Modes Info
Gui, Add, Button, x2 y89 w150 h20 gHideGui, Hide window
Gui, Show, h116 w158, Settings


Menu, Tray, Add ; separator
Menu, Tray, Add, Setting, goSettings 
Menu, Tray, Default, Setting

left_k  := 0
right_k := 0
l_hotkey = a
r_hotkey = d
mode    := 0
; Mode 0 - last key win
; Mode 1 - both keys make neutral
; Mode 2 - last key win but realise make person neutral

l_vk    := Format("vk{:x}", GetKeyVK(l_hotkey))
r_vk    := Format("vk{:x}", GetKeyVK(r_hotkey))

hotkey % "a", l_down, on, UseErrorLevel 
hotkey % "a  up", l_up, on, UseErrorLevel
hotkey % "d", r_down, on, UseErrorLevel 
hotkey % "d  up", r_up, on, UseErrorLevel


return
HideGui:
    Gui, Hide
return
GuiClose:
    ExitApp, 0
levent:
    ; MsgBox, l changed to %lhk%
    Gui, Submit, NoHide
    if (lhk <> ""){
        hotkey, % l_hotkey, off, UseErrorLevel 
        hotkey, % l_hotkey " up", off, UseErrorLevel
        l_hotkey := lhk
        hotkey % l_hotkey, l_down, on, UseErrorLevel 
        hotkey % l_hotkey " up", l_up, on, UseErrorLevel
        l_vk := Format("vk{:x}", GetKeyVK(l_hotkey))
    }
return
revent:
    ; MsgBox, r changed to %rhk%
    Gui, Submit, NoHide
    if (rhk <> ""){
        hotkey, % r_hotkey, off, UseErrorLevel 
        hotkey, % r_hotkey " up", off, UseErrorLevel
        r_hotkey := rhk
        hotkey % r_hotkey, r_down, on, UseErrorLevel 
        hotkey % r_hotkey " up", r_up, on, UseErrorLevel
        r_vk := Format("vk{:x}", GetKeyVK(r_hotkey))
    }
return

goSettings:
    Gui, Show, h116 w158, Settings
return

ChangeMode:
    Gui, Submit, NoHide
    if (ModeSelect == "Mode 0")
        mode := 0
    if (ModeSelect == "Mode 1")
        mode := 1
    if (ModeSelect == "Mode 2")
        mode := 2
return

l_down(){
    global left_k
    global right_k
    global mode
    global l_hotkey
    global r_hotkey
    global l_vk
    global r_vk
    left_k  := 1
    if (mode == 0){
        if (right_k == 1){
            SendInput, {Blind}{%r_vk% up}
            SendInput, {Blind}{%l_vk% down}
        }else{
            SendInput, {Blind}{%l_vk% down}
        }
    }
    if (mode == 1){
        if (right_k == 1){
            SendInput, {Blind}{%r_vk% up}
        }else{
            SendInput, {Blind}{%l_vk% down}
        }
    }
    if (mode == 2){
        if (right_k == 1){
            SendInput, {Blind}{%r_vk% up}{Blind}{%l_vk% down}
        }else{
            SendInput, {Blind}{%l_vk% down}
        }
    }
}

l_up(){
    global left_k
    global right_k
    global mode
    global l_hotkey
    global r_hotkey
    global l_vk
    global r_vk
    left_k  := 0
    if (mode == 0){
        if (right_k == 1){
            SendInput, {Blind}{%l_vk% up}
            SendInput, {Blind}{%r_vk% down}
        }else{
            SendInput, {Blind}{%l_vk% up}
        }
    }
    if (mode == 1){
        if (right_k == 1){
            SendInput, {Blind}{%r_vk% down}
        }else{
            SendInput, {Blind}{%l_vk% up}
        }
    }
    if (mode == 2){
        SendInput, {Blind}{%l_vk% up}
    }
}

r_down(){
    global left_k
    global right_k
    global mode
    global l_hotkey
    global r_hotkey
    global l_vk
    global r_vk
    right_k  := 1
    if (mode == 0){
        if (left_k == 1){
            SendInput, {Blind}{%l_vk% up}
            SendInput, {Blind}{%r_vk% down}
        }else{
            SendInput, {Blind}{%r_vk% down}
        }
    }
    if (mode == 1){
        if (left_k == 1){
            SendInput, {Blind}{%l_vk% up}
        }else{
            SendInput, {Blind}{%r_vk% down}
        }
    }
    if (mode == 2){
        if (left_k == 1){
            SendInput, {Blind}{%l_vk% up}{Blind}{%r_vk% down}
        }else{
            SendInput, {Blind}{%r_vk% down}
        }
    }
}

r_up(){
    global left_k
    global right_k
    global mode
    global l_hotkey
    global r_hotkey
    global l_vk
    global r_vk
    right_k  := 0
    if (mode == 0){
        if (left_k == 1){
            SendInput, {Blind}{%r_vk% up}
            SendInput, {Blind}{%l_vk% down}
        }else{
            SendInput, {Blind}{%r_vk% up}
        }
    }
    if (mode == 1){
        if (left_k == 1){
            SendInput, {Blind}{%l_vk% down}
        }else{
            SendInput, {Blind}{%r_vk% up}
        }
    }
    if (mode == 2){
        SendInput, {Blind}{%r_vk% up}
    }
}

ModesInfo:
    MsgBox, Mode 0 - last pressed key win. After realise a key, if opposite key was hold that key will be activated.`n`nMode 1 - When both keys are in hold, player will be in neutral position, don't move to the right or left.`n`nMode 2 - Same as Mode 0, But after realise a button player will stop. Input required to move player.
return
