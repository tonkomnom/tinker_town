;V1.0

#SingleInstance, force
SetWorkingDir %A_ScriptDir%

FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk

I_Icon = %A_ScriptDir%\blue.ico
Menu, Tray, Icon, %I_Icon%
Menu, Tray, Tip, %A_ScriptName%
Menu, Tray, NoStandard
Menu, Tray, Add, Info..., guiAbout
Menu, Tray, Add, Hilfe, guiHelp
Menu, Tray, Add
Menu, Tray, Add, Sichern über PS4000, guiSichern
Menu, Tray, Add, Wiederherstellen über PS4000, guiHerstellen
Menu, Tray, Add, Ablage über Explorer, guiExplorer
Menu, Tray, Add
Menu, Tray, Add, Programm anhalten, gPause
Menu, Tray, Add, Beenden, gExit
return


#IfWinActive, PS4000 Projektkonsole
~LButton::
	if WinExist("PS4000 Projektkonsole","Sicherung")
		{
		MouseGetPos,,,, OutputVarControl
			if OutputVarControl = Button1
				Gosub, guiSichern
				OutputVarControl :=""
			return
		}
	else
		{
		if WinExist("PS4000 Projektkonsole","Wiederherstellung")
			MouseGetPos,,,, OutputVarControl
			if OutputVarControl = Button1
				Gosub, guiHerstellen
				OutputVarControl :=""
			return
		}
	return


;GUI PS4000 Sicherung
guiSichern:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h50 w120 gSichern, Sichern
	Gui, Add, Button, x65 y160 h20 w70 gexit, Schließen
	return

Sichern:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow324, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*abgelegt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
			SplashTextOn,,25, Status, Datei wurde erzeugt.
			Sleep, 750
			SplashTextOff
			Gui, Destroy
			}
	currentPath :=""
	return


;GUI PS4000 Wiederherstellung
guiHerstellen:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h50 w120 gHerstellen, Wiederherstellen
	Gui, Add, Button, x65 y160 h20 w70 gexit, Schließen
	return

Herstellen:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*wiederhergestellt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde wiederhergestellt von %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
			SplashTextOn,,25, Status, Datei wurde erzeugt.
			Sleep, 750
			SplashTextOff
			Gui, Destroy
			}
	currentPath :=""
	return


;GUI Windows Explorer
guiExplorer:
	Gui, Destroy
	Gui, +E0x08000000 +AlwaysOnTop
	Gui, Show, x250 y250 w200 h200 NoActivate, %A_ScriptName%
	Gui, Add, Button, x40 y5 h20 w120 gExplorersub1, Sichern
	Gui, Add, Button, x40 h20 w120 gExplorersub2, Wiederherstellen
	Gui, Add, Button, x40 h20 w120 gExplorersub3, Ausbuchen
	Gui, Add, Button, x65 y170 h20 w70 gexit, Schließen
	return

Explorersub1:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*abgelegt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% die letzte Datensicherung wurde abgelegt durch %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
			SplashTextOn,,25, Status, Datei wurde erzeugt.
			Sleep, 750
			SplashTextOff
			Gui, Destroy
			}
	currentPath :=""
	return

Explorersub2:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	FileDelete, %currentPath%\*wiederhergestellt*.ps5
	FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde wiederhergestellt von %A_UserName%.ps5
		if ErrorLevel
			MsgBox,, Fehler, Achtung, es wurde keine Datei erzeugt!
		else
			{
			SplashTextOn,,25, Status, Datei wurde erzeugt.
			Sleep, 750
			SplashTextOff
			Gui, Destroy
			}
	currentPath :=""
	return

Explorersub3:
	WinGet, win_id, ID, A
	ControlGetText bar_text, ToolbarWindow323, ahk_id %win_id%
	StringTrimLeft, currentPath, bar_text, 9
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	InputBox, ausbuchen_name, PS4000 Ablage, Für wen wird die Sicherung ausgebucht?,,,150
		if ausbuchen_name =
			MsgBox,, Fehler!, Sie haben keinen Namen angegeben, bitte erneut versuchen.
		else
		{
			FileDelete, %currentPath%\*übergeben*.ps5
			FileAppend, , %currentPath%\%CurrentDateTime% Achtung! Das Projekt wurde übergeben an %ausbuchen_name%.ps5
				if ErrorLevel
					MsgBox,, Fehler!, Achtung, es wurde keine Datei erzeugt!
				else
					{
					SplashTextOn,,25, Status, Datei wurde erzeugt.
					Sleep, 750
					SplashTextOff
					Gui, Destroy
					}
			currentPath :=""
			ausbuchen_name :=""
		}
	return


gPause:
	menu, tray, ToggleCheck, Programm anhalten
	Suspend, Toggle
	Pause, Toggle
	return

gExit:
	ExitApp
	Return

guiAbout:
	Gui, 99:Destroy
	Gui, 99:Add, Text, ,© Manuel Jurca, Kieback&&Peter GmbH && Co. KG
	Gui, 99:Add, Text, ,Version V1.0, 2018-09-19
	Gui, 99:Add, Text, ,
	Gui, 99:Add, Text, ,jurca@kieback-peter.de
	Gui, 99:Add, Text, ,Tel: 4128
	Gui, 99:Show, AutoSize
	return

guiHelp:
	Run, %A_ScriptDir%\readme.txt
	return

guiclose:
Gui, Destroy

exit:
Gui, Destroy