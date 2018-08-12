## Initial Variables ##
$PageData = Invoke-WebRequest http://192.168.100.1/cmSignalData.htm

$TableCells = $PageData.AllElements | ? { $_.tagName -eq "TD" }
$TableDataOnly = $TableCells | % { $_.innerText }

## Set Output Hash Variables ##

$outputdown = @()
$outputup = @()
$outputbond = @()

## Begin Gathering Data ##

# Downstream Data Sequence Variables #
$seq1=1
$seq2=10
$seq3=19
$seq4=28
$seq5=38

do{
# Get Channel Data #
$channel = $tableDataOnly[$seq1]
$freq = $tableDataOnly[$seq2].Replace(" Hz","")
$snr = $tableDataOnly[$seq3].Replace(" dB","")
$mod = $tableDataOnly[$seq4]
$power = $tableDataOnly[$seq5].replace(" dBmV","")

# Add Ordered Data to Variable
$datarow=New-Object PSObject -Property ([ordered]@{Channel=$channel ; Freq=$freq ; SNR=$snr ; Modulation=$mod ; Power=$power})
$outputdown+=$datarow

# Increment Table Sequence variables #
$seq1++
$seq2++
$seq3++
$seq4++
$seq5++

}while($seq5 -lt 46)

# Upstream Data Sequence Variables #
$seq6=47
$seq7=52
$seq8=57
$seq9=62
$seq0=67
$seq10=77

do{
# Get Channel Data #
$channelid = $tableDataOnly[$seq6]
$upfreq = $tableDataOnly[$seq7].Replace(" Hz","")
$rangeid = $tableDataOnly[$seq8]
$upsymbol = $tableDataOnly[$seq9].replace(" Msym/sec","")
$uppower = $TableDataOnly[$seq0].replace(" dBmV","")
$upstatus = $TableDataOnly[$seq10]

# Add Ordered Data to Variable
$datarow=New-Object PSObject -Property ([ordered]@{Channel=$channelid ; Freq=$upfreq ; RangingServiceID=$rangeid ; SymbolRate=$upsymbol ; PowerLevel=$uppower ; RangingStatus=$upstatus})
$outputup+=$datarow

# Increment Table Sequence variables #
$seq6++
$seq7++
$seq8++
$seq9++
$seq0++
$seq10++

}while($seq0 -lt 71)

# Bonding Channel Variables #
$seq01=82 #to 89, so lt 90
$seq02=91
$seq03=100
$seq04=109

do{
# Get Channel Data #
$channelbondid=$TableDataOnly[$seq01]
$unerroredcodewords=$TableDataOnly[$seq02]
$correctablewords=$TableDataOnly[$seq03]
$uncorrectable=$TableDataOnly[$seq04]

# Add Ordered Data to Variable #
$datarow=New-Object PSObject -Property ([ordered]@{Channel=$channelbondid ; UnerroredCodeWords=$unerroredcodewords ; CorrectableCodeWords=$correctablewords ; UncorrectableCodeWords=$uncorrectable})
$outputbond+=$datarow

# Increment Table Sequence Variables #
$seq01++
$seq02++
$seq03++
$seq04++

}while($seq01 -lt 90)

## Export Data to InfluxDB/Grafana ##

$outputup

$outputdown

$outputbond