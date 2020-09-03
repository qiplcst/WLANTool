#####################################################################################
# Module Name   : MDLACTSSetup
# Description	: Module for configuring SL4A/ACTS Scripts & all required Files.
# Called By		: QIPLCSTTool Main Module
# Argument List : Test Group, Test Plan, ACT Path & Log File Path
# Returning Arg : None
#####################################################################################
#####################################################################################
#!/usr/bin/perl
#####################################################################################
package MDLACTSSetup;
sub subSL4AACTSSetup
{
  my $win = shift;
	my $testgroup = shift;
	my $testplan = shift;
	my $controlip = shift;
	my $deviceid = shift;
	my $actspath = shift;
	my $actslog = shift;
    my $location = shift;
	$win->Insert("SL4A\/ACTS Test Group \t::\t $testgroup\n");
	$win->update;
	$win->Insert("SL4A\/ACTS Test Plan \t::\t $testplan\n");
	$win->update;
	$win->Insert("SL4A\/ACTS Control IP \t::\t $controlip\n");
	$win->update;
	$win->Insert("SL4A\/ACTS DUT ID     \t::\t $deviceid\n");
	$win->update;
	$win->Insert("SL4A\/ACTS Setup Config\t::\t $actspath\n");
	$win->update;
	$win->Insert("SL4A\/ACTS Log Path    \t::\t $actslog\n");
	$win->update;
    $win->Insert("SL4A\/ACTS Setup Location    \t::\t $location\n");
    $win->update;
  @ACTSetuplog = ();
  $ACTPATH = substr($actspath, 11, 25);
  print("\nACTPATH.....$ACTPATH");
  my $setup = "python " . $location . "\\" . "Setup\\" . "ActSetup.py " . "Setup " . $ACTPATH . ' ' . $testgroup . ' ' . $testplan;
  print("\n$setup");
  my $i=0;
  my $adbdevices = open(SETUP, "$setup |");
  while(<SETUP>){
  chomp $_;
  $ACTSetuplog[$i]=$_;
  $win->Insert("$ACTSetuplog[$i]\n");
  $win->update;
  $i++;
  }
  $win->Insert("##################SL4A\/ACTS Test Setup Completed Successfully################\n");
  $win->update;
}
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################
