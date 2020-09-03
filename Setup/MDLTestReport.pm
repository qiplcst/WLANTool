#####################################################################################
# Module Name   : MDLTestReport
# Description	: Module for displaying Report
# Called By		: QIPLCSTTool Main Module
# Argument List : Test Group, Test Plan, ACT Path & Log File Path
# Returning Arg : None
#####################################################################################
#####################################################################################
#!/usr/bin/perl
#####################################################################################
use Tk;
use Tk::JPEG;
use Tk::BrowseEntry;
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
package MDLTestReport;
#@tabArrResultGroup = ('Select','New_Features', 'Wi-Fi Aware/NAN', 'Wi-Fi Aware/RTT','GScan', 'Performance','IOT');
#$tabarrresultgroup = $tabArrResultGroup[0];
sub subShowReport
{
	my $win = shift;
	$win = MainWindow->new;
	$win->title("QIPL CST Test Result Window");
	$image = "5.ico";  # 32x32 GIF or BMP
	$icon = $win->Photo(-file => $image);
	$win->idletasks;              # this line is crucial
	$win->iconimage($icon);
	# $window->configure(-background=>'#EBDDE2');
	$win->configure(-background=>'white');
	$win->geometry( "600x500" );#x/y
	# $window->geometry( "700x500" );#x/y
	$btnResult->resizable(0,0);
	#$btnResult->grab;
	#$btnResult->Label(-foreground => '#2B60DE',-font => "Arial 18 bold",-background => 'white',-foreground => '#0040ff', -text => "QIPL WLAN CST!!!!")->place(-x=>5,-y=>100);
	$ResultNote = $win->NoteBook(-font => "Arial 12 bold")->place(-x=>5,-y=>10);
	$tab1 = $ResultNote->add( "Sheet 1", -label=>"QIPL CST Test Result Summary",-raisecmd=>[\&SetResultTab, 1] );
	$resultframetab = $tab1->Frame(-background => 'white',-width => 590, -height => 440)->pack;
	my $frmresultinfo = $resultframetab->LabFrame(-label=>'Test Group & Test Plan Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 570,-height => 70)->place(-x=> 5,-y=> 3);
	$frmresultinfo->Label(-font=>'Arial 10',-background => 'white',-text => "Test Group:")->place(-x=>40,-y=>10);
	$TabResultGroup = $frmresultinfo->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tabarrresultgroup);
 	$TabResultGroup->insert("end", @tabArrResultGroup);
	$TabResultGroup->place(-x=>140,-y=>10);
    $TabResultGroup->configure(-command=>\&subSelectResultGroup);
	$tab3tstplan = 'Select';
    $frmTestExeConfig->Label(-font=>'Arial 10',-background => 'white',-text => "Test Plan:")->place(-x=>30,-y=>30);
	$Tab3TstPlan = $frmTestExeConfig->BrowseEntry(-style=>'unix',-foreground=>'#15317E',-font=>'Arial 9 bold',-autolimitheight =>'1',-background => 'LightGrey',-variable => \$tab3tstplan);
	$Tab3TstPlan->place(-x=>140,-y=>30);
	$Tab3TstPlan->configure(-command=>\&subSelectTestCases);
	my $frmtestresult = $resultframetab->LabFrame(-label=>'Test Result Summary Details',-background=>'white',-font=>'Arial 10 bold',-labelside => 'acrosstop',-width => 570,-height => 250)->place(-x=> 5,-y=> 120);
}
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################
