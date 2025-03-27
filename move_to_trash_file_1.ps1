cls
# vytvori soubor nahodneho nazvu a pak ho presune do kose ve windows tzn. nemaze natvrdo

$str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

$d_str = $str.Length -1
#echo $d_str

$filename = ""
for ($aa = 1; $aa -le 6; $aa++) {
$rnd = Get-Random -Minimum 0 -Maximum $d_str
$z = $str.Substring($rnd,1)
#echo $z"<"
$filename+=$z
}

#echo $filename

#$soubor = "R:\" + $filename + ".txt" # na ramdisku maze uplne 
$soubor = "C:\work\" + $filename + ".txt" # jinde, presune do kose
#echo $soubor

New-Item -ItemType file -Path $soubor -Value "text" -ErrorAction Ignore #| Out-Null

function Recycle-Item {
param([string] $Path)
$shell = New-Object -ComObject 'Shell.Application'
$shell.NameSpace(0).ParseName($Path).InvokeVerb('Delete')
}


Recycle-Item $soubor
sleep -Milliseconds 200

