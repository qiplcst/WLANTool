#####################################################################################
#!/usr/bin/perl
#####################################################################################
package IOTFileReader;
#####################################################################################
# Description	: List Of Perl Modules Required For This Package
#####################################################################################
use Cwd;
use lib "Util";
#####################################################################################
# Description	: Global Declaration of Variables
#####################################################################################
my $errorText='';
chomp($dir_to_open=`cd`);
#####################################################################################
# Description	: Create reference of its own module
# Argument List : None
# Returning Arg : Reference of its own
#####################################################################################
sub new{
    my $className = shift;
    my $self = {};
    bless($self,$className);
    return $self;
}
#####################################################################################
# Function Name : subReadConfigParam
# Description	: Read configuration parameters from text file
# Argument List : Path of the directory,Name of file,Tye of test 
# Returning Arg : Test parameters
#####################################################################################
sub subReadConfigParam{		
	my $self= shift;
	my $dirPath = shift;
	my $openFile = shift;
	my $trafficName = shift;	
	my $i=0;
	my @apList=();
	my @staList=();
	$errorText='';
	my ($APName,$APIPAddr,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth)='';
	my ($STAName,$STAIPAddr,$tstMode,$STASSID,$STAChannel,$STABeacon,$STARTS,$STAFrag,$STASec,$STAKey,$STAAuth,$STAIndex)='';
	my ($DUTIPAddr,$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$RADIUSIP)='';
	my ($destIPAddr,$PingSize,$PingCount,$upTraffic,$dwnTraffic,$trafficType)='';
	my ($DHCPLeaseTime)='';
	my ($TelnetIPAddr,$TelnetPort,$TelnetUname,$TelnetPw)='';
	my ($POP3Header,$POP3Verbose,$POP3Server,$POP3Port,$POP3Uname,$POP3Pw,$POP3MailIndex)='';
	my ($FTPMode,$FTPType,$FTPServer,$FTPPort,$FTPUname,$FTPPw,$FTPFileSize,$FTPFileName)='';
	my ($HTTPServer,$HTTPPage,$HTTPLogin,$HTTPPort,$HTTPUname,$HTTPPw)='';
	my ($DNSServ1,$DNSServ2)='';
	my ($port)='';
	my ($CountryCode)='';
	my ($SMTPVerbose,$SMTPServer,$SMTPPort,$SMTPUname,$SMTPPw)='';
	my $tcpport='';
	
	open(LIFILE,"$dirPath\\$openFile") or $self->subErrorHandler("Cannot open file $openFile :$!");
	if($errorText ne ''){return;}
	while(<LIFILE>){

		if($_=~/Test_Name\s+:\s+(.*)/){$testName=$1;}
		
		if($trafficName eq "Roam" || $trafficName eq "ADKREG_ROAM"){
			if($_=~/AP(\d+)_Name\s+:\s+(.*)/){
				$sNo=$1;
				$APName=$2;			
			}		
			if($_=~/AP(\d+)_IPAddr\s+:\s+(.*)/){	
				if($sNo==$1){
					$APIPAddr=$2;
					$apList[$i]="$APName->$APIPAddr";
			   		$i++;
				}
			}
		}
		if($_=~/STA(\d+)_Name\s+:\s+(.*)/){
			$sNo=$1;
			$STAName=$2;			
		}
		if($_=~/STA(\d+)_IPAddr\s+:\s+(.*)/){	
			if($sNo==$1){
				$STAIPAddr=$2;
				$staList[$i]="$STAName->$STAIPAddr";
		   		$i++;
			}
		}
		if($_=~/Test_Mode\s+:\s+(.*)/){$tstMode=$1;}
		#-------Read AP PArameters--------#
		if($_=~/AP_SSID\s+:\s+(.*)/){$APSSID=$1;}
		if($_=~/AP_Channel\s+:\s+(.*)/){$APChannel=$1;}
		if($_=~/AP_Beacon\s+:\s+(.*)/){$APBeacon=$1;}
		if($_=~/AP_RTS\s+:\s+(.*)/){$APRTS=$1;}
		if($_=~/AP_Frag\s+:\s+(.*)/){$APFrag=$1;}
		if($_=~/AP_Security\s+:\s+(.*)/){$APSec=$1;}
		if($_=~/AP_Key\s+:\s+(.*)/){$APKey=$1;}
		if($_=~/AP_Auth\s+:\s+(.*)/){$APAuth=$1;}
		if($_=~/AP_KeyIndex\s+:\s+(.*)/){$APIndex=$1;}
		#-------Read STA PArameters--------#
		if($_=~/STA_SSID\s+:\s+(.*)/){$STASSID=$1;}
		if($_=~/STA_Channel\s+:\s+(.*)/){$STAChannel=$1;}
		if($_=~/STA_Beacon\s+:\s+(.*)/){$STABeacon=$1;}
		if($_=~/STA_RTS\s+:\s+(.*)/){$STARTS=$1;}
		if($_=~/STA_Frag\s+:\s+(.*)/){$STAFrag=$1;}
		if($_=~/STA_Security\s+:\s+(.*)/){$STASec=$1;}
		if($_=~/STA_Key\s+:\s+(.*)/){$STAKey=$1;}
		if($_=~/STA_Auth\s+:\s+(.*)/){$STAAuth=$1;}	
		if($_=~/STA_KeyIndex\s+:\s+(.*)/){$STAIndex=$1;}	
		if($_=~/IBSS_SUB_TEST\s+:\s+(.*)/){$subType=$1};
		#-------Read DUT PArameters--------#
		if($_=~/DUT_SSID\s+:\s+(.*)/){$DUTSSID=$1;}
		if($_=~/DUT_Channel\s+:\s+(.*)/){$DUTChannel=$1;}
		if($_=~/DUT_Beacon\s+:\s+(.*)/){$DUTBeacon=$1;}
		if($_=~/DUT_RTS\s+:\s+(.*)/){$DUTRTS=$1;}
		if($_=~/DUT_Frag\s+:\s+(.*)/){$DUTFrag=$1;}
		if($_=~/DUT_Security\s+:\s+(.*)/){$DUTSec=$1;}
		if($_=~/DUT_Key\s+:\s+(.*)/){$DUTKey=$1;}		
		if($_=~/DUT_Auth\s+:\s+(.*)/){$DUTAuth=$1;}
		if($_=~/DUT_KeyIndex\s+:\s+(.*)/){$DUTIndex=$1;}
		if($_=~/DUT_IBSS_Type\s+:\s+(.*)/){$DUTOption=$1;}
		
		if($_=~/RADIUS_IP\s+:\s+(.*)/){$RADIUSIP=$1;}
		#-------Read DHCP Parameters--------#
		if($_=~/Lease_Time\s+:\s+(.*)/){$DHCPLeaseTime=$1;}
		#-------Read Telnet Parameters--------#
		if($_=~/Telnet_Port\s+:\s+(.*)/){$TelnetPort=$1;}
		if($_=~/Telnet_Address\s+:\s+(.*)/){$TelnetIPAddr=$1;}
		if($_=~/Telnet_Uname\s+:\s+(.*)/){$TelnetUname=$1;}
		if($_=~/Telnet_Pw\s+:\s+(.*)/){$TelnetPw=$1;}
		#-------Read POP3 Parameters--------#
		if($_=~/POP3_Header\s+:\s+(.*)/){$POP3Header=$1;}
		if($_=~/POP3_Verbose\s+:\s+(.*)/){$POP3Verbose=$1;}
		if($_=~/POP3_Server\s+:\s+(.*)/){$POP3Server=$1;}
		if($_=~/POP3_Port\s+:\s+(.*)/){$POP3Port=$1;}
		if($_=~/POP3_Uname\s+:\s+(.*)/){$POP3Uname=$1;}
		if($_=~/POP3_Pw\s+:\s+(.*)/){$POP3Pw=$1;}
		if($_=~/POP3_MailIndex\s+:\s+(.*)/){$POP3MailIndex=$1;}
		#-------Read FTP Parameters--------#
		if($_=~/FTP_Mode\s+:\s+(.*)/){$FTPMode=$1;}
		if($_=~/FTP_Type\s+:\s+(.*)/){$FTPType=$1;}
		if($_=~/FTP_Server\s+:\s+(.*)/){$FTPServer=$1;}
		if($_=~/FTP_Port\s+:\s+(.*)/){$FTPPort=$1;}
		if($_=~/FTP_Uname\s+:\s+(.*)/){$FTPUname=$1;}
		if($_=~/FTP_Pw\s+:\s+(.*)/){$FTPPw=$1;}
		if($_=~/FTP_FileSize\s+:\s+(.*)/){$FTPFileSize=$1;}
		if($_=~/FTP_FileName\s+:\s+(.*)/){$FTPFileName=$1;}
		#-------Read HTTP Parameters--------#
		if($_=~/HTTP_Server\s+:\s+(.*)/){$HTTPServer=$1;}
		if($_=~/HTTP_Page\s+:\s+(.*)/){$HTTPPage=$1;}
		if($_=~/HTTP_Login\s+:\s+(.*)/){$HTTPLogin=$1;}
		if($_=~/HTTP_Port\s+:\s+(.*)/){$HTTPPort=$1;}
		if($_=~/HTTP_Uname\s+:\s+(.*)/){$HTTPUname=$1;}
		if($_=~/HTTP_Pw\s+:\s+(.*)/){$HTTPPw=$1;}
		#-------Read DNS Parameters--------#Domain_Name1
		if($_=~/DNS_SER1\s+:\s+(.*)/){$DNSServ1=$1;}
		if($_=~/DNS_SER2\s+:\s+(.*)/){$DNSServ2=$1;}
		#-------Read CountryCode Parameters--------#Domain_Name1
		if($_=~/CountryCode\s+:\s+(.*)/){$CountryCode=$1;}
		#-------Read HTTP Parameters--------#
		if($_=~/SMTP_Verbose\s+:\s+(.*)/){$SMTPVerbose=$1;}
		if($_=~/SMTP_Server\s+:\s+(.*)/){$SMTPServer=$1;}
		if($_=~/SMTP_Port\s+:\s+(.*)/){$SMTPPort=$1;}
		if($_=~/SMTP_Uname\s+:\s+(.*)/){$SMTPUname=$1;}
		if($_=~/SMTP_Pwd\s+:\s+(.*)/){$SMTPPw=$1;}
		if($_=~/TCP_PORT\s+:\s+(.*)/){$port=$1;}	
		if($_=~/UDP_PORT\s+:\s+(.*)/){$port=$1;}	
		if($trafficName eq "Ping"){
			if($_=~/PING_Size\s+:\s+(.*)/){$PingSize=$1;}
			if($_=~/PING_Count\s+:\s+(.*)/){$PingCount=$1;}
		}
		if($trafficName eq "Throughput"){
			if($_=~/UPLOAD_TRAFFIC\s+:\s+(.*)/){$upTraffic=$1;}
			if($_=~/DOWNLOAD_TRAFFIC\s+:\s+(.*)/){$dwnTraffic=$1;}	
			if($_=~/TCP_(.*)/){$trafficType="tcp";}	
			elsif($_=~/UDP_(.*)/){$trafficType="udp";}		
		}
	} 
	close(LIFILE);
	
	if($trafficName eq "Ping"){		
		return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
				$PingSize,$PingCount,$RADIUSIP);
	}
	if($trafficName eq "Throughput"){
		return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
				$trafficType,$upTraffic,$dwnTraffic,$RADIUSIP);
	}
	if($trafficName eq "Roam"){		
		return ($testName,$tstMode,\@apList,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
				$RADIUSIP);
	}
	if($trafficName eq "Negative"){		
		return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
				$RADIUSIP);
	}
	if($trafficName eq "IBSS"){
		return ($testName,$tstMode,\@staList,$STASSID,$STAChannel,$STABeacon,$STARTS,$STAFrag,$STASec,$STAKey,$STAAuth,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,
				$subType,$DUTOption);
	}
	if($trafficName=~/ADKREG_(.*)/){
		if($trafficName=~/ADKREG_ROAM/)	{
			return ($testName,$tstMode,\@apList,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
				$RADIUSIP);
		}	
		elsif($trafficName=~/ADKREG_DHCP/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$DHCPLeaseTime,$RADIUSIP);
		}	
		elsif($trafficName=~/ADKREG_Telnet/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$TelnetPort,$TelnetIPAddr,$TelnetUname,$TelnetPw,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_POP3/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$POP3Header,$POP3Verbose,$POP3Server,$POP3Port,$POP3Uname,$POP3Pw,$POP3MailIndex,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_FTP/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$FTPMode,$FTPType,$FTPServer,$FTPPort,$FTPUname,$FTPPw,$FTPFileSize,$FTPFileName,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_HTTP/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$HTTPServer,$HTTPPage,$HTTPLogin,$HTTPPort,$HTTPUname,$HTTPPw,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_DNS/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$DNSServ1,$DNSServ2,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_SMTP/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,
					$SMTPVerbose,$SMTPServer,$SMTPPort,$SMTPUname,$SMTPPw,$RADIUSIP);
		}
		elsif($trafficName=~/ADKREG_CountryCode/)	{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$CountryCode,$RADIUSIP);
		}
		elsif($trafficName eq "ADKREG_IBSS"){
			return ($testName,$tstMode,\@staList,$STASSID,$STAChannel,$STABeacon,$STARTS,$STAFrag,$STASec,$STAKey,$STAAuth,$STAIndex,
				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$DUTOption);
		}
		else{
			return ($testName,$tstMode,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$RADIUSIP);
			}
	}
# 	if($trafficName eq "OverNight"){		
# 		return ($testName,\@apList,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,
# 					$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,
# 					$destIPAddr,$PingSize,$PingCount,$tstMode,$DUTIPAddr,$RADIUSIP);
# 	}	
	
	return(\@apList,$APSSID,$APChannel,$APBeacon,$APRTS,$APFrag,$APSec,$APKey,$APAuth,$APIndex,
			$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$RADIUSIP);
}
#####################################################################################
# Function Name : subReadRoamConfigParam
# Description	: Read configuration parameters from text file
# Called By		: MdlADKRoam
# Argument List : Path of the directory,Name of file,Tye of test 
# Returning Arg : Test parameters
#####################################################################################

sub subReadRoamConfigParam
{		
	my $self= shift;
	my $dirPath = shift;
	my $openFile = shift;
	my $trafficName = shift;	
	my $i=0;
	my @apArg=();	
	$errorText='';
	$tstMode='';
	$tstName='';
	my ($AP1Name,$AP1IPAddr,$AP1SSID,$AP1Channel,$AP1Sec,$AP1Key,$AP1Auth)='';
	my ($AP2Name,$AP2IPAddr,$AP2SSID,$AP2Channel,$AP2Sec,$AP2Key,$AP2Auth)='';
	my ($AP3Name,$AP3IPAddr,$AP3SSID,$AP3Channel,$AP3Sec,$AP3Key,$AP3Auth)='';
	my ($AP4Name,$AP4IPAddr,$AP4SSID,$AP4Channel,$AP4Sec,$AP4Key,$AP4Auth)='';
	open(LIFILE,"$dirPath\\$openFile") or $self->subErrorHandler("Cannot open file $openFile :$!");
	if($errorText ne ''){return;}
	while(<LIFILE>){
		if($_=~/Test_Name\s+:\s+(.*)/){$testName=$1;}			
		if($_=~/Test_Mode\s+:\s+(.*)/){$tstMode=$1;}
		#-------Read AP PArameters--------#
		if($_=~/AP1_Name\s+:\s+(.*)/){$AP1Name=$1;}
		if($_=~/AP1_IPAddr\s+:\s+(.*)/){$AP1IPAddr=$1;}
		if($_=~/AP1_SSID\s+:\s+(.*)/){$AP1SSID=$1;}
		if($_=~/AP1_Channel\s+:\s+(.*)/){$AP1Channel=$1;}
		if($_=~/AP1_Security\s+:\s+(.*)/){$AP1Sec=$1;}
		if($_=~/AP1_Key\s+:\s+(.*)/){$AP1Key=$1;}
		if($_=~/AP1_Auth\s+:\s+(.*)/){$AP1Auth=$1;}
		if($_=~/AP1_KeyIndex\s+:\s+(.*)/){$AP1Index=$1;}
		if($_=~/AP2_Name\s+:\s+(.*)/){$AP2Name=$1;}
		if($_=~/AP2_IPAddr\s+:\s+(.*)/){$AP2IPAddr=$1;}
		if($_=~/AP2_SSID\s+:\s+(.*)/){$AP2SSID=$1;}
		if($_=~/AP2_Channel\s+:\s+(.*)/){$AP2Channel=$1;}
		if($_=~/AP2_Security\s+:\s+(.*)/){$AP2Sec=$1;}
		if($_=~/AP2_Key\s+:\s+(.*)/){$AP2Key=$1;}
		if($_=~/AP2_Auth\s+:\s+(.*)/){$AP2Auth=$1;}
		if($_=~/AP2_KeyIndex\s+:\s+(.*)/){$AP2Index=$1;}
		if($_=~/AP3_Name\s+:\s+(.*)/){$AP3Name=$1;}
		if($_=~/AP3_IPAddr\s+:\s+(.*)/){$AP3IPAddr=$1;}
		if($_=~/AP3_SSID\s+:\s+(.*)/){$AP3SSID=$1;}
		if($_=~/AP3_Channel\s+:\s+(.*)/){$AP3Channel=$1;}
		if($_=~/AP3_Security\s+:\s+(.*)/){$AP3Sec=$1;}
		if($_=~/AP3_Key\s+:\s+(.*)/){$AP3Key=$1;}
		if($_=~/AP3_Auth\s+:\s+(.*)/){$AP3Auth=$1;}
		if($_=~/AP3_KeyIndex\s+:\s+(.*)/){$AP3Index=$1;}
		if($_=~/AP4_Name\s+:\s+(.*)/){$AP4Name=$1;}
		if($_=~/AP4_IPAddr\s+:\s+(.*)/){$AP4IPAddr=$1;}
		if($_=~/AP4_SSID\s+:\s+(.*)/){$AP4SSID=$1;}
		if($_=~/AP4_Channel\s+:\s+(.*)/){$AP4Channel=$1;}
		if($_=~/AP4_Security\s+:\s+(.*)/){$AP4Sec=$1;}
		if($_=~/AP4_Key\s+:\s+(.*)/){$AP4Key=$1;}
		if($_=~/AP4_Auth\s+:\s+(.*)/){$AP4Auth=$1;}
		if($_=~/AP4_KeyIndex\s+:\s+(.*)/){$AP4Index=$1;}		
	} 
	close(LIFILE);
	
	return($testName,$tstMode,$AP1Name,$AP1IPAddr,$AP1SSID,$AP1Channel,$AP1Sec,$AP1Auth,$AP1Index,$AP1Key,$AP2Name,$AP2IPAddr,$AP2SSID,$AP2Channel,$AP2Sec,$AP2Auth,$AP2Index,$AP2Key,
			$AP3Name,$AP3IPAddr,$AP3SSID,$AP3Channel,$AP3Sec,$AP3Auth,$AP3Index,$AP3Key,$AP4Name,$AP4IPAddr,$AP4SSID,$AP4Channel,$AP4Sec,$AP4Auth,$AP4Index,$AP4Key);
}
# #####################################################################################
# # Function Name : subReadIBSSConfigParam
# # Description	: Read configuration parameters from text file
# # Called By		: MdlADKIBSS.pm
# # Argument List : Path of the directory,Name of file,Tye of test 
# # Returning Arg : Test parameters
# #####################################################################################

# sub subReadIBSSConfigParam
# {		
# 	my $self= shift;
# 	my $dirPath = shift;
# 	my $openFile = shift;
# 	my $trafficName = shift;	
# 	my $i=0;
# 	my @apArg=();	
# 	$errorText='';
# 	$tstMode='';
# 	$tstName='';
# 	my ($STAName,$STAIPAddr,$tstMode,$STASSID,$STAChannel,$STABeacon,$STARTS,$STAFrag,$STASec,$STAKey,$STAAuth,$STAIndex)='';
# 	my ($DUTIPAddr,$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$RADIUSIP)='';
# 	open(LIFILE,"$dirPath\\$openFile") or $self->subErrorHandler("Cannot open file $openFile :$!");
# 	if($errorText ne ''){return;}
# 	while(<LIFILE>){
# 		if($_=~/Test_Name\s+:\s+(.*)/){$testName=$1;}
# 		if($_=~/STA(\d+)_Name\s+:\s+(.*)/){
# 			$sNo=$1;
# 			$STAName=$2;			
# 		}
# 		if($_=~/STA(\d+)_IPAddr\s+:\s+(.*)/){	
# 			if($sNo==$1){
# 				$STAIPAddr=$2;
# 				$staList[$i]="$STAName->$STAIPAddr";
# 		   		$i++;
# 			}
# 		}			
# 		if($_=~/Test_Mode\s+:\s+(.*)/){$tstMode=$1;}
# 		#-------Read STA PArameters--------#
# 		if($_=~/STA1_Name\s+:\s+(.*)/){$STAName=$1;}
# 		if($_=~/STA1_IPAddr\s+:\s+(.*)/){$STAIPAddr=$1;}
# 		if($_=~/STA_SSID\s+:\s+(.*)/){$STASSID=$1;}
# 		if($_=~/STA_Channel\s+:\s+(.*)/){$STAChannel=$1;}
# 		if($_=~/STA_Beacon\s+:\s+(.*)/){$STABeacon=$1;}
# 		if($_=~/STA_RTS\s+:\s+(.*)/){$STARTS=$1;}
# 		if($_=~/STA_Frag\s+:\s+(.*)/){$STAFrag=$1;}
# 		if($_=~/STA_Security\s+:\s+(.*)/){$STASec=$1;}
# 		if($_=~/STA_Key\s+:\s+(.*)/){$STAKey=$1;}
# 		if($_=~/STA_Auth\s+:\s+(.*)/){$STAAuth=$1;}	
# 		if($_=~/STA_KeyIndex\s+:\s+(.*)/){$STAIndex=$1;}	
# 		if($_=~/IBSS_SUB_TEST\s+:\s+(.*)/){$subType=$1};
# 		#-------Read DUT PArameters--------#
# 		if($_=~/DUT_SSID\s+:\s+(.*)/){$DUTSSID=$1;}
# 		if($_=~/DUT_Channel\s+:\s+(.*)/){$DUTChannel=$1;}
# 		if($_=~/DUT_Beacon\s+:\s+(.*)/){$DUTBeacon=$1;}
# 		if($_=~/DUT_RTS\s+:\s+(.*)/){$DUTRTS=$1;}
# 		if($_=~/DUT_Frag\s+:\s+(.*)/){$DUTFrag=$1;}
# 		if($_=~/DUT_Security\s+:\s+(.*)/){$DUTSec=$1;}
# 		if($_=~/DUT_Key\s+:\s+(.*)/){$DUTKey=$1;}		
# 		if($_=~/DUT_Auth\s+:\s+(.*)/){$DUTAuth=$1;}
# 		if($_=~/DUT_KeyIndex\s+:\s+(.*)/){$DUTIndex=$1;}
# 		if($_=~/DUT_IBSS_Type\s+:\s+(.*)/){$DUTOption=$1;}	
# 	} 
# 	close(LIFILE);
# 	
# 	return ($testName,$tstMode,$STAName,$STAIPAddr,$STASSID,$STAChannel,$STABeacon,$STARTS,$STAFrag,$STASec,$STAKey,$STAAuth,$STAIndex,
# 				$DUTSSID,$DUTChannel,$DUTBeacon,$DUTRTS,$DUTFrag,$DUTSec,$DUTKey,$DUTAuth,$DUTIndex,$DUTOption);
# }
#####################################################################################
# Function Name : subIBSSParam
# Description	: Read configuration parameters from text file
# Called By		: MdlPingTest,MdlThroughputTest,MdlRoamTest,MdlSingleTest,MdlBatchTest
# Argument List : Path of the directory,Name of file,Tye of test 
# Returning Arg : Test parameters
#####################################################################################

sub subIBSSParam
{		
	my $self= shift;
	my $dirPath = shift;
	my $openFile = shift;
	my $trafficName = shift;
		
	$errorText='';
	
	my ($destIPAddr,$PingSize,$PingCount,$upTraffic,$dwnTraffic,$trafficType)='';
	open(LIFILE,"$dirPath\\$openFile") or $self->subErrorHandler("Cannot open file $openFile :$!");
	if($errorText ne ''){return;}
	while(<LIFILE>){		
		if($trafficName eq "Ping"){
			if($_=~/Dest_IP\s+:\s+(.*)/){$destIPAddr=$1;}
			if($_=~/PING_Size\s+:\s+(.*)/){$PingSize=$1;}
			if($_=~/PING_Count\s+:\s+(.*)/){$PingCount=$1;}
		}
		if($trafficName eq "Throughput"){
			if($_=~/UPLOAD_TRAFFIC\s+:\s+(.*)/){$upTraffic=$1;}
			if($_=~/DOWNLOAD_TRAFFIC\s+:\s+(.*)/){$dwnTraffic=$1;}	
			if($_=~/TCP_(.*)/){$trafficType="tcp";}	
			elsif($_=~/UDP_(.*)/){$trafficType="udp";}
			if($trafficType eq "tcp"){			
				if($_=~/UP_HOST_IP\s+:\s+(.*)/){$uphostip=$1;}			
				if($_=~/DOWN_HOST_IP\s+:\s+(.*)/){$dwnhostip=$1;}
				if($_=~/TCP_Time\s+:\s+(.*)/){$tcptime=$1;}
				if($_=~/TCP_Interval\s+:\s+(.*)/){$tcpinterval=$1;}	
				if($_=~/TCP_Format\s+:\s+(.*)/){$tcpformat=$1;}	
				if($_=~/TCP_Filesize\s+:\s+(.*)/){$tcpfilesize=$1;}	
				if($_=~/TCP_PassCriteria\s+:\s+(.*)/){$tcppasscriteria=$1;}		
			}
			if($trafficType eq "udp"){			
				if($_=~/UP_HOST_IP\s+:\s+(.*)/){$uphostip=$1;}			
				if($_=~/DOWN_HOST_IP\s+:\s+(.*)/){$dwnhostip=$1;}
				if($_=~/UDP_Time\s+:\s+(.*)/){$udptime=$1;}
				if($_=~/UDP_Interval\s+:\s+(.*)/){$udpinterval=$1;}	
				if($_=~/UDP_Format\s+:\s+(.*)/){$udpformat=$1;}	
				if($_=~/UDP_Filesize\s+:\s+(.*)/){$udpfilesize=$1;}		
				if($_=~/UDP_Bandwidth\s+:\s+(.*)/){$udpbandwidth=$1;}	
				if($_=~/UDP_PktLength\s+:\s+(.*)/){$udppktlength=$1;}	
				if($_=~/UDP_Passcriteria\s+:\s+(.*)/){$udppasscriteria=$1;}		
			}		
		}
		if($trafficName eq "Negative"){
			if($_=~/Dest_IP\s+:\s+(.*)/){$destIPAddr=$1;}
		}		
	} 

	close(LIFILE);
	if($trafficName eq "Ping"){		
		return ($destIPAddr,$PingSize,$PingCount);
	}
	if($trafficName eq "Throughput"){
		if($trafficType eq "tcp"){
			return ($upTraffic,$dwnTraffic,$trafficType,$tcptime,$tcpinterval,$tcpformat,$tcpfilesize,$uphostip,$dwnhostip,$tcppasscriteria);
		}
		if($trafficType eq "udp"){
			return ($upTraffic,$dwnTraffic,$trafficType,$udptime,$udpinterval,$udpformat,$udpfilesize,$udpbandwidth,$udppktlength,$uphostip,$dwnhostip,$udppasscriteria);
		}
	}
	if($trafficName eq "Negative"){
		return ($destIPAddr);
	}
	
}
#####################################################################################
# Function Name : subReadTrafficParam
# Description	: Read configuration parameters of tcp/udp
# Called By		: MdlThroughputTest
# Argument List : Path of the directory,Name of file,Tye of test
# Returning Arg : Traffic Parameters
#####################################################################################
sub subReadTrafficParam
{
	
	my $self = shift; 
	my $dirPath = shift;
	my $openFile = shift;
	my $traffic = shift;
	$errorText='';
	my ($DName1,$DName2,$DName3,$DName4,$DName5,$DName6,$DName7,$DName8)='';
	my ($SMTPSender,$SMTPSenderEmailAddr,$SMTPCcAddr,$SMTPDomainName,$SMTPRecieverAddr,$SMTPSubj,$SMTPMailBody,$SMTPAttachment,$SMTPFileSize,$SMTPFileName)='';	
	open(LIFILE,"$dirPath\\$openFile") || $self->subErrorHandler("Cann't open file $openFile :$!\n");
	if($errorText ne ''){return;}
	while(<LIFILE>){
		if($traffic eq "tcp"){			
# 			if($_=~/UP_HOST_IP\s+:\s+(.*)/){$uphostip=$1;}			
# 			if($_=~/DOWN_HOST_IP\s+:\s+(.*)/){$dwnhostip=$1;}
			if($_=~/TCP_Time\s+:\s+(.*)/){$tcptime=$1;}
			if($_=~/TCP_Interval\s+:\s+(.*)/){$tcpinterval=$1;}	
			if($_=~/TCP_Format\s+:\s+(.*)/){$tcpformat=$1;}	
			if($_=~/TCP_Filesize\s+:\s+(.*)/){$tcpfilesize=$1;}	
			if($_=~/TCP_PassCriteria\s+:\s+(.*)/){$tcppasscriteria=$1;}		
		}
		if($traffic eq "udp"){			
# 			if($_=~/UP_HOST_IP\s+:\s+(.*)/){$uphostip=$1;}			
# 			if($_=~/DOWN_HOST_IP\s+:\s+(.*)/){$dwnhostip=$1;}
			if($_=~/UDP_Time\s+:\s+(.*)/){$udptime=$1;}
			if($_=~/UDP_Interval\s+:\s+(.*)/){$udpinterval=$1;}	
			if($_=~/UDP_Format\s+:\s+(.*)/){$udpformat=$1;}	
			if($_=~/UDP_Filesize\s+:\s+(.*)/){$udpfilesize=$1;}		
			if($_=~/UDP_Bandwidth\s+:\s+(.*)/){$udpbandwidth=$1;}	
			if($_=~/UDP_PktLength\s+:\s+(.*)/){$udppktlength=$1;}	
			if($_=~/UDP_Passcriteria\s+:\s+(.*)/){$udppasscriteria=$1;}		
		}
		if($traffic eq "ADKREG_DNS"){			

			if($_=~/Domain_Name1\s+:\s+(.*)/){$DName1=$1;}
			if($_=~/Domain_Name2\s+:\s+(.*)/){$DName2=$1;}
			if($_=~/Domain_Name3\s+:\s+(.*)/){$DName3=$1;}
			if($_=~/Domain_Name4\s+:\s+(.*)/){$DName4=$1;}
			if($_=~/Domain_Name5\s+:\s+(.*)/){$DName5=$1;}
			if($_=~/Domain_Name6\s+:\s+(.*)/){$DName6=$1;}
			if($_=~/Domain_Name7\s+:\s+(.*)/){$DName7=$1;}
			if($_=~/Domain_Name8\s+:\s+(.*)/){$DName8=$1;}
		}
		if($traffic eq "ADKREG_SMTP"){			

			if($_=~/SMTP_SenderName\s+:\s+(.*)/){$SMTPSender=$1;}
			if($_=~/SMTP_SenderEmailAddr\s+:\s+(.*)/){$SMTPSenderEmailAddr=$1;}
			if($_=~/SMTP_CCAddr\s+:\s+(.*)/){$SMTPCcAddr=$1;}
			if($_=~/SMTP_DomainName\s+:\s+(.*)/){$SMTPDomainName=$1;}
			if($_=~/SMTP_ReciverAddr\s+:\s+(.*)/){$SMTPRecieverAddr=$1;}
			if($_=~/SMTP_Subj\s+:\s+(.*)/){$SMTPSubj=$1;}
			if($_=~/SMTP_MailBody\s+:\s+(.*)/){$SMTPMailBody=$1;}
			if($_=~/Do u want attach\s+:\s+(.*)/){$SMTPAttachment=$1;}
			if($_=~/SMTP_FileSize\s+:\s+(.*)/){$SMTPFileSize=$1;}
			if($_=~/SMTP_FileName\s+:\s+(.*)/){$SMTPFileName=$1;}
		}
	}
	close(LIFILE);
	if($traffic eq "tcp"){
		return ($tcptime,$tcpinterval,$tcpformat,$tcpfilesize,$tcppasscriteria);
	}
	elsif($traffic eq "udp"){
		return ($udptime,$udpinterval,$udpformat,$udpfilesize,$udpbandwidth,$udppktlength,$udppasscriteria);
	}
	elsif($traffic eq "ADKREG_DNS"){
		return ($DName1,$DName2,$DName3,$DName4,$DName5,$DName6,$DName7,$DName8);
	}
	elsif($traffic eq "ADKREG_SMTP"){
		return ($SMTPSender,$SMTPSenderEmailAddr,$SMTPCcAddr,$SMTPDomainName,$SMTPRecieverAddr,$SMTPSubj,$SMTPMailBody,$SMTPAttachment,$SMTPFileSize,$SMTPFileName);
	}
}

#####################################################################################
# Function Name : subDatabaseReader
# Description	: Read Database file
# Called By		: Self
# Argument List : Name of the Database File
# Returning Arg : An array reference which contains all info of device
#####################################################################################

sub subDatabaseReader
{	
	my $self = shift;
	my $setupFileName = shift;
	
	my $tempHash = {};
	my @arrSetupDatabase;
	my $flag0 = 0;
	$errorText='';

	open(hFILE,"< $setupFileName") or $self->subErrorHandler("Can't open Setup database:$!");
	if($errorText ne ''){return;} 
	while(<hFILE>){	
		chomp;
		s/^\s+//;                           # delete leading whitespaces
		s/#.*//;                            # delete comments
		s/\s+$//;                           # delete trailing whitespaces 
	
		$res = $_;
		next unless($res);			
		if ($res =~ m/START_DESCRIPTION_(.*)/) { $flag0 = 1; next;}
		if ($res =~ m/END_DESCRIPTION_(.*)/) { $flag0 = 0;}			
		if ($flag0 eq '1'){				
			my ($val1,$val2) = split /=/, $res;
			$val1 =~ s/^\s+//;	    # delete leading whitespaces
			$val1 =~ s/\s+$//;	    # delete trailing whitespaces 				
			$val2 =~ s/^\s+//;	    # delete leading whitespaces
			$val2 =~ s/\s+$//;	    # delete trailing whitespaces 		
					
			$tempHash->{$val1} = $val2;
		}			
		if ($flag0 eq '0'){
			push (@arrSetupDatabase, $tempHash);
			$tempHash = {};
		}
	}		
	
	close(hFILE);	
	if($flag0 eq '1'){			
		return ('ERROR');
	}		
	return(\@arrSetupDatabase); 
		
}
#####################################################################################
# Function Name : subGetDeviceParam
# Description	: Read a Particular Device's Parameters
# Called By		: MdlPingTest,MdlThroughputTest,MdlRoamTest
# Argument List : Name of the device,IP address of that device
# Returning Arg : All information about that device
#####################################################################################
sub subGetDeviceParam
{	
	my $self = shift;		
	my $deviceName=shift;
	my $arg1=shift;
	($val1,$val2)=split /->/,$arg1;
	my @temp=();
	my $i=0;
	$setupFile="$dir_to_open\\Files\\Setup_Database.txt";
	$arrSetup=$self->subDatabaseReader($setupFile);	
	$errorResponse=$self->subReturnError();
	if($errorResponse ne ''){
		return $errorResponse;
	}
	else{
		foreach $key (@{$arrSetup}){  							   		  		
	   		if($deviceName eq "AP"){			   		 		
		   		if($key->{'TYPE'}=~/^AP_(.*)/){	
			   		if(defined($arg1)){ 							
						if(($val1 eq $key->{'NAME'}) && ($val2 eq $key->{'IPADDRESS'})){	
								return ($key);	
						}
					}	   		
					else{																			
		   				$temp[$i]=$key->{'NAME'}."->".$key->{'IPADDRESS'}."->".$key->{'FIRMWARE'};
		   				$i++;
		   			}	
				}   
					
			}
			if($deviceName eq "STA"){			   		 		
		   		if($key->{'TYPE'}=~/^STA_(.*)/){	
			   		if(defined($arg1)){ 							
						if(($val1 eq $key->{'NAME'}) && ($val2 eq $key->{'IPADDRESS'})){	
								return ($key);	
						}
					}	   		
					else{																			
		   				$temp[$i]=$key->{'NAME'}."->".$key->{'IPADDRESS'}."->".$key->{'FIRMWARE'};
		   				$i++;
		   			}	
				}   
					
			}
			if($deviceName eq "DUT"){		 			
		   		if($key->{'TYPE'}=~/^DUT_(.*)/){					
					if(defined($arg1)){ 
						if(($val1 eq $key->{'NAME'}) && ($val2 eq $key->{'IPADDRESS'})){								
								return ($key);	
						}
					}	   		
					else{															
		   				$temp[$i]=$key->{'NAME'}."->".$key->{'IPADDRESS'};
		   				$i++;
		   			}	
				}   	
			}   
			if($deviceName eq "LINUX"){		   		   		
				if($key->{'TYPE'}=~/^LINUX_PC/){															
		   				return ($key);	
		   		}   				   	
			}  
			if($deviceName eq "WINDOWS"){		   		   		
				if($key->{'TYPE'}=~/^WINDOW_PC/){															
		   				return ($key);	
		   		}   				   	
			}   
			if($deviceName eq "WEB_POWER_SWITCH"){		   		   		
				if($key->{'TYPE'}=~/^WEB_POWER_SWITCH/){															
		   				return ($key);	
		   		}   				   	
			}   
			if($deviceName eq "OMAP"){		   		   		
				if($key->{'TYPE'}=~/^DUT_BGW211/){															
		   				return ($key);	
		   		}   				   	
			} 
			if($deviceName eq "ADK"){		   		   		
				if($key->{'TYPE'}=~/^DUT_ADK/){															
		   				return ($key);	
		   		}   				   	
			}  
	   	}   	
		return @temp;
	}
}
#####################################################################################
# Function Name : subGetIperfData
# Description	: Calculate data rate from upload/download log file
# Called By		: TestTraffic
# Argument List : Directory Name,Name of the Upload/Download log file
# Returning Arg : Result of iperf
#####################################################################################
sub subGetIperfData 
{
    my $self = shift;
    my $tmpDir = shift;
    my $fileName = shift;

    my @port = ();
    my $count = 0;
    my $count1 = 0;
    my $totalLostPacks = 0;
    my $totalTransPacks = 0;
    my $tmpLostPacks = 0;
    my $sum = 0;
    my $pos = 0;
    my $sTime = 0;
    my $eTime = 0;
    my @arrTemp3 = ();
    my $throughput = 0;
    my $lossPercent = 0;
    my $status = '';
    my $dataTransferred = 0;
    $errorText='';
    eval{
	    open(iFILE,"< $tmpDir/$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
	    if($errorText ne ''){return;}
		while(<iFILE>){
			if ($_ =~ m/connected/){				
				my @arrTemp1 = split(' ',$_);
				if($arrTemp1[0] =~ m/\d/){
					$arrTemp1[0] =~ s/\[//g;
					$arrTemp1[0] =~ s/\]//g;
					$port[$count] = $arrTemp1[0];
					$count++;
				}
				elsif($arrTemp1[1] =~ m/\d/){
					$arrTemp1[1] =~ s/\[//g;
					$arrTemp1[1] =~ s/\]//g;
					$port[$count] = $arrTemp1[1];
					$count++;
				} 			
			}		
			if(($_ =~ m/bits\/sec/g)||($_ =~ m/Bytes\/sec/g)||($_ =~ m/Kbits\/sec/g)||($_ =~ m/KBytes\/sec/g)||($_ =~ m/Mbits\/sec/g)||($_ =~ m/MBytes\/sec/g)){							
				my @arrTemp2 = split(' ',$_);
				if(($arrTemp2[0] =~ m/$port[0]/) || ($arrTemp2[1] =~ m/$port[0]/)){
					$count1 = 0;
					$sTime = 0;
					$eTime = 0;
					@arrTemp3 = @arrTemp2;
					foreach $value(@arrTemp2){
						if(($value =~ m/bits\/sec/g)||($value =~ m/Bytes\/sec/g)||($value =~ m/Kbits\/sec/g)||($value =~ m/KBytes\/sec/g)||($value =~ m/Mbits\/sec/g)||($value =~ m/MBytes\/sec/g)){					
							$format=$value;
							$pos = $count1;
							last;   
						}
						$count1++;
					} 				
					$sum += $arrTemp2[$pos - 1];
					if(defined($arrTemp2[$pos + 4]) and ($arrTemp2[$pos + 4] =~ m/^\d/g)){
						$totalTransPacks += $arrTemp2[$pos + 4];				
					}					
					if(defined($arrTemp2[$pos + 3])){
						my $tmp1 = 0;
						($tmpLostPacks,$tmp1) = split('/',$arrTemp2[$pos + 3]); 
						$totalLostPacks += $tmpLostPacks;
					}
					
					if($arrTemp2[$pos - 5] =~ m/-/g){
						($sTime,$eTime) = split('-',$arrTemp2[$pos - 5]);
					}
					else{				
						$eTime = $arrTemp2[$pos - 5];
						$arrTemp2[$pos - 6] =~ s/-//g;
						$sTime = $arrTemp2[$pos - 6];
					}
				}
			}
		}
		
		if($sTime =~ m/^0.0$/g){			
			$throughput = $arrTemp3[$pos - 1];
			$dataTransferred = $arrTemp3[$pos - 3];			
			if(defined($arrTemp3[$pos + 3])){
				($totalLostPacks,$totalTransPacks) = split('/',$arrTemp3[$pos + 3]);
			}
			if(defined($arrTemp3[$pos + 4])){		
				$arrTemp3[$pos + 4] =~ s/\(//g;
				$arrTemp3[$pos + 4] =~ s/\)//g;
				$arrTemp3[$pos + 4] =~ s/%//g;
				$lossPercent = $arrTemp3[$pos + 4];    
			}
			$status .="Data transferred successfully";
		}
		else{				
			if($eTime>0) {
				$sTime = '0.0';
				$throughput = ($sum/$eTime);
				$throughput = sprintf("%f",$throughput);
				if(defined($arrTemp3[$pos + 5])){
					$lossPercent = ($totalLostPacks/$totalTransPacks) * 100;
					$lossPercent = sprintf("%f",$lossPercent);
				}
				$status .="Data transferred successfully";
				
			}
			else {
				$status .= "Data Not Received.";   
			}
		}		
			$sTime .= ' sec';
			$eTime .= ' sec';  
			$throughput = $throughput.' '.$format; 
			$lossPercent .= '%'; 
			close(iFILE);
	};
	
	if($@){	
		return ({'THROUGHPUT' => 0, 'DATA_TRANSFER' => 0, 'START_TIME' => 0, 'END_TIME' => 0, 'DATA_LOSS' => 0,'STATUS' => 'File not found.'});
	}     
	
	return ({	'THROUGHPUT' => $throughput,
				'DATA_TRANSFER' => $dataTransferred,   
				'START_TIME' => $sTime,
				'END_TIME' => $eTime,
				'DATA_LOSS' => $lossPercent,
				'STATUS' => $status
			});
}
#####################################################################################
# Function Name : subEtherealResult
# Description	: Verify Ethereal Log
# Called By		: TestPING,TestTRAFFIC,TestROAM
# Argument List : Directory name,Ethereal log file,Type of test
# Returning Arg : Result of ethereal log
#####################################################################################
sub subEtherealResult
{
	my $self = shift;
	my $tmpDir = shift;
    my $fileName = shift;
    my $testType = shift;
    my $testSecurity = shift;
    my $result='';
    $errorText='';
    
    open(eFILE,"< $tmpDir/$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
    if($errorText ne ''){return;}
	while(<eFILE>){
		
		if(($testType eq "Ping")||($testType eq "Throughput")){			
			if($_=~/Probe\s+Request:\s+Found/){$result = "N.A";}
			elsif($_=~/Probe\s+Request:\s+Not\s+Found/){$result = "Probe Request not seen in sniffer";}
			if($_=~/Probe\s+Response:\s+Found/){$result = "N.A";}
			elsif($_=~/Probe\s+Response:\s+Not\s+Found/){$result = "Probe Response not seen in sniffer";}
			if($_=~/Authentication:\s+Passed/){$result = "N.A";}		
			elsif($_=~/Assoc\s+Request:\s+Failed/){$result = "Authentication not seen in sniffer";}
			if($_=~/Assoc\s+Request:\s+Found/){$result = "N.A";}		
			elsif($_=~/Assoc\s+Request:\s+Not\s+Found/){$result = "Association Request not seen in sniffer";}
			if($_=~/Assoc\s+Response:\s+Found/){$result = "N.A";}
			elsif($_=~/Assoc\s+Response:\s+Not\s+Found/){$result = "Association Response not seen in sniffer";}
			if($_=~/Ping\s+Request:\s+Found/){$result = "N.A";}
			elsif($_=~/Ping\s+Request:\s+Not\s+Found/){$result = "Ping Request not seen in sniffer";}
			if($_=~/Ping\s+Reply:\s+Found/){$result = "N.A";}
			elsif($_=~/Ping\s+Reply:\s+Not\s+Found/){$result = "Ping Reply not seen in sniffer";}
			if(($testSecurity eq "WPA-PSK")||($testSecurity eq "WPA2-PSK")){
				if($_=~/4way\s+handshaking\s+Passed/){$result = "N.A";}
				elsif($_=~/4way\s+handshaking\s+Failed/){$result = "Handshaking Failed";}
			}
			if(($testSecurity eq "WPA-TLS")||($testSecurity eq "WPA2-TLS")){
				###########
			}
		}
		elsif($testType eq "Roam"){
			if($_=~/ap(\d+)\s+Probe\s+Request:\s+Found/){$result = "N.A";}
			elsif($_=~/ap(\d+)\s+Probe\s+Request:\s+Not\s+Found/){$result = "Probe Request not seen in sniffer";}
			if($_=~/ap(\d+)\s+Probe\s+Response:\s+Found/){$result = "N.A";}
			elsif($_=~/ap(\d+)\s+Probe\s+Response:\s+Not\s+Found/){$result = "Probe Response not seen in sniffer";}
			if($_=~/ap(\d+)\s+Authentication:\s+Passed/){$result = "N.A";}		
			elsif($_=~/ap(\d+)\s+Assoc\s+Request:\s+Failed/){$result = "Authentication seen in sniffer";}
			if($_=~/ap(\d+)\s+Assoc\s+Request:\s+Found/){$result = "N.A";}		
			elsif($_=~/ap(\d+)\s+Assoc\s+Request:\s+Not\s+Found/){$result = "Association Request not seen in sniffer";}
			if($_=~/ap(\d+)\s+Assoc\s+Response:\s+Found/){$result = "N.A";}
			elsif($_=~/ap(\d+)\s+Assoc\s+Response:\s+Not\s+Found/){$result = "Association Response not seen in sniffer";}
			if($_=~/ap(\d+)\s+Ping\s+Request:\s+Found/){$result = "N.A";}
			elsif($_=~/ap(\d+)\s+Ping\s+Request:\s+Not\s+Found/){$result = "Ping Request not seen in sniffer";}
			if($_=~/ap(\d+)\s+Ping\s+Reply:\s+Found/){$result = "N.A";}
			elsif($_=~/ap(\d+)\s+Ping\s+Reply:\s+Not\s+Found/){$result = "Ping Reply not seen in sniffer";}
		}
# 		elsif($testType eq "Negative"){
# 			if($_=~/Probe\s+Request:\s+Found/){$result = "N.A";}
# 			elsif($_=~/Probe\s+Request:\s+Not\s+Found/){$result = "Probe Request not seen in sniffer";}
# 			if($_=~/Probe\s+Response:\s+Found/){$result = "N.A";}
# 			elsif($_=~/Probe\s+Response:\s+Not\s+Found/){$result = "Probe Response not seen in sniffer";}
# 			if($_=~/Authentication:\s+Passed/){$result = "N.A";}		
# 			elsif($_=~/Assoc\s+Request:\s+Failed/){$result = "Authentication seen in sniffer";}
# 			if($_=~/Assoc\s+Request:\s+Found/){$result = "N.A";}		
# 			elsif($_=~/Assoc\s+Request:\s+Not\s+Found/){$result = "Association Request seen in sniffer";}
# 			if($_=~/Assoc\s+Response:\s+Found/){$result = "N.A";}
# 			elsif($_=~/Assoc\s+Response:\s+Not\s+Found/){$result = "Association Response seen in sniffer";}
# 			if($_=~/Ping\s+Request:\s+Found/){$result = "N.A";}
# 			elsif($_=~/Ping\s+Request:\s+Not\s+Found/){$result = "Ping Request seen in sniffer";}
# 			if($_=~/Ping\s+Reply:\s+Found/){$result = "N.A";}
# 			elsif($_=~/Ping\s+Reply:\s+Not\s+Found/){$result = "Ping Reply seen in sniffer";}
# 		}
	}
    close(eFILE);
    return($result);
}	
#####################################################################################
# Function Name : subEtherealWiredResult
# Description	: Verify Ethereal Log
# Called By		: TestPING,TestTRAFFIC,TestROAM
# Argument List : Directory name,Ethereal log file,Type of test
# Returning Arg : Result of ethereal log
#####################################################################################
sub subEtherealWiredResult
{
	my $self = shift;
	my $tmpDir = shift;
    my $fileName = shift;
    my $apNo= shift;
    $errorText='';
    open(ewFILE,"< $tmpDir/$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
    if($errorText ne ''){return;}
    @wiredResult=<ewFILE>;
    close(ewFILE);
    for ($val=1;$val<=$apNo;$val++ ){
		for($i=0;$i<=$#wiredResult;$i++){
			if($wiredResult[$i]=~/AP(\d+)\s+(.*)/){
				$num = $1;
				if($num == $val){
					if($wiredResult[$i]=~/AP(\d+)\s+Access\s+Request:\s+Found/){$result = "N.A";}
					elsif($wiredResult[$i]=~/AP(\d+)\s+Access\s+Request:\s+Not\s+Found/){$result = "Access Request not seen";}
					if($wiredResult[$i]=~/AP(\d+)\s+Access\s+Challenge:\s+Found/){$result = "N.A";}
					elsif($wiredResult[$i]=~/AP(\d+)\s+Access\s+Challenge:\s+Not\s+Found/){$result = "Access Challenge not seen";}
					if($wiredResult[$i]=~/AP(\d+)\s+Access\s+Accept:\s+Found/){$result = "N.A";}		
					if($wiredResult[$i]=~/AP(\d+)\s+Access\s+Reject:\s+Found/){$result = "Access Reject Seen";}
								
				}
			}
		}
	}

	return($result)
}

#####################################################################################
# Function Name	: subErrorHandler
# Description	: Get the text of any error from file handler
# Called By	: Self
# Argument List : An error string
# Returning Arg : None
#####################################################################################
sub subErrorHandler{
	
	$self=shift;
	$errorText=shift;
}
#####################################################################################
# Function Name	: subReturnError
# Description	: Return an error
# Called By	: MdlPingTest
# Argument List : None
# Returning Arg : An error string
#####################################################################################
sub subReturnError{
	return $errorText;
}
#####################################################################################
#Return a True value to Respective Module
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################