#####################################################################################
# FILE: QIPLCSTTool.PL
# VERSION: 1.0
# DATE: 15-JAN-2020
# TAG: QIPL CST Automation Tool
# AUTHOR: Imran Ansari
# DESCRIPTION: Automation tool for QIPL WLAN CST
#####################################################################################
#!/usr/bin/perl
#####################################################################################
#
#####################################################################################
# Description	: List of Perl Modules required for this Package
#####################################################################################
use Tk;
use Tk::JPEG;
use Tk::BrowseEntry;
use Tk::PathEntry;
require Tk::LabFrame;
use Tk::ColoredButton;
use Tk::NoteBook;
# use Win32::SerialPort;
use Data::Dumper;
use XML::XPath;
use XML::XPath::XMLParser;
use XML::Simple;
use XML::Twig;
use XML::Parser;
use Tk::FileEntry;
#####################################################################################
# Description	: List of User Defined Packages
#####################################################################################
use lib "Util";
use lib "Setup";
use SL4AACTSSetup;
use MDLTestExecution;
use IOTFileReader;
use IOTFileCreater;
use File::Path qw(make_path remove_tree);
#####################################################################################
# Description	: Global Declaration of Variables
#####################################################################################
my $tstFileCreater = IOTFileCreater->new;
my $tstFileReader = IOTFileCreater->new;
my ($color, $shape, $style, $cmpd, $orient) = ('gray', 'rectangle', 'shiny', 'center', 'nw');
my $bitmap = 'question';
my $angle = (($style eq 'shiny') && ($shape eq 'round')) ? 0.04 : 0.08;
@Text=("Select","Smallest","Smaller","Medium","Larger","Largest");
chomp($dir_to_open=`cd`);
#print "$dir_to_open\n";
@arrTestGroup = ('Select','Wi-Fi Aware/NAN', 'Wi-Fi Aware/RTT','GScan', 'Performance','IOT');
$tstGroup = $arrTestGroup[0];
@tab3arrTestGroup = ('Select','WLAN-Sanity', 'Legacy_Features','New_Features', 'Wi-Fi Aware/NAN', 'WLAN-Stats', 'Wi-Fi Aware/RTT','SAP-ACS', 'STA-SAP CONC', 'Performance', 'WLAN-IOT');
$tab3tstGroup = $tab3arrTestGroup[0];
@tabArrResultGroup = ('Select','WLAN-Sanity', 'Legacy_Features','New_Features', 'Wi-Fi Aware/NAN', 'WLAN-Stats', 'Wi-Fi Aware/RTT','SAP-ACS', 'STA-SAP CONC', 'Performance', 'WLAN-IOT');
$tabarrresultgroup = $tabArrResultGroup[0];
#@arrTestPlan = ('Select');
#$tstPlan = $arrTestPlan[0];
@arrSec = ('Select','None', 'WEP-40','WEP-104', 'WPA-PSK','WPA2-PSK');
$dutsec=$arrSec[0];
@arrAuth = ('Select','Open','Shared');
$dutauth=$arrAuth[0];
@arrdot11Band = ('Select','11A Mode','11B Mode','11G Mode','11NG Mode','11NA Mode');
$dot11band=$arrdot11Band[0];
@arrdot11Width = ('Select','HT20','HT40','HT20/40');
$dot11width=$arrdot11Width[0];
@VendorName=('Select','Cisco','Atheros','NetGear','Belkin','Apple','Marvell','Broadcom','Aruba','Dlink');
$vendorname=$VendorName[0];
@adbDevices = ();
@newArr = ();
my $adb = "adb devices";
my $i=0;
my $j=0;
my $adbdevices = open(ADB, "$adb |");
while(<ADB>){
chomp $_;
$adbDevices[$i]=$_;
if($adbDevices[$i]=~/(.*)\sdevice/){
$newArr[$j] = $1;
$j++;
}
$i++;
}
$size = @newArr;
if($size <= 2) {$adbid = $newArr[1];}
else{$adbid = '*';}
#####################################################################################
#
#-----------------Create GUI for Main Window(QIPL CST Automation Tool)-----------------#
#
#-----------------------Created by 	: Imran Ansari--------------------------------#
#
#####################################################################################

$window = MainWindow->new;
$window->title("QIPL CST Automation Framework");
$image = "5.ico";  # 32x32 GIF or BMP
$icon = $window->Photo(-file => $image);
#$window->idletasks;              # this line is crucial
#$window->iconimage($icon);
$window->configure(-background=>'white');
$window->geometry( "1200x700" );#x/y
# $window->geometry( "700x500" );#x/y
$window->resizable(0,0);
$window->grab;
#2B60DE
$txtTestResult=$window->Scrolled('Text',-width=>82,-height=>35,-background => 'white',-font => "Arial 12 bold",-scrollbars=>'e',-foreground => '#0000FF')->place(-x=>440, -y=>1);
tie(*TXTRESULT,'Tk::Text',$txtTestResult);
		$str = "######## QIPL CST WLAN Automation Tool 1.0 Started ########\n\n";
		$txtTestResult->Insert($str);
		$txtTestResult->update;
        @adbDevices2 = ();
		@newDisplay = ();
        my $adb2 = "adb devices";
        my $i=0;
		my $j=0;
        my $adbdevices = open(ADB2, "$adb2 |");
        while(<ADB2>){
			chomp $_;
            $adbDevices2[$i]=$_;
			if($adbDevices2[$i]=~/(.*)\sdevice/){
				$newDisplay[$j] = $1;
				$j++;
			}
			$i++;
           }
$txtTestResult->Insert("DUT ID ====> $newDisplay[1]\n");
$txtTestResult->Insert("REF1 ID ===> $newDisplay[2]\n");
$txtTestResult->Insert("REF2 ID ===> $newDisplay[3]\n");
$txtTestResult->Insert("Location ==> $dir_to_open\n");
$txtTestResult->update;	
  
$txtTestResult->configure(-font => "Arial 12 bold");
my $frmCBUConfig = $window->LabFrame(-label => "QIPL CST WLAN Automation Tool",-labelside => 'acrosstop',-foreground => '#0000FF',-background => 'white',-font => "Arial 15 bold",-width => 430,-height => 644)->place(-x=> 0,-y=> 1);
$logo = $frmCBUConfig->Photo(-file => "logo1.jpg",-format=>"JPEG");
$frmCBUConfig->Label(-borderwidth=>0,-image => $logo)->place(-x=>0,-y=>455);
$frmCBUConfig->Label(-foreground => '#2B60DE',-font => "Arial 18 bold",-background => 'white',-foreground => '#0040ff', -text => "QIPL WLAN CST!!!!")->place(-x=>200,-y=>592);

#---------------------------------------------------------------# Main Tab Creation #---------------------------------------------------------------#

$nbookCBU = $frmCBUConfig->NoteBook(-font => "Arial 12 bold")->place(-x=>5,-y=>10);
$tab1 = $nbookCBU->add( "Sheet 1", -label=>"Setup Configuration",-raisecmd=>[\&SetCurrentTab, 1] );
$tab2 = $nbookCBU->add( "Sheet 2", -label=>"Test Creation", -raisecmd=>[\&SetCurrentTab, 2] );
$tab3 = $nbookCBU->add( "Sheet 3", -label=>"Test Execution", -raisecmd=>[\&SetCurrentTab, 3]);
$frametab1 = $tab1->Frame(-background => 'white',-width => 413, -height => 410)->pack;
$frametab2 = $tab2->Frame(-background => 'white',-width => 413, -height => 410)->pack;
$frametab3 = $tab3->Frame(-background => 'white',-width => 413, -height => 410)->pack;

#---------------------------------------------------------------# Tab#1 - Setup Configuration #---------------------------------------------------------------#

my $frmRunInfo = $frametab1->LabFrame(-label=>'SL4A/ACTs Setup Info',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 397,-height => 145)->place(-x=> 5,-y=> 3);
		$tstPlan = 'Select';
		$controlip='172.16.21.1';
		$deviceid='HT4565378';
		$actsPath='';
		$logPath='';
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text => "Test Group:")->place(-x=>40,-y=>10);
		$runTestGroup = $frmRunInfo->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',autolistwidth=>'1',-background => 'LightGrey',-variable => \$tstGroup)->place(-x=>160,-y=>10);
		$runTestGroup->insert("end", @arrTestGroup);
		$runTestGroup->configure(-command=>\&subTestGroup);
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text => "Test Plan:")->place(-x => 40,-y =>30);
		$runTestPlan = $frmRunInfo->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tstPlan)->place(-x=>160,-y=>30);
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text =>"Device_IP:")->place(-x => 40,-y =>50);
		$entControlIP = $frmRunInfo->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-textvariable => \$controlip,-width=>20,-background => 'white')->place(-x => 160,-y =>50);
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text => "Device_ID:")->place(-x => 40,-y =>70);
		$entDeviceID = $frmRunInfo->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-textvariable => \$adbid,-width=>20,-background => 'white')->place(-x => 160,-y =>70);
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text => "ACTS Folder:")->place(-x => 40,-y =>90);
		$actslocation= $frmRunInfo->FileEntry(-label=>'',-foreground=>'#15317E',-background => 'white',-variable=>\$actsPath)->place(-x => 154,-y =>90);
		$frmRunInfo->Label(-font=>'Arial 10',-background => 'white',-text => "LOG Path:")->place(-x => 40,-y =>110);
		$logpath = $frmRunInfo->FileEntry(-label=>'',-foreground=>'#15317E',-background => 'white',-variable=>\$logPath)->place(-x => 154,-y =>110);
		
my $frmTstBed = $frametab1->LabFrame(-label=>'Chrome OS Setup Info',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 250,-height => 163)->place(-x=> 5,-y=> 190);
my $frmDeviceDetails = $frametab1->LabFrame(-label=>'Device Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 140,-height => 162)->place(-x=> 265,-y=> 190);
		$ipaddress='15.15.113.1';
		$configtool='Select';
		$frmTstBed->Label(-font=>'Arial 10',-background => 'white',-text => "Vendor_Name:")->place(-x => 5,-y =>20);
		$TstVendorName = $frmTstBed->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$vendorname)->place(-x=>100,-y=>20);
		$TstVendorName->insert("end", @VendorName);
		$frmTstBed->Label(-font=>'Arial 10',-background => 'white',-text => "Model_Number:")->place(-x => 5,-y =>40);
		$entDeviceModel = $frmTstBed->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-width=>19,-background => 'white')->place(-x => 100,-y =>40);
		$frmTstBed->Label(-font=>'Arial 10',-background => 'white',-text => "IP_Address:")->place(-x => 5,-y =>60);
		$entIPAddress = $frmTstBed->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-width=>19,-textvariable => \$ipaddress,-background => 'white')->place(-x => 100,-y =>60);
		$frmTstBed->Label(-font=>'Arial 10',-background => 'white',-text => "Config_Tool:")->place(-x => 5,-y =>80);
		$TstBedConfigTool = $frmTstBed->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$configtool)->place(-x=>100,-y=>80);;
		$TstBedConfigTool->insert("end", "HTTP");
		$TstBedConfigTool->insert("end", "Telnet");
$btnCommit = $frametab1->Button(-text=>"Commit",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'DarkGreen',-activeforeground => 'white',-padx => 12,-pady => 1,-font=>"Arial 10 bold",-command=>\&subAddDevices)->place(-x=> 165,-y=>380);
$listDeviceList = $frmDeviceDetails->Scrolled('Listbox',-width=>19,-height=>10,-selectmode=>'single',-scrollbars=>'e', -background => 'LightGrey',-foreground=>'#15317E',-font=>'Arial 8 bold')->place(-x=>4,-y=>6);
$frmDeviceDetails->Scrolled('Listbox',-width=>19,-height=>10,-selectmode=>'single',-scrollbars=>'e', -background => 'LightGrey',-foreground=>'#15317E',-font=>'Arial 8 bold')->place(-x=>4,-y=>6);
&subListIOTAP;
$btnSetup = $frametab1->Button(-text=>"Setup",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Blue',-activeforeground => 'white',-padx => 17,-pady => 1,-font=>"Arial 10 bold",-command=>\&subACTsSetup)->place(-x=> 40,-y=>380);
$btnClose = $frametab1->Button(-text=>"Close",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Tomato',-activeforeground => 'white',-padx => 17,-pady => 1,-font=>"Arial 10 bold",-command=>sub {$window->destroy})->place(-x=> 290,-y=>380);

#---------------------------------------------------------------# Tab#2 - TestPlan Creation #---------------------------------------------------------------#

my $frmTstCreation = $frametab2->LabFrame(-label=>'TestPlan Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 397,-height => 70)->place(-x=> 5,-y=> 5);
		my $tstplan = 'Select';
		my $tstgroup = 'Select';
	  	$frmTstCreation->Label(-font=>'Arial 10',-background => 'white',-text => "Test Plan:")->place(-x=>40,-y=>10);
		$optTestPlan = $frmTstCreation->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tstplan)->place(-x=>160,-y=>10);
		$optTestPlan->insert('end', "STA-IOT");
		$optTestPlan->insert('end', "SoftAP-IOT");
		$frmTstCreation->Label(-font=>'Arial 10',-background => 'white',-text => "Test Group:")->place(-x=>40,-y=>30);
		$optTstGroup = $frmTstCreation->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tstgroup)->place(-x=>160,-y=>30);
		$optTstGroup->insert("end", "Basic Association");
    	$optTstGroup->insert("end", "Multicast");
    	$optTstGroup->insert("end", "WPS");
    	$optTstGroup->insert("end", "PowerSave");
my $frmTstAP_DUTConfig = $frametab2->LabFrame(-label=>'DUT and AP Parameters Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 250,-height => 202)->place(-x=> 5,-y=> 115);
my $frmTstCaseDetails = $frametab2->LabFrame(-label=>'Test Case Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 140,-height => 202)->place(-x=> 265,-y=> 115);

#---------------------------------------------------------------# Tab#2 DUT Parameters #---------------------------------------------------------------#

		$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "SSID:")->place(-x => 5,-y =>30);
		$entSTASSID = $frmTstAP_DUTConfig->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-width=>19,-background => 'white')->place(-x => 100,-y =>30);
		$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Channel:")->place(-x => 5,-y =>50);
		$entSTAChannel = $frmTstAP_DUTConfig->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-width=>19,-background => 'white')->place(-x => 100,-y =>50);
		$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Security:")->place(-x => 5,-y =>70);
		$optSTASec = $frmTstAP_DUTConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$dutsec)->place(-x=>100,-y=>70);
		$optSTASec->insert("end", @arrSec);
    	$lblNetworkKey=$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Network Key:")->place(-x => 5,-y =>90);
		$entNetworkKey = $frmTstAP_DUTConfig->Entry(-foreground=>'#15317E',-font=>'Arial 9 bold',-width=>19,-background => 'white')->place(-x => 100,-y =>90);
		$optSTASec->configure(-command=>\&subNetworkKey);
    	$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Authentication:")->place(-x => 5,-y =>110);
		$optSTAAuth = $frmTstAP_DUTConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$dutauth);
		$optSTAAuth->insert("end", @arrAuth);
    	$optSTAAuth->place(-x=>100,-y=>110);
    	$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Wireless Mode:")->place(-x => 5,-y =>130);
		$optSTABand = $frmTstAP_DUTConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$dot11band);
		$optSTABand->insert("end", @arrdot11Band);
    	$optSTABand->place(-x=>100,-y=>130);
    	$frmTstAP_DUTConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Channel Width:")->place(-x => 5,-y =>150);
		$optSTAWidth = $frmTstAP_DUTConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-width=>17,-background => 'LightGrey',-variable => \$dot11width);
		$optSTAWidth->insert("end", @arrdot11Width);
    	$optSTAWidth->place(-x=>100,-y=>150);


		$listTestCase = $frmTstCaseDetails->Scrolled('Listbox',-width=>19,-height=>13,-selectmode=>'single',-scrollbars=>'e', -background => 'LightGrey',-foreground=>'RoyalBlue',-font=>'Arial 8 bold')->place(-x=>4,-y=>6);
        #&subListTestCase;
		$btnCommit = $frametab2->ColoredButton(-text=>"Commit",-foreground=>'#15317E',-background => $color,
							-padx => 20,-font=>"Arial 10 bold",-command=>\&subCreateTst)->place(-x=> 50,-y=>345);

		$btnClose = $frametab2->ColoredButton(-text=>"Close",-foreground=>'#15317E',-background => $color,
							-padx => 25,-font=>"Arial 10 bold",-command=>sub {$window->destroy})->place(-x=> 170,-y=>345);

		$btnModify = $frametab2->ColoredButton(-text=>"Modify",-foreground=>'#15317E',-background => $color,
							-padx => 25,-font=>"Arial 10 bold",-command=>sub {$window->destroy})->place(-x=> 285,-y=>345);

#------------------# Tab#3 - Test Plan Execution#-----------------------------------#
#####################################################################################
# Description	: Actual Test Execution Tab
#####################################################################################

my $frmTestExeConfig = $frametab3->LabFrame(-label=>'TestGroup & TestPlan Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 397,-height => 80)->place(-x=> 5,-y=> 3);
	$frmTestExeConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Test Group:")->place(-x=>30,-y=>10);
	$Tab3TstGroup = $frmTestExeConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tab3tstGroup);
 	$Tab3TstGroup->insert("end", @tab3arrTestGroup);
	$Tab3TstGroup->place(-x=>140,-y=>10);
    $Tab3TstGroup->configure(-command=>\&subSelectTestGroup);
	$tab3tstplan = 'Select';
    $frmTestExeConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Test Plan:")->place(-x=>30,-y=>30);
	$Tab3TstPlan = $frmTestExeConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-state => 'disabled', -variable => \$tab3tstplan);
	$Tab3TstPlan->place(-x=>140,-y=>30);
	$Tab3TstPlan->configure(-command=>\&subSelectTestCases);
	my $sta2gConnect = $frmTestExeConfig->Checkbutton(-text => "STA 2G", -font=>'Arial 12 bold',-background => 'white',-variable=> \$sta2g,-activeforeground  => 'Blue')->place(-x=>310,-y=>0);
	my $sta5gConnect = $frmTestExeConfig->Checkbutton(-text => "STA 5G", -font=>'Arial 12 bold',-background => 'white',-variable=> \$sta5g,-activeforeground  => 'Blue')->place(-x=>310,-y=>25);
	my $sta6gConnect = $frmTestExeConfig->Checkbutton(-text => "STA 6G", -font=>'Arial 12 bold',-background => 'white',-variable=> \$sta6g,-activeforeground  => 'Blue')->place(-x=>310,-y=>50);
	$tab3tstconfig = 'Select';
    $frmTestExeConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Test Config:")->place(-x=>30,-y=>50);
	$Tab3TstConfig = $frmTestExeConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-state => 'disabled',-variable => \$tab3tstconfig);
	$Tab3TstConfig->insert("end", 'Interactive/DW-1');
	$Tab3TstConfig->insert("end", 'Non-Interactive/DW-4');
	$Tab3TstConfig->place(-x=>140,-y=>50);

my $frmTestDetails = $frametab3->LabFrame(-label => "Test Items Details",-labelside => 'acrosstop',-font=>'Arial 10 bold',-background=>'white',-width => 395,-height => 243)->place(-x=>5,-y=>110);
	$frmTestDetails->Label(-font=>'Arial 10',-background=>'white',-text=>"Available Tests")->place(-x=>25,-y=>0);
	$frmTestDetails->Label(-font=>'Arial 10',-background=>'white',-text=>"Selected Tests")->place(-x=>250,-y=>0);
	$btnMove=$frametab3->ColoredButton(-text=>">>",-padx => 25,-pady => 5,-foreground=>'#15317E',-font => "Arial 10 bold",-background => $color,-command=>\&subMoveSelected)->place(-x=>168,-y=>200);
	$btnReMove=$frametab3->ColoredButton(-text=>"<<",-padx => 25,-pady => 5,-foreground=>'#15317E',-font => "Arial 10 bold",-background => $color,-command=>\&subRemoveSelected)->place(-x=>168,-y=>235);
 	$btnAddAll=$frametab3->ColoredButton(-text=>"Add All",-padx => 14,-pady => 5,-foreground=>'#15317E',-font => "Arial 9 bold",-background => $color,-command=>\&subAddAll)->place(-x=>168,-y=>270);
 	$btnRemoveAll=$frametab3->ColoredButton(-text=>"Remove All",-padx => 1,-pady => 5,-foreground=>'#15317E',-font => "Arial 9 bold",-background => $color,-command=>\&subRemoveAll)->place(-x=>168,-y=>305);

	$listAvailableTest=$frmTestDetails->Scrolled('Listbox',-width=>22,-height=>14,-scrollbars=>'e',-foreground=>'#15317E',-background => 'LightGrey',-font => "Arial 8 bold")->place(-x=>4,-y=>23);
	$listSelectedTest=$frmTestDetails->Scrolled('Listbox',-width=>22,-height=>14,-scrollbars=>'e',-foreground=>'#15317E',-background => 'LightGrey',-font => "Arial 8 bold")->place(-x=>240,-y=>23);
$btnExecute = $frametab3->Button(-text=>"Execute",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Blue',-activeforeground => 'white',-padx => 12,-pady => 1,-font=>"Arial 10 bold",-command=>\&subExecuteTest)->place(-x=> 40,-y=> 380);
$btnQuit = $frametab3->Button(-text=>"Close",-padx => 12,-pady => 1,-font=>"Arial 10 bold",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Tomato',-activeforeground => 'white',-command=>\&subCloseWinRunTst)->place(-x=> 170,-y=> 380);
$btnResult = $frametab3->Button(-text=>"Result",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'DarkGreen',-activeforeground => 'white',-padx => 12,-pady => 1,-font=>"Arial 10 bold",-command=>\&subShowResultTst)->place(-x=> 285,-y=> 380);

my $menubar = $window->Menu;
$window->configure(-menu => $menubar);
$menubar->configure(-background=>'#F0FAFF');

my $mnuHelp = $menubar->cascade(-label => 'Help', -tearoff => 0,-background=>'white');



$mnuHelp->command(-label => 'Show Help',-command=>\&subHelp,-background=>'white');
$mnuHelp->separator;
$mnuHelp->command(-label => 'About', -command => \&subAbout,-background=>'white');

#MainLoop();
###################################################################################
# Function Name : subTestGroup
# Description	: Select Test Plan based on Test Group
# Created by 	: Imran Ansari
#####################################################################################
sub subTestGroup{
	@arrTestPlan = ();
	$arrTestPlan[0] = 'ALL';
			if ($tstGroup eq 'Wi-Fi Aware/NAN'){
				print "magya\n";
				@arrTestPlan = ();
		        $runTestPlan->insert("end", @arrTestPlan);
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional");
				@dir_contents= readdir(DIR);
				closedir(DIR);
				my $i=1;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
				if($file=~/^functional\.txt$/i){
						open(FILE,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\$file");
							while(my $line = <FILE>){
								chomp $line;
								#print "$line\n";
								$arrTestPlan[$i]=$line;
								$i++;
								}
								print "@arrTestPlan\n";
								close(FILE);
							}
						}
					}
				}
			elsif ($tstGroup eq 'WLAN-Stats'){
				print "magya\n";
				@arrTestPlan = ();
		        $runTestPlan->insert("end", @arrTestPlan);
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\Stats");
				@dir_contents= readdir(DIR);
				closedir(DIR);
				my $i=1;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
				if($file=~/^functional\.txt$/i){
						open(FILE,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\$file");
							while(my $line = <FILE>){
								chomp $line;
								#print "$line\n";
								$arrTestPlan[$i]=$line;
								$i++;
								}
								print "@arrTestPlan\n";
								close(FILE);
							}
						}
					}
				}
			elsif ($tstGroup eq 'Wi-Fi Aware/RTT'){
				print "magya\n";
				@arrTestPlan = ();
		        $runTestPlan->insert("end", @arrTestPlan);
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\rtt\\functional");
				@dir_contents= readdir(DIR);
				closedir(DIR);
				my $i=1;
				foreach $file (@dir_contents){
					print("File::: $file\n");
				if(!(($file eq ".") || ($file eq ".."))){
				if($file=~/^functional\.txt$/i){
						open(FILE,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\$file");
							while(my $line = <FILE>){
								chomp $line;
								#print "$line\n";
								$arrTestPlan[$i]=$line;
								$i++;
								}
								print "@arrTestPlan\n";
								close(FILE);
							}
						}
					}
				}
		$runTestPlan->insert("end", @arrTestPlan);
		@arrTestPlan = ();
		$runTestPlan->insert("end", @arrTestPlan);
}
###################################################################################
# Function Name : subSelectTestGroup
# Description	: Select Test Plan based on Test Group for Execution
# Created by 	: Imran Ansari
#####################################################################################
sub subSelectTestGroup{
	@arrTab3TestPlan = ();
    print("Inside subSelectTestGroup.........$tab3tstGroup\n");
			
			if ($tab3tstGroup eq 'New_Features'){
				print "magya\n";
				@arrTab3TestPlan = ();
		        $Tab3TstPlan->insert("end", @arrTab3TestPlan);
				$Tab3TstPlan->configure(-state=>'normal');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\TestCase");
				@dir_contents= readdir(DIR);
				closedir(DIR);
				my $i=0;
				foreach $file (@dir_contents){
				print "Features" . $file . "\n";
				if(!(($file eq ".") || ($file eq ".."))){
					$arrTab3TestPlan[$i] = $file;
					$i++;
					}
					}
				}
			elsif ($tab3tstGroup eq 'Wi-Fi Aware/NAN'){
				print "magya\n";
				@arrTab3TestPlan = ();
		        $Tab3TstPlan->insert("end", @arrTab3TestPlan);
				$Tab3TstPlan->configure(-state=>'normal');
				$Tab3TstConfig->configure(-state=>'normal');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional");
				@dir_contents= readdir(DIR);
                print("@dir_contents\n");
				closedir(DIR);
				$arrTab3TestPlan[0]='ALL';
				my $i=1;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
				if($file=~/^functional\.txt$/i){
						open(FILE,"$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\$file");
							while(my $line = <FILE>){
								chomp $line;
								#print "$line\n";
								$arrTab3TestPlan[$i]=$line;
								$i++;
								}
								print "$arrTab3TestPlan\n";
								close(FILE);
							}
						}
					}
				}
			elsif ($tab3tstGroup eq 'WLAN-Stats'){
				print "Inside WLAN Stats Folder\n";
				$Tab3TstPlan->configure(-state=>'normal');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\Stats");
				@dir_contents= readdir(DIR);
                print("@dir_contents\n");
				closedir(DIR);
				my $i=0;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
					if($file=~/(.*)\.py$/i){
						print "$1\n";
						$arrTab3TestPlan[$i]=$1;
						$i++;
						}
						print "$arrTab3TestPlan\n";
						}
						
					}
				}
            elsif ($tab3tstGroup eq 'Wi-Fi Aware/RTT'){
				print "magya\n";
				@arrTab3TestPlan = ();
		        $Tab3TstPlan->insert("end", @arrTab3TestPlan);
				$Tab3TstPlan->configure(-state=>'normal');
				$Tab3TstConfig->configure(-state=>'normal');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\rtt\\functional");
				@dir_contents= readdir(DIR);
                print("@dir_contents\n");
				closedir(DIR);
				my $i=0;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
				if($file=~/^funtional\.txt$/i){
						open(FILE,"$dir_to_open\\acts\\tests\\google\\wifi\\rtt\\functional\\$file");
							while(my $line = <FILE>){
								chomp $line;
								$arrTab3TestPlan[$i]=$line;
								$i++;
								}
								print "@arrTab3TestPlan\n";
								close(FILE);
							}
						}
					}
				}
			elsif ($tab3tstGroup eq 'WLAN-Sanity'){
				print "Inside WLAN Sanity Group\n";
				$Tab3TstPlan->configure(-state=>'normal');
				$Tab3TstConfig->configure(-state=>'normal');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\Sanity");
				@dir_contents= readdir(DIR);
                print("@dir_contents\n");
				closedir(DIR);
				my $i=0;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
					if($file=~/(.*)\.py$/i){
						print "$1\n";
						$arrTab3TestPlan[$i]=$1;
						$i++;
						}
						print "$arrTab3TestPlan\n";
						}
						
					}
				}
			elsif ($tab3tstGroup eq 'SAP-ACS'){
				print "Inside WLAN Sanity Group\n";
				$Tab3TstPlan->configure(-state=>'normal');
				$Tab3TstConfig->configure(-state=>'disabled');
				chomp($dir_to_open=`cd`);
				opendir(DIR,"$dir_to_open\\acts\\tests\\google\\wifi\\SAP");
				@dir_contents= readdir(DIR);
                print("@dir_contents\n");
				closedir(DIR);
				my $i=0;
				foreach $file (@dir_contents){
				if(!(($file eq ".") || ($file eq ".."))){
					if($file=~/(.*)\.py$/i){
						print "$1\n";
						$arrTab3TestPlan[$i]=$1;
						$i++;
						}
						print "$arrTab3TestPlan\n";
						}
						
					}
				}
		$Tab3TstPlan->insert("end", @arrTab3TestPlan);
		@arrTab3TestPlan = ();
		$Tab3TstPlan->insert("end", @arrTab3TestPlan);
}
#####################################################################################
# Function Name : subSelectTestCases
# Description	: List all the Test Case according to Selected Test Plan
# Created By	: Imran Ansari
#####################################################################################
sub subSelectTestCases{
		@arrFile=();
		my $i=0;
		my $prefix = 'test_';
# 		print "\nInside subSelectTestCases.......@arrFile\n";
		if ($tab3tstGroup eq 'Wi-Fi Aware/NAN'){
			chomp($dir_to_open=`cd`);
			#$prefix = 'test_';
			if ($tab3tstplan eq 'ALL'){
				$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\functional.txt";
				print("\nTest Script Path ******* $TestScriptPath\n");
			}
			elsif ($tab3tstplan eq 'DataPathStressTest' || $tab3tstplan eq 'DiscoveryStressTest' || $tab3tstplan eq 'InfraAssociationStressTest' || $tab3tstplan eq 'MessagesStressTest'){
				$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\" . $tab3tstplan . "." . "py";
				print("\nTest Script Path ******* $TestScriptPath\n");
			}
			elsif ($tab3tstplan eq 'LatencyTest' || $tab3tstplan eq 'ThroughputTest'){
				$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\" . $tab3tstplan . "." . "py";
				print("\nTest Script Path ******* $TestScriptPath\n");
			}
			else{
				$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\aware\\functional\\" . $tab3tstplan . "." . "py";
				print("\nTest Script Path ******* $TestScriptPath\n");
			}
			open(FILE,"$TestScriptPath");
				while(<FILE>){
				chomp($_);
				#print("\nAttachTest....$_");
				if($_=~/def\s+test\_(.*)\(/){
					$testName=$1;
					print("\nTestName........$testName");
					$arrFile[$i]=$prefix.$testName;
					$i++;
					}
					#close(FILE)
				}
				#print("\nAttachtest.....@arrFile");
			close(FILE)
		}
		elsif ($tab3tstGroup eq 'Wi-Fi Aware/RTT'){
			$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\rtt\\functional\\" . $tab3tstplan . "." . "py";
			print("\nTest Script Path ******* $TestScriptPath\n");
			open(FILE,"$TestScriptPath");
				while(<FILE>){
				chomp($_);
				#print("\nAttachTest....$_");
				if($_=~/def\s+test\_(.*)\(/){
					$testName=$1;
					print("\nTestName........$testName");
					$arrFile[$i]=$prefix.$testName;
					$i++;
					}
					#close(FILE)
				}
				print("\nAttachtest.....@arrFile");
			close(FILE)
		}
		elsif ($tab3tstGroup eq 'WLAN-Sanity'){
			$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\Sanity\\" . $tab3tstplan . "." . "py";
			print("\nTest Script Path ******* $TestScriptPath\n");
			open(FILE,"$TestScriptPath");
				while(<FILE>){
				chomp($_);
				#print("\WLAAN Sanity....$_");
				if($_=~/def\s+test\_(.*)\(/){
					$testName=$1;
					print("\nTestName........$testName");
					$arrFile[$i]=$prefix.$testName;
					$i++;
					}
					#close(FILE)
				}
				print("\nWLAN Sanity.....@arrFile");
			close(FILE)
		}
		elsif ($tab3tstGroup eq 'SAP-ACS'){
			$TestScriptPath = "$dir_to_open\\acts\\tests\\google\\wifi\\SAP\\" . $tab3tstplan . "." . "py";
			print("\nTest Script Path ******* $TestScriptPath\n");
			open(FILE,"$TestScriptPath");
				while(<FILE>){
				chomp($_);
				if($_=~/def\s+test\_(.*)\(/){
					$testName=$1;
					print("\nTestName........$testName");
					$arrFile[$i]=$prefix.$testName;
					$i++;
					}
					#close(FILE)
				}
				print("SAP-ACS.....@arrFile");
			close(FILE)
		}
		$listAvailableTest->delete('0','end');
		$Tab3TstPlan->delete('0','end');
		$listAvailableTest->insert('end',@arrFile);
		@arrFile=();
		$listAvailableTest->insert('end',@arrFile);

}
###################################################################################
# Function Name : subACTsSetup
# Description	: Configure the SL4A/ACTs Setup Config
# Created by 	: Imran Ansari
#####################################################################################
sub subACTsSetup{
	$actsGroup=$tstGroup;
	$actsPlan=$tstPlan;
	$actsControlIP=$entControlIP->get();
	$actsADBDevice=$entDeviceID->get();
	$actsPath=$actsPath;
	$actsLog=$logPath;
	$txtTestResult->Insert("SL4A/ACTS Setup configuration is in progress....\n\n");
	$txtTestResult->update;
	MDLACTSSetup::subSL4AACTSSetup($txtTestResult,$actsGroup,$actsPlan,$actsControlIP,$actsADBDevice,$actsPath,$actsLog,$dir_to_open);
}
###################################################################################
# Function Name : subExecuteTest
# Description	: Execute the Test Cases Selected
# Created by 	: Imran Ansari
#####################################################################################
sub subExecuteTest{
	$executeGroup=$tab3tstGroup;
	$executePlan=$tab3tstplan;
	@ExeTestList=$listSelectedTest->get('0','end');
	$txtTestResult->Insert("Test Execution started for \t:\t$executePlan Feature\n\n");
	$txtTestResult->update;
	$txtTestResult->Insert("Test Cases Selected for Execution @ExeTestList\n\n");
	$txtTestResult->update;
	$frametab3->Busy(-recurse => 1);
	if($executeGroup eq 'Wi-Fi Aware/NAN'){
		print ("Wi-Fi Aware/NAN Test Features started****************$executePlan\n");
		$ResultPath = $dir_to_open . "\\Results\\NAN\\". $executePlan;
		@created = make_path($ResultPath);
		print("\nResult Path ******* $ResultPath\n");
		if($executePlan eq 'ALL'){
			MDLTestExecution::subTestExecution($txtTestResult,$executeGroup,$executePlan,@ExeTestList,$dir_to_open);
		}
		else{
			print("\n...Windows will be in Busy State\n........");
			#$window->Busy;
			MDLTestExecution::subTestExecution($txtTestResult,$executeGroup,$executePlan,$dir_to_open,@ExeTestList); 
		}
	}
	elsif($executeGroup eq 'Wi-Fi Aware/RTT'){
		print ("Wi-Fi Aware/RTT Test Features started****************$executePlan\n");
		$ResultPath = $dir_to_open . "\\Results\\RTT\\". $executePlan;
		@created = make_path($ResultPath);
		print("\nResult Path ******* $ResultPath\n");
		print("\n...Windows will be in Busy State\n........");
		#$window->Busy;
		MDLTestExecution::subTestExecution($txtTestResult,$executeGroup,$executePlan,$dir_to_open,@ExeTestList); 
	}
	elsif($executeGroup eq 'WLAN-Sanity'){
		print ("WLAN-Sanity Test Features started****************$executePlan\n");
		$ResultPath = $dir_to_open . "\\Results\\Sanity\\". $executePlan;
		@created = make_path($ResultPath);
		print("\nResult Path ******* $ResultPath\n");
		print("\n...Windows will be in Busy State\n........");
		#$window->Busy;
		MDLTestExecution::subTestExecution($txtTestResult,$executeGroup,$executePlan,$dir_to_open,@ExeTestList); 
	}
	elsif($executeGroup eq 'SAP-ACS'){
		print ("SAP-ACS Test Features started****************$executePlan\n");
		$ResultPath = $dir_to_open . "\\Results\\SAP\\". $executePlan;
		@created = make_path($ResultPath);
		print("\nResult Path ******* $ResultPath\n");
		print("\n...Windows will be in Busy State\n........");
		#$window->Busy;
		MDLTestExecution::subTestExecution($txtTestResult,$executeGroup,$executePlan,$dir_to_open,@ExeTestList); 
	}
	#$window->Unbusy;
	$frametab3->Unbusy;
	print("\n...Windows will be in UnBusy State\n........");
}
###################################################################################
# Function Name : subShowResultTst
# Description	: Display the Result in Listbox
# Created by 	: Imran Ansari
#####################################################################################
sub subShowResultTst{
	$btnResult = MainWindow->new;
	$btnResult->title("QIPL CST Test Result Window");
	$image = "5.ico";  # 32x32 GIF or BMP
	$icon = $btnResult->Photo(-file => $image);
	#$btnResult->idletasks;              # this line is crucial
	$btnResult->iconimage($icon);
	# $window->configure(-background=>'#EBDDE2');
	$btnResult->configure(-background=>'white');
	$btnResult->geometry( "600x500" );#x/y
	# $window->geometry( "700x500" );#x/y
	$btnResult->resizable(0,0);
	#$btnResult->grab;
	#$btnResult->Label(-foreground => '#2B60DE',-font => "Arial 18 bold",-background => 'white',-foreground => '#0040ff', -text => "QIPL WLAN CST!!!!")->place(-x=>5,-y=>100);
	$ResultNote = $btnResult->NoteBook(-font => "Arial 12 bold")->place(-x=>5,-y=>10);
	$tab1 = $ResultNote->add( "Sheet 1", -label=>"QIPL CST Test Result Summary",-raisecmd=>[\&SetResultTab, 1] );
	$resultframetab = $tab1->Frame(-background => 'white',-width => 590, -height => 440)->pack;
my $frmresultinfo = $resultframetab->LabFrame(-label=>'Test Group & Test Plan Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 570,-height => 70)->place(-x=> 5,-y=> 3);
	$frmresultinfo->Label(-font=>'Arial 10',-background => 'white',-text => "Test Group:")->place(-x=>40,-y=>10);
	$TabResultGroup = $frmresultinfo->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tabarrresultgroup)->place(-x=>140,-y=>10);
 	$TabResultGroup->insert("end", @tabArrResultGroup);
	$TabResultGroup->configure(-command=>\&subSelectResultGroup);
	$tabresulttstplan = 'Select';
    $frmresultinfo->Label(-font=>'Arial 10',-background => 'white',-text => "Test Plan:")->place(-x=>40,-y=>30);
	$TabResultTstPlan = $frmresultinfo->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tabresulttstplan)->place(-x=>140,-y=>30);
	$TabResultTstPlan->configure(-command=>\&subShowTestPlan);
my $frmtestresult = $resultframetab->LabFrame(-label=>'Test Result Summary Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 570,-height => 265)->place(-x=> 5,-y=> 119);
	$listAvailableResult=$frmtestresult->Scrolled('Listbox',-width=>90,-height=>17,-scrollbars=>'e',-foreground=>'#0000FF',-background => 'white',-font => "Arial 8 bold")->place(-x=>4,-y=>5);
	$ResultShow = $resultframetab->Button(-text=>"Upload",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Blue',-activeforeground => 'white',-padx => 12,-pady => 1,-font=>"Arial 10 bold",-command=>sub {$btnResult->destroy})->place(-x=> 100,-y=> 410);
	$ResultShow = $resultframetab->Button(-text=>"Display",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'DarkGreen',-activeforeground => 'white',-padx => 12,-pady => 1,-font=>"Arial 10 bold",-command=>\&subDisplayResult)->place(-x=> 250,-y=> 410);
	$ResultQuit = $resultframetab->Button(-text=>"Close",-padx => 12,-pady => 1,-font=>"Arial 10 bold",-foreground=>'#15317E',-background => 'Light Sky Blue',-activebackground => 'Tomato',-activeforeground => 'white',-command=>sub {$btnResult->destroy})->place(-x=> 400,-y=> 410);
}
###################################################################################
# Function Name : subSelectResultGroup
# Description	: Select the Test Group to show the Result
# Created by 	: Imran Ansari
#####################################################################################
sub subSelectResultGroup{
	@ResultTestPlan = ();
	if ($tabarrresultgroup eq 'Wi-Fi Aware/NAN'){
		print "magya\n";
		chomp($dir_to_open=`cd`);
		print("$dir_to_open\n");
		opendir(DIR,"$dir_to_open\\Results\\NAN");
		@dir_contents= readdir(DIR);
		closedir(DIR);
		my $i=0;
		foreach $file (@dir_contents){
		if(!(($file eq ".") || ($file eq ".."))){
			$ResultTestPlan[$i]=$file;
			$i++
			}
		}
	}
	elsif ($tabarrresultgroup eq 'Wi-Fi Aware/RTT'){
		print "magya\n";
		chomp($dir_to_open=`cd`);
		print("$dir_to_open\n");
		opendir(DIR,"$dir_to_open\\Results\\RTT");
		@dir_contents= readdir(DIR);
		closedir(DIR);
		my $i=0;
		foreach $file (@dir_contents){
		if(!(($file eq ".") || ($file eq ".."))){
			$ResultTestPlan[$i]=$file;
			$i++
			}
		}
	}
	elsif ($tabarrresultgroup eq 'WLAN-Sanity'){
		print "magya\n";
		chomp($dir_to_open=`cd`);
		print("$dir_to_open\n");
		opendir(DIR,"$dir_to_open\\Results\\Sanity");
		@dir_contents= readdir(DIR);
		closedir(DIR);
		my $i=0;
		foreach $file (@dir_contents){
		if(!(($file eq ".") || ($file eq ".."))){
			$ResultTestPlan[$i]=$file;
			$i++
			}
		}
	}
	print "@ResultTestPlan\n";	
	$TabResultTstPlan->insert("end", @ResultTestPlan);
	@ResultTestPlan = ();
}
###################################################################################
# Function Name : subShowTestPlan
# Description	: Select the Test Group to show the Result
# Created by 	: Imran Ansari
#####################################################################################
sub subShowTestPlan{
	@TestResult = ();
	print("TestPlan :: $tabresulttstplan\n");
	chomp($dir_to_open=`cd`);
	if($tabarrresultgroup eq 'Wi-Fi Aware/NAN'){
		opendir(DIR,"$dir_to_open\\Results\\NAN\\$tabresulttstplan");
	}
	elsif($tabarrresultgroup eq 'Wi-Fi Aware/RTT'){
		opendir(DIR,"$dir_to_open\\Results\\RTT\\$tabresulttstplan");
	}
	elsif($tabarrresultgroup eq 'WLAN-Sanity'){
		opendir(DIR,"$dir_to_open\\Results\\Sanity\\$tabresulttstplan");
	}
	@dir_contents= readdir(DIR);
	closedir(DIR);
	my $i=0;
	foreach $file (@dir_contents){
		if(!(($file eq ".") || ($file eq ".."))){
			$TestResult[$i]=$file;
			$i++
			}
		}
		$listAvailableResult->delete('0','end');
		$listAvailableResult->insert('end',@TestResult);
		@TestResult = ();
		@dir_contents = ();
}
#####################################################################################
# Function Name : subDisplayResult
# Description	: Open Selected Test Result from list
# Called By		: Imran Ansari
#####################################################################################
sub subDisplayResult{
	my $i;
	if (defined($listAvailableResult->curselection)){
		foreach $i ($listAvailableResult->curselection){
			$TestResultName=$listAvailableResult->get($i);
			print("TestResultName :: $TestResultName\n");
			chomp($dir_to_open=`cd`);
			print "DirectoryResult" . $dir_to_open."\n";
			print("TestGroup ::::: $tabarrresultgroup\n");
			print("TestPlan ::::::: $tabresulttstplan\n");
			if ($tabarrresultgroup eq 'Wi-Fi Aware/NAN'){
				$CmdReport = "\"c:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\"" . " ". "$dir_to_open\\Results\\NAN\\" . $tabresulttstplan . "\\" . $TestResultName;
			}
			elsif ($tabarrresultgroup eq 'Wi-Fi Aware/RTT'){
				$CmdReport = "\"c:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\"" . " ". "$dir_to_open\\Results\\RTT\\" . $tabresulttstplan . "\\" . $TestResultName;
			}
			elsif ($tabarrresultgroup eq 'WLAN-Sanity'){
				$CmdReport = "\"c:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\"" . " ". "$dir_to_open\\Results\\Sanity\\" . $tabresulttstplan . "\\" . $TestResultName;
			}
			#my $CmdReport = "\"c:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\"" . " ". "$dir_to_open\\Results\\NAN\\AttachTest\\$TestResultName";
			#my $CmdReport = "start $TestResultName";
			print "CmdReport" . $CmdReport."\n";
			my $responsereport = open(ReportCmd, "$CmdReport |");
			print "ResponseReport" . $responsereport;
			close(ReportCmd);
		}
		close(ReportCmd);
	}
	else{
		$ResultNote->messageBox(-title=>"QIPL CST Automation",-icon=>"info",-message=>"Please select a Test Result from Available Test Results!!!!!!");
	}
	close(ReportCmd);
	$tabarrresultgroup = $tabArrResultGroup[0];
	$tabresulttstplan = 'Select';
	$listAvailableResult->delete('0','end');
	@TestResult = ();
	@dir_contents = ();
}
#####################################################################################
# Function Name : subCreateTst
# Description	: Create the different tests for each feature
# Created by 	: Imran Ansari
#####################################################################################
sub  subCreateTst{
		$argDUTTestPlan=$tstplan;
		$argDUTTestGroup=$tstgroup;
		$argDUTTestESSID=$entSTASSID->get();
		$argDUTTestChannel=$entSTAChannel->get();
		$argDUTTestSec=$dutsec;
		$argDUTTestKey=$entNetworkKey->get();
		$argDUTTestAuth=$dutauth;
		$argDUTWirelessMode=$dot11band;
		$argDUTChannelWidth=$dot11width;
			$txtTestResult->Insert("Test Plan \t:$argDUTTestPlan\n");
			$txtTestResult->update;
			$txtTestResult->Insert("Test Group \t:$argDUTTestGroup\n");
			$txtTestResult->update;
			$txtTestResult->Insert("\nDUT_CONFIG_PARAMETER_START\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_ESSID \t\t:$argDUTTestESSID\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Channel \t\t:$argDUTTestChannel\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Security \t\t:$argDUTTestSec\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Key \t\t\t:$argDUTTestKey\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Auth \t\t:$argDUTTestAuth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Mode \t\t:$argDUTWirelessMode\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_Width \t\t:$argDUTChannelWidth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("DUT_CONFIG_PARAMETER_END\n\n");
			$txtTestResult->update;
		if($argDUTTestPlan eq 'STA-IOT'){
			$argREFAPTestESSID=$argDUTTestESSID;
			$argREFAPTestChannel=$argDUTTestChannel;
			$argREFAPTestSec=$argDUTTestSec;
			$argREFAPTestKey=$argDUTTestKey;
			$argREFAPTestAuth=$argDUTTestAuth;
			$argREFAPWirelessMode=$argDUTWirelessMode;
			$argREFAPChannelWidth=$argDUTChannelWidth;
			$txtTestResult->Insert("REF_AP_CONFIG_PARAMETER_START\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_ESSID \t\t:$argREFAPTestESSID\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Channel \t\t:$argREFAPTestChannel\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Security \t\t:$argREFAPTestSec\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Key \t\t:$argREFAPTestKey\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Auth \t\t:$argREFAPTestAuth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Mode \t\t:$argREFAPWirelessMode\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_Width \t\t:$argREFAPChannelWidth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_AP_CONFIG_PARAMETER_END\n\n");
			$txtTestResult->update;
		}
		else{
			$argREFSTATestESSID=$argDUTTestESSID;
			$argREFSTATestChannel=$argDUTTestChannel;
			$argREFSTATestSec=$argDUTTestSec;
			$argREFSTATestKey=$argDUTTestKey;
			$argREFSTATestAuth=$argDUTTestAuth;
			$argREFSTAWirelessMode=$argDUTWirelessMode;
			$argREFSTAChannelWidth=$argDUTChannelWidth;
			$txtTestResult->Insert("REF_STA_CONFIG_PARAMETER_START\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_ESSID \t\t:$argREFSTATestESSID\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Channel \t\t:$argREFSTATestChannel\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Security \t\t:$argREFSTATestSec\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Key \t\t:$argREFSTATestKey\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Auth \t\t:$argREFSTATestAuth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Mode \t\t:$argREFSTAWirelessMode\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_Width \t\t:$argREFSTAChannelWidth\n");
			$txtTestResult->update;
			$txtTestResult->Insert("REF_STA_CONFIG_PARAMETER_END\n\n");
			$txtTestResult->update;
		}



# 		($msg,$ctrl)=&subCheckValidation();

# 	if($msg ne ''){
# 		$winRFIDTst->messageBox(-title=>"RFID Configuration",-icon=>"info",-message=>$msg);
# 		$ctrl->focus;
# 	}
# 	else{
		#&subRFIDCreation("$dir_to_open\\TestCase",$FileName,$argTestName,$argRFIDIPAddr,$argAPSSID,$argAPChannel,$argAPSec,$argAPKey,$argAPKeyIndex,$argAPAuth,$argAPBand,$argAP8021x,$argRFIDSSID,$argRFIDChannel,$argRFIDSec,$argRFIDKey,$argRFIDKeyIndex,$argRFIDAuth,$argRFIDBand,$argRFID8021x);
		$frametab1->messageBox(-title=>"IOT Automation Test",-icon=>"question",-message=>"Test Case Saved in Testplan.xml.");
		#&subListTestCase;
		$Index=&subFindTestNameInList($argTestName);
		$btnAdd->configure(-state=>'normal');
		$entTestName->configure(-state=>'normal');
		$entRFIDIPAddr->configure(-state=>'normal');
		$entAPKey->configure(-state=>'normal');
		$entRFIDKey->configure(-state=>'normal');
		$entAPKey->delete('0','end');
		$entRFIDKey->delete('0','end');
# 		$entUName->configure(-state=>'normal');
# 		$entPwd->configure(-state=>'normal');
# 		$entFName->configure(-state=>'normal');
# 		$optFTP->configure(-state=>'disable');
		$entTestName->focus;
}
#####################################################################################
# Function Name : subOSType
# Description	: Changing the Interface and Adapter name
# Created by 	: Imran Ansari
#####################################################################################
sub subOSType{
			if($ostype eq "Windows"){
						$interfacename='AR923X Wireless Network Adapter';
						$entInterface->configure(-textvariable=>\$interfacename);
			}
			elsif($ostype eq "Linux"){
						$interfacename='wlan50';
						$entInterface->configure(-textvariable=>\$interfacename);
			}
			elsif($ostype eq "OSX"){
						$interfacename='en1';
						$entInterface->configure(-textvariable=>\$interfacename);
			}
}
#####################################################################################
# Function Name : subAddDevices
# Description	: Save values in .txt file
# Created by 	: Imran Ansari
#####################################################################################
sub  subAddDevices{
		$argVendorName=$vendorname;
		$argModelNumber=$entDeviceModel->get();
		$FileName=$argVendorName . _ .$argModelNumber .".txt";
		$argIPAddress=$entIPAddress->get();
		$argConfigTool=$configtool;
		print "File Name----$FileName\n";
# 		($msg,$ctrl)=&subCheckValidation();

# 	if($msg ne ''){
# 		$winSYSTst->messageBox(-title=>"FTP Configuration",-icon=>"info",-message=>$msg);
# 		$ctrl->focus;
# 	}
# 	else{
		$txtTestResult->Insert("Ref APs details is in progress....\n\n");
		$txtTestResult->update;
		$txtTestResult->Insert("AP_Vendor_Name \t\t:$argVendorName\n");
		$txtTestResult->update;
		$txtTestResult->Insert("AP_Model_Number \t:$argModelNumber\n");
		$txtTestResult->update;
		$txtTestResult->Insert("AP_IP_Address \t\t:$argIPAddress\n");
		$txtTestResult->update;
		$txtTestResult->Insert("AP_Config_Tool \t\t:$argConfigTool\n\n");
		$txtTestResult->update;
		$tstFileCreater->subIOTAPList("$dir_to_open\\Util\\IOTDEVICES",$FileName,$argVendorName,$argModelNumber,$argIPAddress,$argConfigTool);
		$frametab1->messageBox(-title=>"IOT AP LIST",-icon=>"question",-message=>"IOT AP Saved in TestBed.xml!!!!!!");
		#&subListIOTAP;
# 		$gCurrentIndex=&subFindTestNameInList($argServerIPAddr);
		$btnAdd->configure(-state=>'normal');
		$TstVendorName->configure(-state=>'normal');
		$entDeviceModel->configure(-state=>'normal');
		$entIPAddress->configure(-state=>'normal');
		$TstBedConfigTool->configure(-state=>'normal');
		$entIPAddress->focus;
}
#####################################################################################
# Function Name : subListIOTAP
# Description	: Find all IOT AP used for Testing
# Called By		: Self
# Argument List : None
# Returning Arg : None
#####################################################################################
sub subListIOTAP{
	my $i=0;
	@ChummaFile=();
	opendir(DIR,"$dir_to_open\\Util\\IOTDEVICES") or $listRes ="Cannot open directory !";
	if($listRes ne ''){
		$listRes='';
		$frametab1->messageBox(-title=>"Chumma IOT AP",-icon=>"info",-message=>"Cannot open directory !");

	}
	else{
		@dir_contents= readdir(DIR);
		closedir(DIR);

		foreach $file (@dir_contents){
			if(!(($file eq ".") || ($file eq ".."))){

	 			open(FILE,"$dir_to_open\\Util\\IOTDEVICES\\$file") or $listRes="Cannot open file !";
	 				if($listRes eq ''){
		 				while(<FILE>){
		 					if($_=~/START_IOT_AP_List_(.*)/){$argServerIPAddr=$1;}
		 				}
		 				$ChummaFile[$i]=$argServerIPAddr;
		 				$i++;
	 				}
	 				else{
						$listRes='';
						$frametab1->messageBox(-title=>"IOT AP LIST!!!!!",-icon=>"info",-message=>"Cannot find selected test!!!!!");
					}
					close(FILE);
	 			}

		}
		$fileno=@ChummaFile;
		if($fileno eq 0){
			$arrFile[0]=" ";
			$listDeviceList->delete(0,$i);
			$listDeviceList->insert(0,@ChummaFile);
			$listDeviceList->configure( -state=>'disabled');
		}
		else{
			$listDeviceList->configure(-state=>'normal');
			$listDeviceList->delete(0,$i);
			$listDeviceList->insert(0,@ChummaFile);
		}
	}
}
#####################################################################################
# Function Name : subListTestCase
# Description	: List all the Test Case according to Selected Test case
# Created By	: Imran Ansari
#####################################################################################
sub subListTestCase{
		@arrFile1=("STA_IOT_1","STA_IOT_2","STA_IOT_3","STA_IOT_4","STA_IOT_5","STA_IOT_6","STA_IOT_7","STA_IOT_8","STA_IOT_9","STA_IOT_10","STA_IOT_11");
# 		print "@arrFile\n";
		$listTestCase->delete('0','end');
		$listTestCase->insert('end',@arrFile1);
		@arrFile1=();

}
#####################################################################################
# Function Name : subNetworkKey
# Description	: Changing the Network key and Passpharse
# Created by 	: Imran Ansari
#####################################################################################
sub subNetworkKey{
			if(($dutsec eq "None")||($dutsec eq "Select")){
			$entNetworkKey->configure(-state=>'normal');
			$dutauth='Open';
	 		$optSTAAuth->configure(-textvariable=>\$dutauth);
			$optSTASec->configure(-textvariable=>\$dutsec);
			$lblNetworkKey->configure(-text=>"Network Key:");
			$entNetworkKey->configure(-state=>'disable');
			$optSTAAuth->configure(-state=>'disable');
		}
		elsif(($dutsec eq "WEP-40")||($dutsec eq "WEP-104")){
			$lblNetworkKey->configure(-text=>"Network Key:");
			$entNetworkKey->configure(-state=>'normal');
			$optSTAAuth->configure(-textvariable=>\$dutauth);
			$optSTASec->configure(-textvariable=>\$dutsec);
			$optSTAAuth->configure(-state=>'normal');
		}
		elsif(($dutsec eq "WPA-PSK")||($dutsec eq "WPA2-PSK")){
			$lblNetworkKey->configure(-text=>"Pass Phrase:");
	 		$entNetworkKey->configure(-state=>'normal');
	 		$optSTAAuth->configure(-textvariable=>\$dutauth);
			$optSTASec->configure(-textvariable=>\$dutsec);
	 		$optSTAAuth->configure(-state=>'disable');
 		}
}
#####################################################################################
# Description	: Display the Configuration Parameters of a Test in Text Box
# Called By	: Self
# Argument List : None
# Returning Arg : None
#####################################################################################
sub subPrintDetails
{
	$txtDetails->configure(-state=>'normal');


	$optSubTstPlan->configure(-variable=>\$subtstplan);

	print TEXT "802.11 Parameters Details\n\n";
			print TEXT "SSID 			: Perf_WEP64\n";
			print TEXT "PR_CHANNEL		: 36\n";
			print TEXT "SC_CHANNEL		: 40\n";
			print TEXT "Wireless Mode		: 11NAHT40Plus\n";
			print TEXT "Security			: WPA-PSK\n";
			print TEXT "Passphrase      		: 1234567890\n";





# 			if(($arrDetail[4] eq "WEP-40")||($arrDetail[4] eq "WEP-104")){
# 				print TEXT "KEY		: $arrDetail[5]\n";
# 				print TEXT "AUTHENTICATION 	: $arrDetail[6]\n";
# 				print TEXT "KEY INDEX	: $arrDetail[7]\n";
# 			}
# 			elsif(($arrDetail[4] eq "WPA-PSK")||($arrDetail[4] eq "WPA2-PSK")){
# 				print TEXT "PASSPHRASE 	: $arrDetail[5]\n";
# 				print TEXT "AUTHENTICATION 	: $arrDetail[6]\n";
# 				print TEXT "KEY INDEX	: $arrDetail[7]\n";
# 			}
# 		 	elsif(($arrDetail[4] eq "WPA")||($arrDetail[4] eq "WPA2")){
# # 				print TEXT "RADIUS KEY 	: $arrDetail[5]\n";
# 				print TEXT "AUTHENTICATION 	: $arrDetail[6]\n";
# 				print TEXT "KEY INDEX	: $arrDetail[7]\n";
# 			}
# 			elsif($arrDetail[4] eq "None"){
# 				print TEXT "AUTHENTICATION 	: $arrDetail[6]\n";
# 				print TEXT "KEY INDEX	: $arrDetail[7]\n";
# 			}
# 			elsif($arrDetail[4] eq "802.1xWEP"){
# 				print TEXT "AUTHENTICATION 	: $arrDetail[6]\n";
# 				print TEXT "KEY INDEX	: $arrDetail[7]\n";
# 			}
# 			print TEXT "802.11 Band	: $arrDetail[8]\n";
# 			print TEXT "802.1x Security	: $arrDetail[9]\n";
# 			print TEXT1 "RFID Details\n\n";
#
# 			print TEXT1 "SSID 		: $arrDetail[10]\n";
# 			print TEXT1 "CHANNEL		: $arrDetail[11]\n";
#
# 			print TEXT1 "SECURITY	: $arrDetail[12]\n";
# 			if(($arrDetail[12] eq "WEP-40")||($arrDetail[12] eq "WEP-104")){
# 				print TEXT1 "KEY		: $arrDetail[13]\n";
# 				print TEXT1 "AUTHENTICATION 	: $arrDetail[14]\n";
# 				print TEXT1 "KEY INDEX	: $arrDetail[15]\n";
# 			}
# 			elsif(($arrDetail[12] eq "WPA-PSK")||($arrDetail[12] eq "WPA2-PSK")){
# 				print TEXT1 "PASSPHRASE 	: $arrDetail[13]\n";
# 				print TEXT1 "AUTHENTICATION 	: $arrDetail[14]\n";
# 				print TEXT1 "KEY INDEX	: $arrDetail[15]\n";
# 			}
# 			elsif(($arrDetail[12] eq "WPA")||($arrDetail[12] eq "WPA2")){
# # 				print TEXT1 "RADIUS KEY 	: $arrDetail[13]\n";
# 				print TEXT1 "AUTHENTICATION 	: $arrDetail[14]\n";
# 				print TEXT1 "KEY INDEX	: $arrDetail[15]\n";
# 			}
# 			elsif($arrDetail[12] eq "None"){
# 				print TEXT1 "AUTHENTICATION 	: $arrDetail[14]\n";
# 				print TEXT1 "KEY INDEX	: $arrDetail[15]\n";
# 			}
# 			elsif($arrDetail[12] eq "802.1xWEP"){
# 				print TEXT1 "AUTHENTICATION 	: $arrDetail[14]\n";
# 				print TEXT1 "KEY INDEX	: $arrDetail[15]\n";
# 			}
# 			print TEXT1 "802.11 Band	: $arrDetail[16]\n";
# 			print TEXT1 "802.1x Security	: $arrDetail[17]\n";
		$txtDetails->configure(-state=>'disabled');


}
#####################################################################################
# Function Name : subAddAll
# Description	: Add All test from Available list to Selected list
# Called By		: Imran Ansari
#####################################################################################
sub subAddAll
{
	my $i=0;
	@arrBatch=();


		@arrmultrfid=$listAvailableTest->get('0','end');
		$listSelectedTest->insert('end',@arrmultrfid);
		for(my $i=0;$i<=$#arrmultrfid;$i++){
			$TestList[$j]={"Type"=>$tsttype,"Test"=>$arrmultrfid[$i]};
			$j++;
		}


}
#####################################################################################
# Function Name : subRemoveAll
# Description	: Remove All test from Selected list
# Called By		: Imran Ansari
#####################################################################################
sub subRemoveAll{
	$listSelectedTest->delete('0','end');
	$testno=0;
	@TestList=();

}
#####################################################################################
# Function Name : subMoveSelected
# Description	: Move Selected Test Case from Available List to Selected List
# Called By		: Imran Ansari
#####################################################################################

sub subMoveSelected
{
	my $i,$j;
	if (defined($listAvailableTest->curselection)){
		foreach $i ($listAvailableTest->curselection){
			$Test_Name=$listAvailableTest->get($i);
			$listSelectedTest->insert('end',$Test_Name);
			$TestList[$j]={"Type"=>$tsttype,"Test"=>$Test_Name};
			$j++;
	  	}
	}
	else{
		$frame2->messageBox(-title=>"CBU Automation",-icon=>"info",-message=>"Please select a test from Available Test List.");
	}
}
#####################################################################################
# Function Name : subRemoveSelected
# Description	: Remove Selected Test Case from Selected Test List
# Called By		: Imran Ansari
#####################################################################################

sub subRemoveSelected
{
	my $i;
	my $ele=0;
	if (defined($listSelectedTest->curselection)){
		foreach $i ($listSelectedTest->curselection){
			 $testName=$listSelectedTest->get($i);
			 $listSelectedTest->delete($i);
		}
		while($ele < $#TestList){
			if($TestList[$ele]->{"Test"} eq $testName){
				delete $TestList[$ele];
			}
		$ele++;
		}
	}
	else{
		$frame2->messageBox(-title=>"CBU Automation",-icon=>"info",-message=>"Please select a test from Selected Test List");
	}
}
#####################################################################################
# Function Name	: SetCurrentTab
# Description	: Function to Determine which Tab among Port Settings and Test execution is Clicked.
# Created by    : Imran Ansari
#####################################################################################
sub SetCurrentTab
{
	$curTabNo = $_[0];
}
#####################################################################################
# Function Name	: SetResultTab
# Description	: Function to Determine which Tab among Port Settings and Test execution is Clicked.
# Created by    : Imran Ansari
#####################################################################################
sub SetResultTab
{
	$curTabNo1 = $_[0];
}
#####################################################################################
# Function Name	: SetTab
# Description	: Function to Determine which Tab among Port Settings and Test execution is Clicked.
# Created by    : Imran Ansari
#####################################################################################
sub SetTab
{
	$curTabNo = $_[0];
}
#####################################################################################
# Description	: Close the Single Test Window
# Called By	: Self
# Argument List : None
# Returning Arg : None
#####################################################################################
sub subCloseWinRunTst{
	$window->destroy();
}
#####################################################################################
# Description	: Close the Single Test Window
# Called By	: Self
# Argument List : None
# Returning Arg : None
#####################################################################################
sub subCloseWinResult{
	$btnResult->destroy();
}
#####################################################################################
# Function Name : subHelp
# Description	: Open the Help file
# Created by 	: Imran Ansari
#####################################################################################
sub subHelp{
	my $Cmd =  "HH.exe \"$dir_to_open\\Files\\System.chm\"";
	my $pid1 = open(chmCMD, "$Cmd |") or $showRes="Can't execute command on windows:$!";
	if($showRes ne ''){
		$showRes='';
		$window->messageBox(-title=>"QIPL CST Automation Tool",-icon=>"info",-message=>"Cannot open result file.");
	}
}
#####################################################################################
# Function Name : subAbout
# Description	: Create a About QIPL CST Automation Tool GUI
# Created by 	: Imran Ansari
#####################################################################################
sub subAbout{
	$winAbout=$window->Toplevel(-title => "About QIPL CST Automation Tool");
	$winAbout->geometry( "520x380" );#x/y
	$winAbout->resizable(0,0);
	$winAbout->grab;
	$message1="QIPL CST Automation Tool";
	$message2="QIPL CST Automation Tool 1.0 Release \nCopyright (C) Qualcomm India Private Limited.,2018";
	$message3="This Release uses Following Software:\n\nActivePerl-5.26.1-MSWin32-x86-122208.msi\nWindows 10\nimran.\@qti.qualcomm.com\n";
	$winAbout->Label(-text=>$message1,-height=>2,-width=>37,-font => "Times 15 bold italic",-foreground=>'#DC143C',-relief=>'sunken')->place(-x=>12,-y=>10);
	$winAbout->Label(-text=>$message2,-anchor=>"nw",-justify=>"left",-height=>2,-width=>58,-font => "Times 10 italic",-relief=>'sunken')->place(-x=>12,-y=>70);
	$winAbout->Label(-text=>$message3,-anchor=>"nw",-justify=>"left",-height=>8,-width=>58,-font => "Times 10 italic",-relief=>'sunken')->place(-x=>12,-y=>125);
	$winAbout->StyledButton(-text=>"OK",-shape => $shape,-style => $style,-angle => $angle,-background => $color,
							-padx => 35,-pady => 5,-font=>"Arial 8 bold",-command=>sub {$winAbout->destroy})->place(-x=>335,-y=>258)

}
#####################################################################################
MainLoop();
#End of Module
#####################################################################################
