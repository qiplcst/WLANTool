#####################################################################################
# Module Name   : MDLTestReport
# Description	: Module for Generating Report
# Called By		: QIPLCSTTool Main Module
# Argument List : Test Group, Test Plan, Location, Return type
# Returning Arg : location
#####################################################################################
#####################################################################################
#!/usr/bin/perl
#####################################################################################
use lib "Time";
package MDLTestReport;
sub subTestReportGen 
{
   	my $winR = shift;
	my $TestGroupR = shift;
	my $TestPlanR = shift;
    my $ResultLocR = shift;
	my $ReportModule = shift;
	$winR->Insert("\nReport Generation started for \t::\t $TestGroupR.....Test Group\n");	
	$winR->update;
	$winR->Insert("\nReport Generation started for \t::\t $TestPlanR.....Test Module\n");	
	$winR->update;
    $winR->Insert("\nReport Location Path \t::\t $ResultLocR.....Report Loc\n");	
    $winR->update;
	$winR->Insert("\nReport Module Path \t::\t $ReportModule.....Report Loc\n");	
    $winR->update;
	if($TestGroupR eq 'NAN'){
		print ("Wi-Fi Aware/NAN Test Report Generation started\n");
		if($TestPlanR eq 'ALL'){
			$winR->Insert("\n$TestPlanR Test Report Generation Started ........\n");	
			$winR->update;
			my $response = open(CMD, "$dir_to_open\\acts\\tests\\google\wifi\\$pythonCmd |");
			while(<CMD>){
				chomp $_;
				$arrTestStatus[$i]=$_;
				$winR->Insert("$arrTestStatus[$i]\n");
				$winR->update;
				$i++;
			}
			$winR->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
			$winR->update;
			#my $CmdReport = "SL4A_Report.py";
			#my $responsereport = open(ReportCmd, "py $dir_to_open\\Report\\$CmdReport $ExeTestGroup $ExeTestPlan |");
			#$win->Insert("\n$ExeTestPlan Test Report @ @arrResult.........\n");	
			#$win->update;
			}
		else{
			  $winR->Insert("\n$TestPlanR Test Report Generation Started =====================\n");	
			  $winR->update;
			  $winR->configure(-state=>'normal');
			  #my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
			  #$location = ''
              my $reportgen = "python " . $ReportModule . "\\SL4A_Report.py " . "NAN" . ' ' . $TestPlanR . ' ' . $ResultLocR;
              print("\Report Generate path ::", $reportgen);
			  my $i=0;
			  my $Reporttst = open(REPORT, "$reportgen |");
			  print("\n...Report Test.........$Reporttst\n");
			  while(my $line = <REPORT>){
			  chomp $line;
			  #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
				$TestStatuslog[$i]=$line;
				$winR->Insert("$line\n");
				$winR->update;
				#}
			  }
			  $winR->Insert("\n$TestPlanR Test Report Generated Succefully *******************\n");	
			  $winR->update;
			  close(REPORT);
			}
		}
	elsif($TestGroupR eq 'Sanity'){
		    print ("WLAN-Sanity Test Report Generation started\n");
			$winR->Insert("\n$TestPlanR Test Report Generation Started =====================WLAN-Sanity\n");	
			  $winR->update;
			  $winR->configure(-state=>'normal');
			  #my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
			  #$location = ''
              my $reportgen = "python " . $ReportModule . "\SL4A_Report.py " . "Sanity" . ' ' . $TestPlanR . ' ' . $ResultLocR;
              print("\Report Generate path ::", $reportgen);
			  my $i=0;
			  my $Reporttst = open(REPORT, "$reportgen |");
			  print("\n...Report Test.........$Reporttst\n");
			  while(my $line = <REPORT>){
			  chomp $line;
			  #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
				$TestStatuslog[$i]=$line;
				$winR->Insert("$line\n");
				$winR->update;
				#}
			  }
			  $winR->Insert("\n$TestPlanR Test Report Generated Succefully *******************\n");	
			  $winR->update;
			  close(REPORT);
	}
	elsif($TestGroupR eq 'SAP'){
		    print ("WLAN-Sanity Test Report Generation started\n");
			$winR->Insert("\n$TestPlanR Test Report Generation Started =====================WLAN-Sanity\n");	
			  $winR->update;
			  $winR->configure(-state=>'normal');
			  #my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
			  #$location = ''
              my $reportgen = "python " . $ReportModule . "\SL4A_Report.py " . "SAP" . ' ' . $TestPlanR . ' ' . $ResultLocR;
              print("\Report Generate path ::", $reportgen);
			  my $i=0;
			  my $Reporttst = open(REPORT, "$reportgen |");
			  print("\n...Report Test.........$Reporttst\n");
			  while(my $line = <REPORT>){
			  chomp $line;
			  #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
				$TestStatuslog[$i]=$line;
				$winR->Insert("$line\n");
				$winR->update;
				#}
			  }
			  $winR->Insert("\n$TestPlanR Test Report Generated Succefully *******************\n");	
			  $winR->update;
			  close(REPORT);
	}
}
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################