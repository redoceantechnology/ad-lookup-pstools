[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)][string]$inputfile,    # inputfile is mandatory
  [string]$outputfile = "outputfile.csv"
  )
$inputdata = import-csv $inputfile


$outputdata = foreach ($user in $inputdata) {
$lookup = $user.user 

$samaccountname = Get-ADUser -filter "emailaddress -eq '$lookup'" | Select-Object -ExpandProperty samaccountname
#$samaccountname

[pscustomobject]@{
            group = $user.group
            user = $user.user
            samaccountname = $samaccountname
        }
}

$outputdata | Export-Csv $outputfile
