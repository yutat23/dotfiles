#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\montys.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\tokyonight_storm.omp.json" | Invoke-Expression


# Key    Function                Description
# ----------------------------------------------------------------------------
# Ctrl+u BackwardDeleteLine      カーソル位置から行頭までのテキストを削除します
# Ctrl+b BackwardChar            カーソルを 1 文字前に戻します
# Ctrl+f ForwardChar             カーソルを 1 文字先に進めます
# Ctrl+d DeleteChar              カーソル位置の文字を削除します
# Ctrl+h BackwardDeleteChar      カーソルの前の文字を削除します
# Ctrl+p HistorySearchBackward   履歴を逆方向に検索します
# Ctrl+n HistorySearchForward    履歴を順方向に検索します
# Ctrl+a BeginningOfLine         カーソルを行頭に移動します
# Ctrl+e EndOfLine               カーソルを行末に移動します

Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+l' -Function ClearScreen

# 環境変数再読み込み
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Dドライブとして扱う
# subst D: C:\D

# log
# Start-Transcript D:\log\ps\$(Get-Date -f yyyyMMddHHmmss).txt

#set-alias vi 'E:\home\tool\vim82-kaoriya-win64\vim.exe'
#set-alias vim 'E:\home\tool\vim82-kaoriya-win64\vim.exe'
set-alias ll 'ls'
set-alias msedit edit

# like a which command on Linux.
function which($bin) {
  <#
  .SYNOPSIS
  この関数は、コマンドのフルパスを表示します。
  #>
  (gcm $bin).Definition
}

function gcif(){
  <#
  .SYNOPSIS
  この関数は、ファイル名のフルパスを表示します。
  -r オプションを指定すると、再帰的にファイル名を表示します。
  #>

  Param(
        [Switch] $r
    )
  if($r){
    Get-ChildItem -Recurse | ForEach-Object { $_.FullName }
  }else{
    Get-ChildItem | ForEach-Object { $_.FullName }
  }
}

set-alias gpwp Get-PortWithProcess
function Get-PortWithProcess(){
  <#
  .SYNOPSIS
  この関数は、TCPポートとプロセスの関連付けを表示します。
  #>
  $processes = Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" } | Select-Object LocalPort, OwningProcess
  $table = @()
  
  foreach ($process in $processes) {
      $processName = (Get-Process -Id $process.OwningProcess).Name
      $windowTitle = (Get-Process -Id $process.OwningProcess).MainWindowTitle
      #$state = (Get-NetTCPConnection -LocalPort $process.LocalPort).State
  
      $row = [PSCustomObject]@{
          "Port Number" = $process.LocalPort
          "Process ID" = $process.OwningProcess
          "Process Name" = $processName
          "Window Title" = $windowTitle
          #"State" = $state
      }
  
      $table += $row
  }
  
  $table | Sort-Object "Port Number" | Format-Table -AutoSize
}

Set-Alias watch Watch-Command
function Watch-Command(){
  <#
  .SYNOPSIS
  この関数は、コマンドを定期的に実行します。
  #>
  Param(
        [Parameter(Mandatory=$true)]
        [string] $command,
        [Parameter(Mandatory=$false)]
        [int] $interval = 1
    )
  while($true){
    Clear-Host
    Date
    Invoke-Expression $command
    Start-Sleep -Seconds $interval
  }
}

