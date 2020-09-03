#####################################################################################
# Module Name   : MDLTestExecution
# Description	: Module for executing test cases
# Called By		: QIPLCSTTool Main Module
# Argument List : Test Group, Selected Test cases
# Returning Arg : None
#####################################################################################
#####################################################################################
#!/usr/bin/perl
#####################################################################################
use lib "Time";
use lib "Report";
use MDLTestReport;
package MDLTestExecution;
sub subTestExecution 
{
   	my $win = shift;
	my $ExeTestGroup = shift;
	my $ExeTestPlan = shift;
    my $location = shift;
	my @TestList = @_;
    $win->Insert("Test Group Selected for Execution\t::\t $ExeTestGroup\n");	
	$win->update;
	$win->Insert("Test Plan Selected for Execution \t::\t $ExeTestPlan\n");	
	$win->update;
	$win->Insert("Test Cases Selected for Execution \t::\t @TestList\n");	
	$win->update;
    $win->Insert("CST Test Execution Script for storing Result \t::\t $location\n");	
    $win->update;
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = 0;
    ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
    $year += 1900;
    $mon += 1;
    foreach $key ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) {
	    if($key =~ m/^.$/)
	    {
			$key = '0' . $key;
	    }	
    }
    my $timeStamp = "$year" . "$mon" . "$mday" . "_$hour" . "$min" . "$sec"; 
	if($ExeTestGroup eq 'Wi-Fi Aware/NAN'){
		print ("Wi-Fi Aware/NAN Test Features started\n");
		$GroupPlan = 'NAN';
		if($ExeTestPlan eq 'ALL'){
			$win->Insert("\n$ExeTestPlan Test Feature Started @ $timeStamp.........\n");	
			$win->update;
			chomp($dir_to_open=`cd`);
			print "Directory" . $dir_to_open."\n";
			my $CmdReport = "SL4A_Report.py $ExeTestGroup $ExeTestPlan";
			print "CmdReport" . $CmdReport."\n";
			my $responsereport = open(ReportCmd, "py $dir_to_open\\Report\\$CmdReport $ExeTestGroup $ExeTestPlan |");
			print "ResponseReport" . $responsereport;
			my $pythonCmd = "act.py -c wifi_nan.txt -tc AttachTest.py";
			print "PythonCommand" . $pythonCmd."\n";
			my $response = open(CMD, "$dir_to_open\\acts\\tests\\google\wifi\\$pythonCmd |");
			while(<CMD>){
				chomp $_;
				$arrTestStatus[$i]=$_;
				$win->Insert("$arrTestStatus[$i]\n");
				$win->update;
				$i++;
			}
			$win->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
			$win->update;
			#my $CmdReport = "SL4A_Report.py";
			#my $responsereport = open(ReportCmd, "py $dir_to_open\\Report\\$CmdReport $ExeTestGroup $ExeTestPlan |");
			#$win->Insert("\n$ExeTestPlan Test Report @ @arrResult.........\n");	
			#$win->update;
		}
		else{
			  $win->Insert("\n$ExeTestPlan Test Feature Started @ $timeStamp.........\n");	
			  $win->update;
			  $win->configure(-state=>'normal');
			  @TestStatuslog = ();
			  #my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
              my $execute = "python " . $location . "\\" . "Setup\\" . "ActSetup.py " . "Execute " . "None " . ' ' . $GroupPlan . ' ' . $ExeTestPlan;
              print("\nExecution path ::", $execute);
			  my $i=0;
			  my $executetst = open(EXEC, "$execute |");
			  print("\n...ExecuteTest.........$executetst\n");
			  while(my $line = <EXEC>){
			  chomp $line;
			  #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
				$TestStatuslog[$i]=$line;
				$win->Insert("$TestStatuslog[$i]\n");
				$win->update;
				$i++;
				#}
			  }
			  $win->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
			  $win->update;
			  close(EXEC);
			  $newloc = $location . "\\Results\\NAN\\". $ExeTestPlan;
			  $reportmod = $location . "\\Report\\";
			  print("\nNew Location for report.....$newloc\n");
			  print("\nReport Module location.....$reportloc\n");
			  MDLTestReport::subTestReportGen($win,$GroupPlan,$ExeTestPlan,$newloc,$reportmod);
			  $win->Insert("\nTest Report Generated.........\n");	
			  $win->update;
		}
	}
	elsif($ExeTestGroup eq 'Wi-Fi Aware/RTT'){
        $win->Insert("\n$ExeTestPlan Test Feature Started @ $timeStamp.........\n");	
		$win->update;
	    $win->configure(-state=>'normal');
		$GroupPlan = 'RTT';
		@TestStatuslog = ();
		#my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
        my $execute = "python " . $location . "\\" . "Setup\\" . "ActSetup.py " . "Execute " . "None " . ' ' . $GroupPlan . ' ' . $ExeTestPlan;
        print("\nExecution path ::", $execute);
	    my $i=0;
		my $executetst = open(EXEC, "$execute |");
		print("\n...ExecuteTest.........$executetst\n");
		while(my $line = <EXEC>){
			chomp $line;
			 #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
			$TestStatuslog[$i]=$line;
			$win->Insert("$TestStatuslog[$i]\n");
			$win->update;
			$i++;
			#}
		}
		$win->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
		$win->update;
		close(EXEC);
		$newloc = $location . "\\Results\\NAN\\". $ExeTestPlan;
		$reportmod = $location . "\\Report\\";
		print("\nNew Location for report.....$newloc\n");
		print("\nReport Module location.....$reportloc\n");
		MDLTestReport::subTestReportGen($win,$GroupPlan,$ExeTestPlan,$newloc,$reportmod);
		$win->Insert("\nTest Report Generated.........\n");	
		$win->update;
	}
	elsif($ExeTestGroup eq 'WLAN-Sanity'){
        $win->Insert("\n$ExeTestPlan Test Feature Started @ $timeStamp.........\n");	
		$win->update;
	    $win->configure(-state=>'normal');
		$GroupPlan = 'Sanity';
		@TestStatuslog = ();
		#my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
        my $execute = "python " . $location . "\\" . "Setup\\" . "ActSetup.py " . "Execute " . "None " . ' ' . $GroupPlan . ' ' . $ExeTestPlan;
        print("\nExecution path ::", $execute);
	    my $i=0;
		my $executetst = open(EXEC, "$execute |");
		print("\n...ExecuteTest.........$executetst\n");
		while(my $line = <EXEC>){
			chomp $line;
			 #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
			$TestStatuslog[$i]=$line;
			$win->Insert("$TestStatuslog[$i]\n");
			$win->update;
			$i++;
			#}
		}
		$win->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
		$win->update;
		close(EXEC);
		$newloc = $location . "\\Results\\Sanity\\". $ExeTestPlan;
		$reportmod = $location . "\\Report\\";
		print("\nNew Location for report.....$newloc\n");
		print("\nReport Module location.....$reportloc\n");
		MDLTestReport::subTestReportGen($win,$GroupPlan,$ExeTestPlan,$newloc,$reportmod);
		$win->Insert("\nTest Report Generated.........\n");	
		$win->update;
	}
	elsif($ExeTestGroup eq 'SAP-ACS'){
        $win->Insert("\n$ExeTestPlan Test Feature Started @ $timeStamp.........\n");	
		$win->update;
	    $win->configure(-state=>'normal');
		$GroupPlan = 'SAP';
		@TestStatuslog = ();
		#my $execute = "python C:\\Qualcomm_Working_Directory\\Work\\2018\\Automation\\QIPL_CST_Automation\\Setup\\ActSetup.py Execute None $ExeTestGroup $ExeTestPlan";
        my $execute = "python " . $location . "\\" . "Setup\\" . "ActSetup.py " . "Execute " . "None " . ' ' . $GroupPlan . ' ' . $ExeTestPlan;
        print("\nExecution path ::", $execute);
	    my $i=0;
		my $executetst = open(EXEC, "$execute |");
		print("\n...ExecuteTest.........$executetst\n");
		while(my $line = <EXEC>){
			chomp $line;
			 #if (($line =~ /PASS/) || ($line =~ /FAIL/)){
			$TestStatuslog[$i]=$line;
			$win->Insert("$TestStatuslog[$i]\n");
			$win->update;
			$i++;
			#}
		}
		$win->Insert("\n$ExeTestPlan Test Feature Execution Completed @ $timeStamp.........\n");	
		$win->update;
		close(EXEC);
		$newloc = $location . "\\Results\\SAP\\". $ExeTestPlan;
		$reportmod = $location . "\\Report\\";
		print("\nNew Location for report.....$newloc\n");
		print("\nReport Module location.....$reportloc\n");
		MDLTestReport::subTestReportGen($win,$GroupPlan,$ExeTestPlan,$newloc,$reportmod);
		$win->Insert("\nTest Report Generated.........\n");	
		$win->update;
	}
	elsif($tab3tstplan eq 'DP_Trace'){
	}
}
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################