$program_not_run=1
$aList = ProcessList ("notepad.exe") ;;
For $i=1 To $aList[0][0]
	;ConsoleWrite($aList[$i][1] &@CRLF)
	;ConsoleWrite( _ProcessGetOwner($aList[$i][1]) &@CRLF)
	$process_owner=_ProcessGetOwner($aList[$i][1])
	;ConsoleWrite(@UserName )
	ConsoleWrite($process_owner &@CRLF)
	if " & '@UserName' & "=$process_owner Then 
		ConsoleWrite("other" &@CRLF)
	Else 
		ConsoleWrite("PO RUN!! EXIT!!" &@CRLF) ;Пользователь уже запустил ПО
		$program_not_run=0  ;отменяем запуск ПО
		Exit ;завершаем скрипт
	EndIf
Next
ConsoleWrite("1" &@CRLF)
if $program_not_run=1 Then ;Пользователь еще не запустил ПО, запускаем
	ConsoleWrite("2" &@CRLF)
	Run("notepad.exe") ;;
EndIf




Func _ProcessGetOwner($PID, $sComputer = ".")
    Local $objWMI, $colProcs, $sUserName, $sUserDomain
    $objWMI = ObjGet("winmgmts:\\.\root\cimv2")
    If IsObj($objWMI) Then
        $colProcs = $objWMI.ExecQuery("Select ProcessId From Win32_Process Where ProcessId="& $PID)
        If IsObj($colProcs) Then
            For $Proc In $colProcs
                If $Proc.GetOwner($sUserName, $sUserDomain)=0 Then Return $sUserName
            Next
        EndIf
    EndIf
EndFunc
