cls
# vytvori v ceste $cesta adresar nahodneho nazvu a vnej jeste soubor, taky nahodneho nazvu
# a potom vse presune do kose ve Windows ( da se obnovit z kose pro kontrolu potom )

$str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

$d_str = $str.Length -1
#echo $d_str


# random nazev adresare
function rnd_adresar {
$name = "" # uvnitr funkce vse lokalni promenna atd.(nevadej "duplicity")
for ($aa = 1; $aa -le 6; $aa++) {
$rnd = Get-Random -Minimum 0 -Maximum $d_str
$z = $str.Substring($rnd,1)
#echo $z"<"
$name+=$z
}
#echo $name
return $name
}


# random nazev *.txt souboru
function rnd_soubor {
$name = "" # toto lokalni promenna
for ($aa = 1; $aa -le 6; $aa++) {
$rnd = Get-Random -Minimum 0 -Maximum $d_str
$z = $str.Substring($rnd,1)
#echo $z"<"
$name+=$z
}
$name+=".txt"
#echo $name
return $name
}

$cesta = "C:\work\" # tady se bude vse vytvaret

$adresar_2 = $cesta
$adresar = rnd_adresar
$prvni_adresar = $adresar
$adresar_2 += $adresar
#echo $adresar_2

$vymazat_adresar = $adresar_2 + "\"
#echo $vymazat_adresar

New-Item -Path $adresar_2 -ItemType Directory -Force #| Out-Null

sleep -Milliseconds 200

$soubor = rnd_soubor
#echo $soubor
$soubor_2 = $cesta + $prvni_adresar + "\" + $soubor
#echo $soubor_2
New-Item -ItemType file -Path $soubor_2 -Value "text" -ErrorAction Ignore #| Out-Null


# sleep 1 # kdyz se pred to nezada nic tak to bere jako vteriny (vterina je ale zbytecne moc)
sleep -Milliseconds 200 # bude cekat 0.2 vteriny

# funkce ktera presouva do kose ve windows
function Recycle-Item {
param([string] $Path)
$shell = New-Object -ComObject 'Shell.Application'
$shell.NameSpace(0).ParseName($Path).InvokeVerb('Delete')
}


# vytvoreni adresar nahodnyho nazvu a soubor vnem presune do kose ve Windows
# predtim vyskoci okno a chce potrvdit smazani adresare
Recycle-Item $vymazat_adresar
sleep -Milliseconds 200

# presune do kose i slozitou adresarovou strukturu, pokud se mu jeste neco prida do jim vytvoreneho adresare
# v okamziku kdyz se ceka na potvrzeni okna pro smazani slozky, takze se to chova uplne stejne a bez problemu
# jako by se mazalo ( presouvoalo ) primo ve Windows v pruzkumnikovy napr. takze funguje bezvadne

