$file_check = Test-Path $homeDocuments\ipv4\ipv4_*

if($file_check -eq 'True') 

    {

Write-Host '
  
    The ROC dog is fetching the IPv4 list 
 and prepping for direct import into findlogs. 

               ▄              ▄
              ▌▒█           ▄▀▒▌
              ▌▒▒▀▄       ▄▀▒▒▒▐
             ▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐
           ▄▄▀▒▒▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐
         ▄▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀██▀▒▌
        ▐▒▒▒▀▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄▒▒▌
        ▌▒▒ ▀▄▄▒▒▒▒▀▄ ▀▒▒▒▒▒▒▒█▒▐
       ▐▒▒▒▒▒▒▒▒▒▒▒▐  ▄▒▒▒▒▒▒▒▒▀▄▌
       ▌▒▄▀  ▀▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
       ▌▄▌▄ ▄ ▐▄▒▀▒▒▒▒▒▒░░░░░░▒▒▒▐
      ▐▒▄▌▄▌▄▒▒▀▀▒▀▒▒▒▒▒░░░░░░▒▒▒▒▌
      ▐▒▒▒▄▄▀▀▒▒▒▀▒▒▒▒▒▒░░░░░░▒▒▒▐
       ▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
       ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
        ▀▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▌
          ▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀
          ▐▀▒▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀
           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▀

          Hang on for a sec...'


$source_file = Get-ChildItem $homeDocuments\ipv4\ipv4_*


Import-Csv $source_file | select ip | Export-Csv -Path $homeDocuments\ipv4\ipv4_before.txt –NoTypeInformation  

$input_path = 'ipv4_before.txt'
$output_file = 'ipv4_after.csv'
$stage1_file = 'stage1.csv'

$regex = ‘\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b’
$remove_regex = '(^1\.0\.)|(1\.1\.)|(^127\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)'

Select-String -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $output_file

(Get-Content $output_file) -notmatch $remove_regex > $stage1_file

Import-Csv stage1.csv -Header "Destination Address" | sort 'Destination Address' -Unique | export-csv c2_$(get-date -f dd-MM-yyyy).csv -NoTypeInformation
Remove-Item $home'Documents\ipv4\ipv4_after.csv', $home'Documents\ipv4\ipv4_efore.txt', $home'\Documents\ps\c2v2\stage1.csv', $source_file

Read-Host "
                Success! 
 
   Send feedback to: thomas.
    
          Press any key to exit"
exit

}
  else {
    
    Read-Host "
    
              ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄
              ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄
             ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄
             ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄
           ▀█▒▒▒  ▒▒ ▒▒  ▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
           ▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄
           ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄█▒█
           ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▒█▀
           ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀
           ▐▒▒▒▒▒▒▒▒▒The▒▒▒TOM▒▒▒Dog▒▒▒▒▒▒▒▒▒▌
            ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
            ▐▒▒▒▒▒▒▒▒▒▒▒▒▒error▒▒▒▒▒▒▒▒▒▒▒▒▒▌
             ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
             ▐▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▌
               ▀▄▄▀▀▀▀▀▄▄▀▀▀▀▀▀▀▄▄▀▀▀▀▀▄▄▀
      
    
      Cannot Detect file, ensure you have placed the ipv4_YYYYMMDD file
      in the \Documents\ipv4\ folder and run the script again.

      If you do see red text, you have hit an error.

      Troubleshooting;

   1. Ensure you are running the script from \Documents\c2
   2. Only copy the ipv4file from the downloaded zip, not the entire .zip
   3. Run the ‘clean_up_ipv4_folder’ catch script from the \Document\ipv4\ folder.
        
      Press any key to exit"
    
    }
