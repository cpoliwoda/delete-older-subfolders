# how to use parameter from command line
#https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
param (
    [string]$del 
 )

if ( ($del -eq "") -or ($del -eq $null) ){
    $del = "no"
}
#$del # print value of variable

$currentFolder = Get-Location

# array of subfolders
$subFolders = [IO.Directory]::GetDirectories($currentFolder)

# count of subFolders
#$subFolderCounter = 0


"Folder which should be deleted:"    
#delete all subSubFolders which are not the newest one
"first parameter del = " + $del
"for deleting call: delete-older-subfolders.exe yes"

foreach ($subFolder in $subFolders){

    # array of subsubfolders
    $subSubFolders = [IO.Directory]::GetDirectories($subFolder)
    
    #$subFolderCounter++
    #$subFolderCounter # print subFolderCounter
    #$subFolder        # print

    #$subSubFolders

    #calculate newest subSubFolder
    $newestSubSubFolder = ""
    $newestSubSubFolderLeaf = ""
    foreach($subSubFolder in $subSubFolders){

        $subSubFolderLeaf = Split-Path -Path $subSubFolder -Leaf

        #empty or not assigned
        if (($newestSubSubFolderLeaf -eq $null ) -or ($newestSubSubFolderLeaf -eq "" )) {
            $newestSubSubFolderLeaf = $subSubFolderLeaf
        }

        if ($subSubFolderLeaf -ge $newestSubSubFolderLeaf) {
            
            $newestSubSubFolderLeaf = $subSubFolderLeaf
            $newestSubSubFolder     = $subSubFolder
        }
    }

    # print
    #$newestSubSubFolderLeaf
    #$newestSubSubFolder


   

    foreach($subSubFolder in $subSubFolders){

        if ($newestSubSubFolder -ne $subSubFolder) {
            
           

            # delete operation
            if ($del -eq "yes") {
                "deleting recursiv" + $subSubFolder
                Remove-Item –path $subSubFolder -Recurse
            } else {
                 #print folder which will be deleted
                 "Test run for " + $subSubFolder

            }

            
        }        
    }
} 
