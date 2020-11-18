#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    $adminsymbol = $sl.PromptSymbols.ElevatedSymbol
    $venvsymbol = $sl.PromptSymbols.VirtualEnvSymbol
    $clocksymbol = $sl.PromptSymbols.ClockSymbol

    ## Left Part
    $prompt = Write-Prompt -Object " $($sl.PromptSymbols.StartSymbol) " -ForegroundColor $sl.Colors.SessionInfoForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColorFirstPart
    $prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
    $pathSymbol = if ($pwd.Path -eq $HOME) { $sl.PromptSymbols.PathHomeSymbol } else { $sl.PromptSymbols.PathSymbol }

    # Writes the drive portion
    $path = $pathSymbol + " " + (Get-FullPath -dir $pwd) + " "
    $prompt += Write-Prompt -Object $path -ForegroundColor $sl.Colors.DriveForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
    
    

    $status = Get-VCSStatus
    if ($status) {        
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.FinishPathWGithForeground -BackgroundColor $sl.Colors.SessionInfoBackgroundColorGit
        $prompt += Write-Prompt -Object " $($themeInfo.VcInfo) " -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColorGit
        $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.SessionInfoBackgroundColorGit
    }
    else {
        $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.SessionInfoBackgroundColor
    }
    If ($with) {
        $sWith = " $($with.ToUpper())"
        $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentSubForwardSymbol -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
        $prompt += Write-Prompt -Object $sWith -ForegroundColor $sl.Colors.WithForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
    }
    
    
    #$prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.SessionInfoBackgroundColor
    
    #$prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.SessionInfoBackgroundColor
    ###

    ## Right Part
    $rightElements = New-Object 'System.Collections.Generic.List[Tuple[string,ConsoleColor]]'
    #$login = $sl.CurrentUser #NOMBRE DEL USUARIO
    #$computer = [System.Environment]::MachineName; #NOMBRE DE LA PC

    $rightElements.Add([System.Tuple]::Create($sl.PromptSymbols.SegmentBackwardSymbol, $sl.Colors.SessionInfoBackgroundColor))
    # List of all right elements
    if (Test-VirtualEnv) {
        $rightElements.Add([System.Tuple]::Create(" $(Get-VirtualEnvName) $venvsymbol ", $sl.Colors.VirtualEnvForegroundColor))
        $rightElements.Add([System.Tuple]::Create($sl.PromptSymbols.SegmentBackwardSymbol, $sl.Colors.PromptForegroundColor))
    }
    if (Test-Administrator) {
        $rightElements.Add([System.Tuple]::Create("  $adminsymbol", $sl.Colors.AdminIconForegroundColor))
    }
    #$rightElements.Add([System.Tuple]::Create(" $login@$computer ", $sl.Colors.UserForegroundColor)) #El Nombre de la PC Ya no se muestra
    #$rightElements.Add([System.Tuple]::Create($sl.PromptSymbols.SegmentBackwardSymbol, $sl.Colors.PromptForegroundColor)) #Para separar el enombre de la pc y la hora
    $rightElements.Add([System.Tuple]::Create(" $(Get-Date -Format HH:mm:ss) $clocksymbol ", $sl.Colors.TimestampForegroundColor))
    $lengthList = [Linq.Enumerable]::Select($rightElements, [Func[Tuple[string, ConsoleColor], int]] { $args[0].Item1.Length })
    $total = [Linq.Enumerable]::Sum($lengthList)
    # Transform into total length
    $prompt += Set-CursorForRightBlockWrite -textLength $total
    # The line head needs special care and is always drawn
    
    #for ($i = 1; $i -lt $rightElements.Count; $i++) {
    #    $prompt += Write-Prompt -Object $rightElements[$i].Item1 -ForegroundColor $rightElements[$i].Item2 -BackgroundColor $sl.Colors.SessionInfoBackgroundColorFirstPart
    #}
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object $rightElements[0].Item1 -ForegroundColor $sl.Colors.VirtualEnvBackgroundColor
        $prompt += Write-Prompt -Object $rightElements[1].Item1 -ForegroundColor $rightElements[1].Item2 -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
        $prompt += Write-Prompt -Object $rightElements[2].Item1 -ForegroundColor $rightElements[2].Item2 -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
        $prompt += Write-Prompt -Object $rightElements[3].Item1 -ForegroundColor $rightElements[3].Item2 -BackgroundColor $sl.Colors.SessionInfoBackgroundColorFirstPart
    }
    else {
        $prompt += Write-Prompt -Object $rightElements[0].Item1 -ForegroundColor $sl.Colors.SessionInfoBackgroundColorFirstPart
        $prompt += Write-Prompt -Object $rightElements[1].Item1 -ForegroundColor $rightElements[1].Item2 -BackgroundColor $sl.Colors.SessionInfoBackgroundColorFirstPart
    }
    
    ###

    $prompt += Write-Prompt -Object "`r"
    $prompt += Set-Newline

    # Writes the postfixes to the prompt
    $indicatorColor = If ($lastCommandFailed) { $sl.Colors.CommandFailedIconForegroundColor } Else { $sl.Colors.PromptSymbolColor }
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $indicatorColor
    $prompt += ' '
    $prompt
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.StartSymbol = [char]::ConvertFromUtf32(0xe62a)
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x276F)
$sl.PromptSymbols.SegmentForwardSymbol = [char]::ConvertFromUtf32(0xE0B0)
$sl.PromptSymbols.SegmentSubForwardSymbol = [char]::ConvertFromUtf32(0xE0B1)
$sl.PromptSymbols.SegmentBackwardSymbol = [char]::ConvertFromUtf32(0xE0B2)
$sl.PromptSymbols.SegmentSubBackwardSymbol = [char]::ConvertFromUtf32(0xE0B3)
$sl.PromptSymbols.ClockSymbol = [char]::ConvertFromUtf32(0xf64f)
$sl.PromptSymbols.PathHomeSymbol = [char]::ConvertFromUtf32(0xf015)
$sl.PromptSymbols.PathSymbol = [char]::ConvertFromUtf32(0xf07c)
$sl.Colors.PromptBackgroundColor = [ConsoleColor]::Gray
$sl.Colors.SessionInfoBackgroundColor = [ConsoleColor]::Cyan
#
$sl.Colors.SessionInfoBackgroundColorFirstPart = [ConsoleColor]::Gray
$sl.Colors.SessionInfoBackgroundColorGit = [ConsoleColor]::Magenta
#
$sl.Colors.VirtualEnvBackgroundColor = [ConsoleColor]::Cyan
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Green
$sl.Colors.CommandFailedIconForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.DriveForegroundColor = [ConsoleColor]::White #
$sl.Colors.PromptForegroundColor = [ConsoleColor]::Gray #
$sl.Colors.SessionInfoForegroundColor = [ConsoleColor]::Black
$sl.Colors.WithForegroundColor = [ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor = [System.ConsoleColor]::White
$sl.Colors.TimestampForegroundColor = [ConsoleColor]::Black
$sl.Colors.UserForegroundColor = [ConsoleColor]::Yellow
$sl.Colors.GitForegroundColor = [ConsoleColor]::White # Just in case...

$sl.Colors.FinishPathWGithForeground = [ConsoleColor]::Cyan # Just in case...