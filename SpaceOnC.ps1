#Requires -RunAsAdministrator
function MakeDirJunction(
  [string]$FolderToMove,
  [string]$FolderWhereToMove
)
{
	if ((Get-Item $FolderToMove -Force).Attributes -match [System.IO.FileAttributes]::ReparsePoint){
		Write-Host $FolderToMove 'is already a junction'
		Write-Host "To delete run "
		Write-Host "rmdir '$FolderToMove' -Force"
	return
	}
	Write-Host 'copying'
	Copy-Item $FolderToMove $FolderWhereToMove -Recurse -container -Force
	Write-Host 'remove'
	Remove-Item $FolderToMove -Recurse -Force
	Write-Host 'junction'
	New-Item -ItemType Junction -Path $FolderToMove -Value $FolderWhereToMove
}

MakeDirJunction "C:\ProgramData\Package Cache\" "D:\ProgramData\Package Cache\"
MakeDirJunction "C:\Windows\Installer\" "D:\Windows\Installer\"