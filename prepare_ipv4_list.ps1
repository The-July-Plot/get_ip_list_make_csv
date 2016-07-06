Write-Host '  
  The TOM cat is prepping the IPv4 list. 

   ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄
   ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄
  ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄
  ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄
▀█▒▒▒  ▒▒ ▒▒  ▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄
▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄█▒█
▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▒█▀
▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀
▐▒▒▒▒▒The▒▒▒TOM▒▒▒Cat▒▒▒▒▒▒▒▒▒▒▒▒▒▌
 ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
 ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
  ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
  ▐▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▌
    ▀▄▄▀▀▀▀▀▄▄▀▀▀▀▀▀▀▄▄▀▀▀▀▀▄▄▀
    
       Hang on for a sec...'


$source_file = Get-ChildItem $home\Documents\ipv4\ipv4_*


Import-Csv $source_file > $home'\Documents\ipv4\ipv4_before.txt'

$input_path = 'ipv4_before.txt'
$output_file = 'ipv4_after.csv'
$stage1_file = 'stage1.csv'

$regex = ‘\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b’
$remove_regex = '(^1\.0\.)|(1\.1\.)|(^127\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)'


Select-String -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $output_file
(Get-Content $output_file) -notmatch $remove_regex > $stage1_file


Import-Csv stage1.csv -Header "ipv4 Address's" | sort 'ipv4 Address's' -Unique | export-csv ipv4_$(get-date -f dd-MM-yyyy).csv -NoTypeInformation

Remove-Item $home'\Documents\ipv4\ipv4_after.csv', $home'\Documents\ipv4\ipv4_before.txt', $home'\Documents\c2\stage1.csv', $source_file

Read-Host "

  If you do not see any red text above, success! 
  
  If you do see red text, you have hit an error.

  Troubleshooting;

    1.	Ensure you are running the script from \Documents\ipv4
    2.  Make sure you have a valid source file in \Documents\ipv4
    
    Press any key to exit"
exit
