<#
.SYNOPSIS
    Sets a known folder's path using SHSetKnownFolderPath.
.PARAMETER Folder
    The known folder whose path to set.
.PARAMETER Path
    The path.
#>
function Set-KnownFolderPath {
    Param (
            [Parameter(Mandatory = $true)]
            [ValidateSet( 'Desktop', 'Documents', 'Downloads',  'Pictures', 'Music', 'Videos', '3D Objects')]
            [string]$KnownFolder,

            [Parameter(Mandatory = $true)]
            [string]$Path
    )

    # Define known folder GUIDs
    $KnownFolders = @{
        'Desktop' = 'B4BFCC3A-DB2C-424C-B029-7FE99A87C641';
        'Documents' = 'FDD39AD0-238F-46AF-ADB4-6C85480369C7';
        'Downloads' = '374DE290-123F-4565-9164-39C4925E467B';
        'Pictures' = '33E28130-4E1E-4676-835A-98395C3BC3BB';
        'Music' = '4BD8D571-6D19-48D3-BE97-422220080E43';
        'Videos' = '18989B1D-99B5-455B-841C-AB7C74E4DDFC';
        '3D Objects' = '31C0DD25-9439-4F12-BF41-7FF4EDA38722';
    }

    # Define SHSetKnownFolderPath if it hasn't been defined already
    $Type = ([System.Management.Automation.PSTypeName]'KnownFolders').Type
    if (-not $Type) {
        $Signature = @'
[DllImport("shell32.dll")]
public extern static int SHSetKnownFolderPath(ref Guid folderId, uint flags, IntPtr token, [MarshalAs(UnmanagedType.LPWStr)] string path);
'@
        $Type = Add-Type -MemberDefinition $Signature -Name 'KnownFolders' -Namespace 'SHSetKnownFolderPath' -PassThru
    }

    # Validate the path
    if (Test-Path $Path -PathType Container) {
        # Call SHSetKnownFolderPath
        return $Type::SHSetKnownFolderPath([ref]$KnownFolders[$KnownFolder], 0, 0, $Path)
    } else {
        throw New-Object System.IO.DirectoryNotFoundException "Could not find part of the path $Path."
    }
}

ForEach ($Dir in ( "Desktop", "Documents", "Downloads",  "Pictures", "Music", "Videos", "3D Objects"))
    {
        Set-KnownFolderPath -KnownFolder $Dir -Path "L:\User\$Dir"
    } 
