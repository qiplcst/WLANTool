#####################################################################################
#!/usr/bin/perl
#####################################################################################
package IOTFileCreater;
#####################################################################################
# Description	: List of User Defined Packages
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
# Function Name : subIOTAPList
# Description	: Save AP's Configuration parameters in a text file
# Returning Arg : None
#####################################################################################
sub subIOTAPList{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	my $APVendorName  = shift;
	my $APModel = shift;
	my $APIPAddress = shift;
	my $APConfigTool = shift;
	$errorText='';
	open(CfgFILE,">$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
	if($errorText ne ''){return;}
	print CfgFILE "START_IOT_AP_List_" . "$APVendorName->$APIPAddress\n\n";
	print CfgFILE "AP_Vendor_Name  : $APVendorName\n";
	print CfgFILE "AP_Model_Number : $APModel\n";
	print CfgFILE "AP_IP_Address   : $APIPAddress\n";
	print CfgFILE "AP_Config_Tool  : $APConfigTool\n\n";
	print CfgFILE "END_IOT_AP_List_" . "$APVendorName->$APIPAddress\n\n";
	close(CfgFILE);
}
#####################################################################################
# Function Name : subRoamAPConfigParam
# Description	: Save AP's Configuration parameters in a text file for ADK Roam test
# Called By		: MdlADKRoam
# Argument List : 
# Returning Arg : None
#####################################################################################

sub subRoamAPConfigParam 
{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	my $tstName  = shift;
	my $tstMode = shift;
	my @argAP= @_;
	print "@argAP\n";
	$errorText='';
	$cnt=0;	
	
	open(CfgFILE,">$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
	if($errorText ne ''){return;}
	print CfgFILE "Test_Name : $tstName\n\n";
	print CfgFILE "Test_Mode : $tstMode\n";
	print CfgFILE "AP_CONFIG_PARAMETER_START\n";
	print CfgFILE "AP1_Name : $argAP[0]\n";
	print CfgFILE "AP1_IPAddr : $argAP[1]\n";
	print CfgFILE "AP1_SSID : $argAP[2]\n";
	print CfgFILE "AP1_Channel : $argAP[3]\n";
	print CfgFILE "AP1_Security : $argAP[4]\n";
	print CfgFILE "AP1_Auth : $argAP[5]\n";
	print CfgFILE "AP1_KeyIndex : $argAP[6]\n";
	print CfgFILE "AP1_Key : $argAP[7]\n";
	print CfgFILE "AP2_Name : $argAP[8]\n";
	print CfgFILE "AP2_IPAddr : $argAP[9]\n";
	print CfgFILE "AP2_SSID : $argAP[10]\n";
	print CfgFILE "AP2_Channel : $argAP[11]\n";
	print CfgFILE "AP2_Security : $argAP[12]\n";
	print CfgFILE "AP2_Auth : $argAP[13]\n";
	print CfgFILE "AP2_KeyIndex : $argAP[14]\n";
	print CfgFILE "AP2_Key : $argAP[15]\n";
	print CfgFILE "AP3_Name : $argAP[16]\n";
	print CfgFILE "AP3_IPAddr : $argAP[17]\n";
	print CfgFILE "AP3_SSID : $argAP[18]\n";
	print CfgFILE "AP3_Channel : $argAP[19]\n";
	print CfgFILE "AP3_Security : $argAP[20]\n";
	print CfgFILE "AP3_Auth : $argAP[21]\n";
	print CfgFILE "AP3_KeyIndex : $argAP[22]\n";
	print CfgFILE "AP3_Key : $argAP[23]\n";
	print CfgFILE "AP4_Name : $argAP[24]\n";
	print CfgFILE "AP4_IPAddr : $argAP[25]\n";
	print CfgFILE "AP4_SSID : $argAP[26]\n";
	print CfgFILE "AP4_Channel : $argAP[27]\n";
	print CfgFILE "AP4_Security : $argAP[28]\n";
	print CfgFILE "AP4_Auth : $argAP[29]\n";
	print CfgFILE "AP4_KeyIndex : $argAP[30]\n";
	print CfgFILE "AP4_Key : $argAP[31]\n";
	print CfgFILE "AP_CONFIG_PARAMETER_END\n\n";
	close(CfgFILE);
}
#####################################################################################
# Function Name	: subSTAConfigParam
# Description	: Save STA's Configuration parameters in a text file
# Called By		: MdlPingTest,MdlRoamTest,MdlThroughputTest
# Argument List : STA Configuration parameters
# Returning Arg : None
#####################################################################################

sub subSTAConfigParam 
{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	my $tstName  = shift;
	my $tstMode = shift;
	my $staSSID = shift;
	my $staChannel = shift;
	my $staBeacon = shift;
	my $staRts = shift;
	my $staFrag = shift;	
	my $staSec = shift;
	my $staKey = shift;	
	my $staAuth = shift;
	my $staKeyIndex = shift;
	my $curref=shift;
	my $staList= shift;
	$errorText='';
	
	$cnt=0;	
	
		open(CfgFILE,">$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "Test_Name : $tstName\n\n";
		
		if($curref ==1){
			print CfgFILE "IBSS_SUB_TEST : Ping\n";
		}
		elsif($curref ==2){
			print CfgFILE "IBSS_SUB_TEST : Throughput\n";
		}
		elsif($curref ==3){
			print CfgFILE "IBSS_SUB_TEST : Negative\n";
		}
		
		print CfgFILE "Test_Mode : $tstMode\n";
		
		print CfgFILE "STA_CONFIG_PARAMETER_START\n";
		foreach $arg (@{$staList}){
			$cnt++;
			if($arg=~/(.*)->(.*)/){					
				$staName=$1;
				$staIPAddr=$2;
				print CfgFILE "STA".$cnt."_Name : $staName\n";
				print CfgFILE "STA".$cnt."_IPAddr : $staIPAddr\n";
								
			}
		}	
		print CfgFILE "STA_SSID : $staSSID\n";
		print CfgFILE "STA_Channel : $staChannel\n";
		print CfgFILE "STA_Beacon : $staBeacon\n";
		print CfgFILE "STA_RTS : $staRts\n";
		print CfgFILE "STA_Frag : $staFrag\n";	
		print CfgFILE "STA_Security : $staSec\n";
		print CfgFILE "STA_Key : $staKey\n";
		print CfgFILE "STA_Auth : $staAuth\n";
		print CfgFILE "STA_KeyIndex : $staKeyIndex\n";
		print CfgFILE "STA_CONFIG_PARAMETER_END\n\n";
		close(CfgFILE);
	
}

#####################################################################################
# Function Name : subDUTConfigParam
# Description	: Save DUT's Configuration parameters in a text file
# Called By		: MdlPingTest,MdlRoamTest,MdlThroughputTest
# Argument List :
# Returning Arg : None
#####################################################################################

sub subDUTConfigParam 
{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	
# 	my $dutIPAddr = shift;
	my $dutSSID = shift;
	my $dutChannel = shift;
	my $dutBeacon = shift;
	my $dutRts = shift;
	my $dutFrag = shift;
	my $dutSec = shift;	
	my $dutKey = shift;	
	my $dutAuth = shift;
	my $dutKeyIndex= shift;
	my $radiusIP =shift;
	my $dutOption =shift;
	$errorText='';
	
	open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
	if($errorText ne ''){return;}
	print CfgFILE "DUT_CONFIG_PARAMETER_START\n";
	print CfgFILE "DUT_SSID : $dutSSID\n";
	print CfgFILE "DUT_Channel : $dutChannel\n";
	print CfgFILE "DUT_Beacon : $dutBeacon\n";
	print CfgFILE "DUT_RTS : $dutRts\n";
	print CfgFILE "DUT_Frag : $dutFrag\n";	
	print CfgFILE "DUT_Security : $dutSec\n";
	print CfgFILE "DUT_Key : $dutKey\n";
	print CfgFILE "DUT_Auth : $dutAuth\n";
	print CfgFILE "DUT_KeyIndex : $dutKeyIndex\n";
	if(defined($dutOption)){
		print CfgFILE "DUT_IBSS_Type : $dutOption\n";
	}
	print CfgFILE "DUT_CONFIG_PARAMETER_END\n\n";
	print CfgFILE "\nRADIUS_IP : $radiusIP\n";
	
	close(CfgFILE);
}

#####################################################################################
# Function Name : subTrafficConfigParam
# Description	: Save Traffic parameters in a text file
# Called By		:  MdlPingTest,MdlRoamTest,MdlThroughputTest
# Argument List :
# Returning Arg : None
#####################################################################################

sub subTrafficConfigParam 
{  
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;	
	my $trafficName = shift;	
	$errorText='';
	
	if($trafficName eq "Ping"){
		my $destIPAddr = shift;
		my $pingSize = shift;
		my $pingCount = shift;	
		
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "PING_PARAMETER_START\n";
#		print CfgFILE "Dest_IP : $destIPAddr\n";
		print CfgFILE "PING_Size : $pingSize\n";
		print CfgFILE "PING_Count : $pingCount\n";
		print CfgFILE "PING_PARAMETER_END\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "TCP"){
		my $tcpTime = shift;
		my $tcpInterval = shift;
		my $tcpFormat = shift;
		my $tcpFilesize = shift;
		my $tcppasscriteria = shift;	
		my $tcpformatdecision = shift;	
		my $uptraffic = shift;
		my $dwntraffic = shift;
# 		my $uphostip = shift;
# 		my $dwnhostip = shift;
		
		
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "TCP_PARAMETER_START\n";
		if(($uptraffic == 1)&&($dwntraffic == 1)){
			print CfgFILE "UPLOAD_TRAFFIC : $uptraffic\n";
			print CfgFILE "UP_HOST_IP : $uphostip\n";
			print CfgFILE "DOWNLOAD_TRAFFIC : $dwntraffic\n";
			print CfgFILE "DOWN_HOST_IP : $dwnhostip\n";
		}
		elsif($uptraffic == 1){
			print CfgFILE "UPLOAD_TRAFFIC : $uptraffic\n";
			print CfgFILE "UP_HOST_IP : $uphostip\n";
		}
		elsif($dwntraffic == 1){
			print CfgFILE "DOWNLOAD_TRAFFIC : $dwntraffic\n";
			print CfgFILE "DOWN_HOST_IP : $dwnhostip\n";
		}	
		
		print CfgFILE "TCP_Time : $tcpTime\n";
		print CfgFILE "TCP_Interval : $tcpInterval\n";
		print CfgFILE "TCP_Format : $tcpFormat\n";
		print CfgFILE "TCP_Filesize : $tcpFilesize\n";
		print CfgFILE "TCP_PassCriteria : $tcppasscriteria\n";		
		print CfgFILE "TCP_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_DHCP"){
		my $iplease = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "DHCP_PARAMETER_START\n";
		print CfgFILE "Lease_Time : $iplease\n";
		print CfgFILE "DHCP_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_Telnet"){
		my $telnetport = shift;
		my $telnetipadd = shift;
		my $telnetuname = shift;
		my $telnetpw = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "Telnet_PARAMETER_START\n";
		print CfgFILE "Telnet_Port : $telnetport\n";
		print CfgFILE "Telnet_Address : $telnetipadd\n";
		print CfgFILE "Telnet_Uname : $telnetuname\n";
		print CfgFILE "Telnet_Pw : $telnetpw\n";
		print CfgFILE "Telnet_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_POP3"){
		my $pop3header = shift;
		my $pop3verbose = shift;
		my $pop3server = shift;
		my $pop3port = shift;
		my $pop3uname = shift;
		my $pop3pw = shift;
		my $pop3mailindex = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "POP3_PARAMETER_START\n";
		print CfgFILE "POP3_Header : $pop3header\n";
		print CfgFILE "POP3_Verbose : $pop3verbose\n";
		print CfgFILE "POP3_Server : $pop3server\n";
		print CfgFILE "POP3_Port : $pop3port\n";
		print CfgFILE "POP3_Uname : $pop3uname\n";
		print CfgFILE "POP3_Pw : $pop3pw\n";
		print CfgFILE "POP3_MailIndex : $pop3mailindex\n";
		print CfgFILE "POP3_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_FTP"){
		my $ftpmode = shift;
		my $ftptype = shift;
		my $ftpserver = shift;
		my $ftpport = shift;
		my $ftpuname = shift;
		my $ftppw = shift;
		my $ftpfilesize = shift;
		my $ftpfilename = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "FTP_PARAMETER_START\n";
		print CfgFILE "FTP_Mode : $ftpmode\n";
		print CfgFILE "FTP_Type : $ftptype\n";
		print CfgFILE "FTP_Server : $ftpserver\n";
		print CfgFILE "FTP_Port : $ftpport\n";
		print CfgFILE "FTP_Uname : $ftpuname\n";
		print CfgFILE "FTP_Pw : $ftppw\n";
		print CfgFILE "FTP_FileSize : $ftpfilesize\n";
		print CfgFILE "FTP_FileName : $ftpfilename\n";
		print CfgFILE "FTP_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_HTTP"){
		my $httpserver = shift;
		my $httppage = shift;
		my $httplogin = shift;
		my $httpport = shift;
		my $httpuname = shift;
		my $httppw = shift;
		
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "HTTP_PARAMETER_START\n";
		print CfgFILE "HTTP_Server : $httpserver\n";
		print CfgFILE "HTTP_Page : $httppage\n";
		print CfgFILE "HTTP_Login : $httplogin\n";
		print CfgFILE "HTTP_Port : $httpport\n";
		print CfgFILE "HTTP_Uname : $httpuname\n";
		print CfgFILE "HTTP_Pw : $httppw\n";
	
		print CfgFILE "HTTP_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_DNS"){
		my $dnsserv1 = shift;
		my $dnsserv2 = shift;
		my $domainname1 = shift;
		my $domainname2 = shift;
		my $domainname3 = shift;
		my $domainname4 = shift;
		my $domainname5 = shift;
		my $domainname6 = shift;
		my $domainname7 = shift;
		my $domainname8 = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "DNS_PARAMETER_START\n";
		print CfgFILE "DNS_SER1 : $dnsserv1\n";
		print CfgFILE "DNS_SER2 : $dnsserv2\n";
		print CfgFILE "Domain_Name1 : $domainname1\n";
		print CfgFILE "Domain_Name2 : $domainname2\n";
		print CfgFILE "Domain_Name3 : $domainname3\n";
		print CfgFILE "Domain_Name4 : $domainname4\n";
		print CfgFILE "Domain_Name5 : $domainname5\n";
		print CfgFILE "Domain_Name6 : $domainname6\n";
		print CfgFILE "Domain_Name7 : $domainname7\n";
		print CfgFILE "Domain_Name8 : $domainname8\n";
		print CfgFILE "DNS_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ADKREG_SMTP"){
		my $smtpverbose = shift;
		my $smtpserver = shift;
		my $smtpport = shift;
		my $smtpuname = shift;
		my $smtppwd = shift;
		my $smtpsendername = shift;
		my $smtpsendernameaddr = shift;
		my $smtpccaddr = shift;
		my $smtpdomainname = shift;
		my $smtpreciveraddr = shift;
		my $smtpsubj = shift;
		my $smtpmailbody = shift;
		my $smtpfilesize = shift;
		my $smtpfilename = shift;
		my $smtpattachoption = shift;
		print "Printing attachmention-----------$smtpattachoption\n";
		if($smtpattachoption eq "yes"){
			open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
			if($errorText ne ''){return;}
			print CfgFILE "SMTP_PARAMETER_START\n";
			print CfgFILE "SMTP_Verbose : $smtpverbose\n";
			print CfgFILE "SMTP_Server : $smtpserver\n";
			print CfgFILE "SMTP_Port : $smtpport\n";
			print CfgFILE "SMTP_Uname : $smtpuname\n";
			print CfgFILE "SMTP_Pwd : $smtppwd\n";
			print CfgFILE "SMTP_SenderName : $smtpsendername\n";
			print CfgFILE "SMTP_SenderEmailAddr : $smtpsendernameaddr\n";
			print CfgFILE "SMTP_CCAddr : $smtpccaddr\n";
			print CfgFILE "SMTP_DomainName : $smtpdomainname\n";
			print CfgFILE "SMTP_ReciverAddr : $smtpreciveraddr\n";
			print CfgFILE "SMTP_Subj : $smtpsubj\n";
			print CfgFILE "SMTP_MailBody : $smtpmailbody\n";
			print CfgFILE "Do u want attach : $smtpattachoption\n";
			print CfgFILE "SMTP_FileSize : $smtpfilesize\n";
			print CfgFILE "SMTP_FileName : $smtpfilename\n";
			print CfgFILE "SMTP_PARAMETER_END\n\n";
			close(CfgFILE);
		}
		else{
			open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
			if($errorText ne ''){return;}
			print CfgFILE "SMTP_PARAMETER_START\n";
			print CfgFILE "SMTP_Verbose : $smtpverbose\n";
			print CfgFILE "SMTP_Server : $smtpserver\n";
			print CfgFILE "SMTP_Port : $smtpport\n";
			print CfgFILE "SMTP_Uname : $smtpuname\n";
			print CfgFILE "SMTP_Pwd : $smtppwd\n";
			print CfgFILE "SMTP_SenderName : $smtpsendername\n";
			print CfgFILE "SMTP_SenderEmailAddr : $smtpsendernameaddr\n";
			print CfgFILE "SMTP_CCAddr : $smtpccaddr\n";
			print CfgFILE "SMTP_DomainName : $smtpdomainname\n";
			print CfgFILE "SMTP_ReciverAddr : $smtpreciveraddr\n";
			print CfgFILE "SMTP_Subj : $smtpsubj\n";
			print CfgFILE "SMTP_MailBody : $smtpmailbody\n";
			print CfgFILE "Do u want attach : $smtpattachoption\n";
			print CfgFILE "SMTP_PARAMETER_END\n\n";
			close(CfgFILE);
		}
	}
	elsif($trafficName eq "FCC"){
		my $domainfcc = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainfcc\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "IC"){
		my $domainic = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainic\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "ETSI"){
		my $domainetsi = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainetsi\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "SPAIN"){
		my $domainspain = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainspain\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "FRANCE"){
		my $domainfrance = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainfrance\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "MKK"){
		my $domainmkk = shift;
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "CountryCode_PARAMETER_START\n";	
		print CfgFILE "CountryCode : $domainmkk\n";
		print CfgFILE "CountryCode_PARAMETER_END\n\n";
		close(CfgFILE);
	}
	elsif($trafficName eq "UDP"){
		my $udpTime = shift;
		my $udpFileSize = shift;
		my $udpBandwidth = shift;
		my $udpInterval = shift;
		my $udpFormat = shift;
		my $udpPktlength = shift;
		my $uptraffic = shift;
		my $dwntraffic = shift;
# 		my $uphostip = shift;
# 		my $dwnhostip = shift;	
		my $passcriteria = shift;
	
		open(CfgFILE,">>$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print CfgFILE "UDP_PARAMETER_START\n";	
		if(($uptraffic == 1)&&($dwntraffic == 1)){
			print CfgFILE "UPLOAD_TRAFFIC : $uptraffic\n";
			print CfgFILE "UP_HOST_IP : $uphostip\n";
			print CfgFILE "DOWNLOAD_TRAFFIC : $dwntraffic\n";
			print CfgFILE "DOWN_HOST_IP : $dwnhostip\n";
		}
		elsif($uptraffic == 1){
			print CfgFILE "UPLOAD_TRAFFIC : $uptraffic\n";
			print CfgFILE "UP_HOST_IP : $uphostip\n";
		}
		elsif($dwntraffic == 1){
			print CfgFILE "DOWNLOAD_TRAFFIC : $dwntraffic\n";
			print CfgFILE "DOWN_HOST_IP : $dwnhostip\n";
		}		
		print CfgFILE "UDP_Time : $udpTime\n";
		print CfgFILE "UDP_Interval : $udpInterval\n";
		print CfgFILE "UDP_Format : $udpFormat\n";
		print CfgFILE "UDP_Filesize : $udpFileSize\n";
		print CfgFILE "UDP_Bandwidth : $udpBandwidth\n";		
		print CfgFILE "UDP_PktLength : $udpPktlength\n";
		print CfgFILE "UDP_Passcriteria : $passcriteria\n";
		print CfgFILE "UDP_PARAMETER_END\n\n";
		close(CfgFILE);
	}
}
#####################################################################################
# Function Name : subBatchTestParam
# Description	: Save seected batch test in a text file
# Called By		: MdlBatchTest
# Argument List :
# Returning Arg : None
#####################################################################################
sub subBatchTestParam
{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	my $tstName = shift;
	my @testList =@_;
		
	open(batchFILE,">$dirPath\\$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
	if($errorText ne ''){return;}
	print batchFILE "Test_Name : $tstName\n\n";
	print batchFILE @testList;
	close(batchFILE);
}
#####################################################################################
# Function Name : subBGWParam
# Description	: Save DRIVER information in BGW211_DUT.conf file
# Called By		: MdlPingTest,MdlRoamTest,MdlThroughputTest
# Argument List :
# Returning Arg : None
#####################################################################################
sub subBGWParam
{
	my $self = shift;
	my $dirPath = shift;
	my $fileName = shift;
	my $arg =shift;
	if($arg eq "Driver"){
		my $DRVName = shift;
		my $SuppName = shift;
	}
	elsif($arg eq "TLS"){	
		my $CA_CERT = shift;
		my $CLIENT_CERT = shift;
		my $PRIVATE_KEY = shift;
		my $IDENTITY = shift;
		my $PRIVATE_KEY_PASSWORD = shift;
	}

	open(dutFILE,"$dirPath\\$fileName") || $self->subErrorHandler("Can't Open directory:$!");
	if($errorText ne ''){return;}
	@arrLine=<dutFILE>;
	close(dutFILE);
	unlink ("$dirPath\\$fileName");
	open(dFILE,">>$dirPath\\$fileName") || $self->subErrorHandler("Can't Open directory:$!");
	if($errorText ne ''){return;}
	foreach $line (@arrLine){
		if($arg eq "Driver"){
			$line=~ s/DRV_NAME=(.*)/DRV_NAME= $DRVName/;
	 		$line=~ s/SUPPLICANT_NAME=(.*)/SUPPLICANT_NAME= $SuppName/;
		}
		elsif($arg eq "TLS"){
			$line=~ s/IDENTITY=(.*)/IDENTITY= $IDENTITY/;
			$line=~ s/CA_CERT=(.*)/CA_CERT= $CA_CERT/;
			$line=~ s/CLIENT_CERT=(.*)/CLIENT_CERT= $CLIENT_CERT/;
			$line=~ s/PRIVATE_KEY=(.*)/PRIVATE_KEY= $PRIVATE_KEY/;
			$line=~ s/PRIVATE_KEY_PASSWORD=(.*)/PRIVATE_KEY_PASSWORD= $PRIVATE_KEY_PASSWORD/;
		}
		print dFILE $line;
	}
	close (dFILE);
}

#####################################################################################
# Function Name : subUpdateTestCase
# Description	: Delete any existing testcase before create a new testcase
# Called By		: MdlPingTest,mdlThroughputtest,MdlRoamTest,MdlnegativeTest
# Argument List :
# Returning Arg : None
#####################################################################################
sub subUpdateTestCase
{
	my $self = shift;
	my $type = shift;
	my $arg = shift;
	$errorText='';
	if($type eq "ping"){$fileName="Ping_".$arg.".txt";}
	elsif($type eq "traffic"){$fileName="Throughput_".$arg.".txt";}
	elsif($type eq "roam"){$fileName="Roam_".$arg.".txt";}
	elsif($type eq "negative"){$fileName="Negative_".$arg.".txt";}
	elsif($type eq "ibss"){$fileName="IBSS_".$arg.".txt";}
	elsif($type eq "ADKREG"){$fileName="ADKREG_".$arg.".txt";}
	opendir(DIR,"$dir_to_open\\TestCase") || $self->subErrorHandler("Can't Open directory:$!");
	if($errorText ne ''){return;}
	my @dir_contents= readdir(DIR);
	closedir(DIR);
	foreach my $file (@dir_contents){
		if(!(($file eq ".") || ($file eq ".."))){
			if($file eq $fileName){			
				unlink "$dir_to_open\\TestCase\\$file";			
			}
		}
	}		
}
#####################################################################################
# Function Name : subDatabaseParam
# Description	: Save new device's details in database
# Called By		: MdlAPMaster,MdlDUTMaster,MdlSTAMaster
# Argument List :
# Returning Arg : None
#####################################################################################
sub subDatabaseParam 
{	print "Inside sub database param block\n";
	my $self = shift;	
	my $fileName = shift;
	print "$fileName\n";	
	my $deviceName = shift;
	$errorText='';
	
	if($deviceName eq "AP" ){
		my $apName = shift;
		my $apFw = shift;
		my $apModel = shift;
		my $apUname = shift;
		my $apPwd = shift;
		my $apMac = shift;
		my $apIPAddr = shift;
		my $apNetmask = shift;
		my $apTLSOption = shift;
		my $apMdlName = shift;
		
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_AP_".$apName."_".$apIPAddr."\n\n";
		print dbFILE "TYPE = AP_$apName\n";
		print dbFILE "NAME = $apName\n";
		print dbFILE "FIRMWARE = $apFw\n";
		print dbFILE "MODEL = $apModel\n"; 
		print dbFILE "LOGIN = $apUname\n";
		print dbFILE "PASSWORD = $apPwd\n";
		print dbFILE "MACADDRESS = $apMac\n";
		print dbFILE "IPADDRESS = $apIPAddr\n";
		print dbFILE "NETMASK = $apNetmask\n";	
		print dbFILE "TLS_SUPPORTED = $apTLSOption\n";
		print dbFILE "MODULE = $apMdlName\n";
		print dbFILE "\nEND_DESCRIPTION_AP_".$apName."_".$apIPAddr."\n";
	}
	
	if($deviceName eq "STA" ){
		my $staName = shift;
		my $staFw = shift;
		my $staModel = shift;
		my $staMac = shift;
		my $staIPAddr = shift;
		my $staNetmask = shift;
		my $staMdlName = shift;
		
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_STA_".$staName."_".$staIPAddr."\n\n";
		print dbFILE "TYPE = STA_$staName\n";
		print dbFILE "NAME = $staName\n";
		print dbFILE "FIRMWARE = $staFw\n";
		print dbFILE "MODEL = $staModel\n"; 
		print dbFILE "MACADDRESS = $staMac\n";
		print dbFILE "IPADDRESS = $staIPAddr\n";
		print dbFILE "NETMASK = $staNetmask\n";	
		print dbFILE "MODULE = $staMdlName\n";
		print dbFILE "\nEND_DESCRIPTION_STA_".$staName."_".$staIPAddr."\n";
	}
	if($deviceName eq "DUT" ){
		my $dutName = shift;
		my $dutFw = shift;
		my $dutModel = shift;
		my $dutUname = shift;
		my $dutPwd = shift;
		my $dutMac = shift;
		my $dutIPAddrLAN = shift;
		my $dutIPAddr = shift;
		my $dutNetmask = shift;
		my $dutInterface= shift;
		my $dutCOM = shift;
		my $dutActive = shift;	
		
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_DUT_".$dutName."_".$dutIPAddr."\n\n";
		print dbFILE "TYPE = DUT_$dutName\n";
		print dbFILE "NAME = $dutName\n";
		print dbFILE "FIRMWARE = $dutFw\n";
		print dbFILE "MODEL = $dutModel\n"; 
		print dbFILE "LOGIN = $dutUname\n";
		print dbFILE "PASSWORD = $dutPwd\n";
		print dbFILE "MACADDRESS = $dutMac\n";
		print dbFILE "IPADDRESS_LAN = $dutIPAddrLAN\n";
		print dbFILE "IPADDRESS = $dutIPAddr\n";
		print dbFILE "NETMASK = $dutNetmask\n";	
		print dbFILE "INTERFACE = $dutInterface\n";	
		print dbFILE "COM_PORT = $dutCOM \n";
# 		if($dutActive == 1){
# 			print dbFILE "CURRENTLY_ACTIVE = y\n";
# 		}
# 		else{
# 			print dbFILE "CURRENTLY_ACTIVE = n\n";
# 		}
		print dbFILE "\nEND_DESCRIPTION_DUT_".$dutName."_".$dutIPAddr."\n";	
	}
	
	if($deviceName eq "WinXP" ){
		my $winlogin = shift;
		my $winpwd = shift;
		my $winMAC = shift;
		my $winIP1 = shift;
		my $winIP2 = shift;
		my $winNetmask1 = shift;
		my $winNetmask2 = shift;
				
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_WINDOW_PC\n\n";		
		print dbFILE "TYPE = WINDOW_PC\n";
		print dbFILE "LOGIN = $winlogin\n";
		print dbFILE "PASSWORD = $winpwd\n";
		print dbFILE "MACADDRESS = $winMAC\n";
		print dbFILE "IPADDRESS_LAN1 = $winIP1\n";
		print dbFILE "NETMASK_LAN1 = $winNetmask1\n";	
		print dbFILE "IPADDRESS_LAN2 = $winIP2\n";
		print dbFILE "NETMASK_LAN2 = $winNetmask2\n";	
		print dbFILE "\nEND_DESCRIPTION_WINDOW_PC\n";
	}
	
	if($deviceName eq "Linux" ){
		my $linlogin = shift;
		my $linpwd = shift;
		my $linMAC = shift;
		my $linIPEth0 = shift;
		my $linIPEth1 = shift;
		my $linNetmasketh0 = shift;
		my $linNetmasketh1 = shift;
		my $linFTPLogin = shift;
		my $linFTPPwd = shift;
				
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_LINUX_PC\n\n";
		print dbFILE "TYPE = LINUX_PC\n";
		print dbFILE "LOGIN = $linlogin\n";
		print dbFILE "PASSWORD = $linpwd\n";
		print dbFILE "MACADDRESS = $linMAC\n";
		print dbFILE "IPADDRESS_ETH0 = $linIPEth0\n";
		print dbFILE "NETMASK_ETH0 = $linNetmasketh0\n";
		print dbFILE "IPADDRESS_ETH1 = $linIPEth1\n";
		print dbFILE "NETMASK_ETH1 = $linNetmasketh1\n";	
		print dbFILE "FTP_LOGIN = $linFTPLogin\n";
		print dbFILE "FTP_PASSWORD = $linFTPPwd\n";
		print dbFILE "\nEND_DESCRIPTION_LINUX_PC\n";
	}
	if($deviceName eq "WPS" ){
		my $wpslogin = shift;
		my $wpspwd = shift;
		my $wpsIP = shift;
		my $wpsNetmask = shift;
		my $wpsoutlet_1 = shift;
		my $wpsoutlet_2 = shift;
		my $wpsoutlet_3 = shift;
		my $wpsoutlet_4 = shift;
		my $wpsoutlet_5 = shift;
		my $wpsoutlet_6 = shift;
		my $wpsoutlet_7 = shift;
		my $wpsoutlet_8 = shift;
				
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_WEB_POWER_SWITCH\n\n";
		print dbFILE "TYPE = WEB_POWER_SWITCH\n"; 
		print dbFILE "LOGIN = $wpslogin\n";
		print dbFILE "PASSWORD = $wpspwd\n";
		print dbFILE "IPADDRESS = $wpsIP\n";
		print dbFILE "NETMASK = $wpsNetmask\n";	
		print dbFILE "OUTLET_1 = $wpsoutlet_1\n";	
		print dbFILE "OUTLET_2=  $wpsoutlet_2\n";	
		print dbFILE "OUTLET_3 = $wpsoutlet_3\n";	
		print dbFILE "OUTLET_4 = $wpsoutlet_4\n";	
		print dbFILE "OUTLET_5 = $wpsoutlet_5\n";	
		print dbFILE "OUTLET_6 = $wpsoutlet_6\n";	
		print dbFILE "OUTLET_7 = $wpsoutlet_7\n";	
		print dbFILE "OUTLET_8 = $wpsoutlet_8\n";
		print dbFILE "\nEND_DESCRIPTION_WEB_POWER_SWITCH\n";
	}
	if($deviceName eq "Radius" ){
		my $radlogin = shift;
		my $radpwd = shift;
		my $radMAC = shift;
		my $radIP = shift;		
		my $radNetmask = shift;
				
		open(dbFILE,">>$fileName") or $self->subErrorHandler("Can't Open file $fileName:$!");
		if($errorText ne ''){return;}
		print dbFILE "\n\nSTART_DESCRIPTION_RADIUS_SERVER\n\n";
		print dbFILE "TYPE = RADIUS_SERVER\n";
		print dbFILE "LOGIN = $radlogin\n";
		print dbFILE "PASSWORD = $radpwd\n";
		print dbFILE "MACADDRESS = $radMAC\n";
		print dbFILE "IPADDRESS = $radIPEth0\n";	
		print dbFILE "NETMASK = $radNetmask\n";	
		print dbFILE "\nEND_DESCRIPTION_RADIUS_SERVER\n";
	}	
	close (dbFILE);
}
#####################################################################################
# Function Name : subUpdateDatabase
# Description	: Delete the information of any AP and STA if previously existing in database 
# Called By		: MdlAPMaster,MdlSTAMaster
# Argument List :
# Returning Arg : None
#####################################################################################
sub subUpdateDatabase
{	
	my $self = shift;
	my $device = shift;
	my $type = shift;
	my $devip = shift;
	my $arrTemp=();
	my $str='';
	$errorText='';
	
	if(defined($devip)){		
		$str="$device"."_"."$type"."_"."$devip";
	}
	else{
		$str=$device."_".$type;
	}
print "Inside subupdatedatabase\n";
print "$dir_to_open\n";
	open (FILE,"< $dir_to_open\\Files\\Setup_Database.txt") or $self->subErrorHandler("Can't Open file:$!");
	if($errorText ne ''){return;}	
	while ( <FILE> ) {		
		if (/START_DESCRIPTION_$str/../END_DESCRIPTION_$str/){
			$arrTemp[0].=$_;			
		}
		else{			
			$arrTemp[1].=$_;
		}
	}
	close(FILE);	
	splice(@arrTemp,0,1);	
	unlink "$dir_to_open\\Files\\Setup_Database.txt";
	open (dFILE," >$dir_to_open\\Files\\Setup_Database.txt") or $self->subErrorHandler("Can't Open file:$!");
	if($errorText ne ''){return;}
	print dFILE @arrTemp;	
	close (dFILE);
}
#####################################################################################
# Function Name : subReportCreater
# Description	: Create HTML report 
# Called By		: TestPing,TestTraffic,TestRoam
# Argument List :
# Returning Arg : Name of the HTML File/A string contains information for HTML File
#####################################################################################
sub subReportCreater
{
	print "inside sub report creator block\n";
	my $self = shift;
	my $test = shift;
	print "$test\n";
	my $testType = shift;
	print "$testType\n";
	my $timeStamp = shift;
    my $tstName = shift; 

    if($testType eq "Ping") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    @configParam = @_;
	}
	elsif($testType eq "Throughput") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    $upTraffic=shift;
	    $dwnTraffic=shift;
	    $upIperfRate=shift;
	    $dwnIperfRate=shift;
	    $passValue=shift;
	    $uploadRemark=shift;
	    $downloadRemark=shift;
	    @configParam = @_;
	}
	elsif($testType eq "Roam") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    @configParam = @_;
	}
	elsif($testType eq "Negative") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    @configParam = @_;
	}
	elsif($testType eq "IBSS") {
		$tstResult=shift;
	    $tstRemark=shift;
		$subtstType=shift;
		if($subtstType eq "Ping"){			
	   	 	@configParam = @_;
		}
		elsif($subtstType eq "Throughput") {		   
		    $upTraffic=shift;
		    $dwnTraffic=shift;
		    $upIperfRate=shift;
		    $dwnIperfRate=shift;
		    $passValue=shift;
		    $uploadRemark=shift;
		    $downloadRemark=shift;
		    @configParam = @_;
		}
		elsif($subtstType eq "Negative") {		   
		    @configParam = @_;
		}
	   
	}
	elsif($testType eq "ADKREG" || $testType eq "ADKREGROAM") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    $testMode=shift;
	    $APType=shift;
		$APSec=shift;
		$APSSID=shift;
		$APChannel=shift;
		$APBeacon=shift;
		$APRts=shift;
		$APFrag=shift;
		$STAUTName=shift;
		$STAUTIP=shift;
		$STAUTSec=shift;
		$STAUTSSID=shift;
		$STAUTChannel=shift;
		$STAUTBeacon=shift;
		$STAUTRts=shift;
		$STAUTFrag=shift;
	}
	elsif($testType eq "ADKREG_IBSS") {
	    $tstResult=shift;
	    $tstRemark=shift;
	    $testMode=shift;
	    $STAName=shift;
	    $STAIPAddr=shift;
		$STASec=shift;
		$STASSID=shift;
		$STAChannel=shift;
		$STABeacon=shift;
		$STARts=shift;
		$STAFrag=shift;
		$STAUTName=shift;
		$STAUTIP=shift;
		$STAUTSec=shift;
		$STAUTSSID=shift;
		$STAUTChannel=shift;
		$STAUTBeacon=shift;
		$STAUTRts=shift;
		$STAUTFrag=shift;
	}
	
    $errorText='';  
   
	if($timeStamp=~/(\d\d\d\d)(\d\d)(\d\d)/){$time=$3."-".$2."-".$1;}
    if($test eq "Single"){
	    my $htmlFileName = $timeStamp ."_".$testType."_".$tstName .".html"; # File name for HTML Report	 
	    open(hFILE,">$dir_to_open/Reports/$htmlFileName") or $self->subErrorHandler("Can't Open file:$!");
	    if($errorText ne ''){return;}
		
		print hFILE "<html>\n";
		print hFILE "<head>\n";
		print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
		print hFILE "<td colspan=14><font color=#800000 size=4 face=Arial><b>$tstName Test Report </b></font></td>\n";
		print hFILE "</TABLE>\n";
		print hFILE "<br />\n";
		print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
		print hFILE "<tr valign=middle><td valign=\middle\ width=\50%\><b>Test Name </b></tr>\n";
		print hFILE "<td align=left >$tstName</td>\n";
		print hFILE "<tr><td><b>Conducted on </b></tr>\n";
		print hFILE "<td align=left >$time</td>\n";
		print hFILE "</TABLE>\n";
		if($testType ne "ADKREGROAM"){
			print hFILE "<TABLE  BORDER=3  CELLSPACING=1 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Test Configuration</b></th>\n";
			if($testType eq "IBSS"){
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>STA Parameters</b></th>\n";
			}
			elsif($testType eq "ADKREG_IBSS"){
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>STA Parameters</b></th>\n";
			}
			else{
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>AP Parameters</b></th>\n";
			}
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>DUT Parameters</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
		 	print hFILE "<td align=right width=\50%\><b>IP Address </b></td>\n";
		 	if($testType eq "Roam" || $testType eq "IBSS"){
	 			print hFILE "<td width=\50%\> $APType</td>\n";
			}
			elsif($testType eq "ADKREG_IBSS"){
	 			print hFILE "<td width=\50%\>$STAName -> $STAIPAddr</td>\n";
	 			print hFILE "<td width=\50%\>$STAUTName -> $STAUTIP</td>\n";
		 	print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Wireless Mode </b></td>\n";
			print hFILE "<td width=\50%\>$testMode</td>\n";
			print hFILE "<td width=\50%\>$testMode</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Security Mode </b></td>\n";
			print hFILE "<td width=\50%\>$STASec</td>\n";
			print hFILE "<td width=\50%\>$STAUTSec</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>SSID </b></td>\n";
			print hFILE "<td width=\50%\>$STASSID</td>\n";
			print hFILE "<td width=\50%\>$STAUTSSID</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Channel </b></td>\n";
			print hFILE "<td width=\50%\>$STAChannel</td>\n";
			print hFILE "<td width=\50%\>$STAUTChannel</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Beacon </b></td>\n";
			print hFILE "<td width=\50%\>$STABeacon</td>\n";
			print hFILE "<td width=\50%\>$STAUTBeacon</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>RTS </b></td>\n";
			print hFILE "<td width=\50%\>$STARts</td>\n";
			print hFILE "<td width=\50%\>$STAUTRts</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Frag </b></td>\n";
			print hFILE "<td width=\50%\>$STAFrag</td>\n";
			print hFILE "<td width=\50%\>$STAUTFrag</td>\n";
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
			}
			else{
				print hFILE "<td width=\50%\>$APType</td>\n";
			
		 	print hFILE "<td width=\50%\>$STAUTName -> $STAUTIP</td>\n";
		 	print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Wireless Mode </b></td>\n";
			print hFILE "<td width=\50%\>$testMode</td>\n";
			print hFILE "<td width=\50%\>$testMode</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Security Mode </b></td>\n";
			print hFILE "<td width=\50%\>$APSec</td>\n";
			print hFILE "<td width=\50%\>$STAUTSec</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>SSID </b></td>\n";
			print hFILE "<td width=\50%\>$APSSID</td>\n";
			print hFILE "<td width=\50%\>$STAUTSSID</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Channel </b></td>\n";
			print hFILE "<td width=\50%\>$APChannel</td>\n";
			print hFILE "<td width=\50%\>$STAUTChannel</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Beacon </b></td>\n";
			print hFILE "<td width=\50%\>$APBeacon</td>\n";
			print hFILE "<td width=\50%\>$STAUTBeacon</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>RTS </b></td>\n";
			print hFILE "<td width=\50%\>$APRts</td>\n";
			print hFILE "<td width=\50%\>$STAUTRts</td>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr align=middle >\n";
			print hFILE "<td align=right width=\50%\><b>Frag </b></td>\n";
			print hFILE "<td width=\50%\>$APFrag</td>\n";
			print hFILE "<td width=\50%\>$STAUTFrag</td>\n";
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}
		}
		print hFILE "<br/>\n";
		if($testType eq "Ping"){
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr width=30% align=left >\n";
			print hFILE "<td ><ol> Step :\n";
			print hFILE "<li>Configure the AP in $configParam[0] with $configParam[2] Security\n";
			print hFILE "<li>Associate the AP with DUT\n";
			print hFILE "<li>Run Ping from DUT and AP\n";
			print hFILE "</ol> \n";
			print hFILE "</td>\n";
			if($tstResult eq "PASS"){
				print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}
		elsif($testType eq "Throughput"){	
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Pass Criteria</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Throughput Rate</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			if(($upTraffic == 1)&&($dwnTraffic==1)){
				print hFILE "<tr width=50% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>UPLOAD of file<br>\n";
				print hFILE "File Receiver : AP<br>\n";
				print hFILE "File transmitter : DUT	\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($passValue ne ''){
					print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}
				if($upIperfRate ne ''){
					print hFILE "<td width=10% align=middle>$upIperfRate</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($uploadRemark eq "N.A"){
						print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}									
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					print hFILE "<td width=25% align=middle>$uploadRemark</td>\n";
				}
				else{
					print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
				}
				print hFILE "</tr>\n";
				print hFILE "<tr width=50% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>DOWNLOAD of file<br>\n";
				print hFILE "File Receiver : DUT<br>\n";
				print hFILE "File transmitter : AP	\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($passValue ne ''){
					print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}
				if($dwnIperfRate ne ''){
					print hFILE "<td width=10% align=middle>$dwnIperfRate</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($downloadRemark eq "N.A"){
						print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					print hFILE "<td width=25% align=middle>$downloadRemark</td>\n";
				}
				else{
					print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
				}		
				print hFILE "</tr>\n";
			}
			elsif($upTraffic == 1){
				print hFILE "<tr width=50% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>UPLOAD of file<br>\n";
				print hFILE "File Receiver : AP<br>\n";
				print hFILE "File transmitter : DUT	\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($passValue ne ''){
					print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}
				if($upIperfRate ne ''){
					print hFILE "<td width=10% align=middle>$upIperfRate</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($uploadRemark eq "N.A"){
						print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}									
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					print hFILE "<td width=25% align=middle>$uploadRemark</td>\n";
				}
				else{
					print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
				}
				print hFILE "</tr>\n";
			}
			elsif($dwnTraffic==1){
				print hFILE "<tr width=50% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>DOWNLOAD of file<br>\n";
				print hFILE "File Receiver : DUT<br>\n";
				print hFILE "File transmitter : AP	\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($passValue ne ''){
					print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}
				if($dwnIperfRate ne ''){
					print hFILE "<td width=10% align=middle>$dwnIperfRate</td>\n";
				}
				else{
					print hFILE "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($downloadRemark eq "N.A"){
						print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}				
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					print hFILE "<td width=25% align=middle>$downloadRemark</td>\n";
				}
				else{
					print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
				}
				print hFILE "</tr>\n";
			}
			print hFILE "</TABLE>\n";
		}	
		elsif($testType eq "Roam"){
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr width=40% align=left >\n";
			print hFILE "<td ><ol> Step :\n";
			print hFILE "<li>Configure all the AP and DUT.\n";
			print hFILE "<li>Power off all AP.\n";
			print hFILE "<li>Power on AP1.\n";
			print hFILE "<li>Associate the DUT with AP1\n";
			print hFILE "<li>Check ping between DUT with AP1\n";
			print hFILE "<li>Continue step 3-5 for subsequent APs.\n";
			print hFILE "</ol> \n";
			print hFILE "</td>\n";
			if($tstResult eq "PASS"){
				print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
			}
			elsif($tstResult eq "FAIL"){
				print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			print hFILE "<td width=25% align=middle>$tstRemark</td>\n";	
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}
		elsif($testType eq "Negative"){
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr width=40% align=left >\n";
			print hFILE "<td ><ol> Step :\n";
			print hFILE "<li>Configure the AP in $configParam[0]\n";
			print hFILE "<li>Associate the AP with DUT\n";
			print hFILE "<li>Run Ping from DUT and AP\n";
			print hFILE "<li>Ping should not happen between AP and DUT.\n";
			print hFILE "</ol> \n";
			print hFILE "</td>\n";
			if($tstResult eq "PASS"){
				print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}	
		elsif($testType eq "IBSS"){
			if($subtstType eq "Ping"){
				print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				print hFILE "</tr>\n";
				print hFILE "<tr width=30% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>Configure the STA and DUT\n";
				print hFILE "<li>Associate the STA with DUT\n";
				print hFILE "<li>Run Ping from DUT and STA\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($tstResult eq "PASS"){
					print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
				print hFILE "</tr>\n";
				print hFILE "</TABLE>\n";
			}
			elsif($subtstType eq "Throughput"){	
				print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Pass Criteria</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Throughput Rate</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				print hFILE "</tr>\n";
				if(($upTraffic == 1)&&($dwnTraffic==1)){
					print hFILE "<tr width=50% align=left >\n";
					print hFILE "<td ><ol> Step :\n";
					print hFILE "<li>UPLOAD of file<br>\n";
					print hFILE "File Receiver : AP<br>\n";
					print hFILE "File transmitter : DUT	\n";
					print hFILE "</ol> \n";
					print hFILE "</td>\n";
					if($passValue ne ''){
						print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}
					if($upIperfRate ne ''){
						print hFILE "<td width=10% align=middle>$upIperfRate</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($uploadRemark eq "N.A"){
							print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}									
					}
					elsif($tstResult eq "FAIL"){
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						print hFILE "<td width=25% align=middle>$uploadRemark</td>\n";
					}
					else{
						print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
					}
					print hFILE "</tr>\n";
					print hFILE "<tr width=50% align=left >\n";
					print hFILE "<td ><ol> Step :\n";
					print hFILE "<li>DOWNLOAD of file<br>\n";
					print hFILE "File Receiver : DUT<br>\n";
					print hFILE "File transmitter : AP	\n";
					print hFILE "</ol> \n";
					print hFILE "</td>\n";
					if($passValue ne ''){
						print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}
					if($dwnIperfRate ne ''){
						print hFILE "<td width=10% align=middle>$dwnIperfRate</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($downloadRemark eq "N.A"){
							print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}	
					}
					elsif($tstResult eq "FAIL"){
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						print hFILE "<td width=25% align=middle>$downloadRemark</td>\n";
					}
					else{
						print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
					}		
					print hFILE "</tr>\n";
				}
				elsif($upTraffic == 1){
					print hFILE "<tr width=50% align=left >\n";
					print hFILE "<td ><ol> Step :\n";
					print hFILE "<li>UPLOAD of file<br>\n";
					print hFILE "File Receiver : AP<br>\n";
					print hFILE "File transmitter : DUT	\n";
					print hFILE "</ol> \n";
					print hFILE "</td>\n";
					if($passValue ne ''){
						print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}
					if($upIperfRate ne ''){
						print hFILE "<td width=10% align=middle>$upIperfRate</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($uploadRemark eq "N.A"){
							print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}									
					}
					elsif($tstResult eq "FAIL"){
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						print hFILE "<td width=25% align=middle>$uploadRemark</td>\n";
					}
					else{
						print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
					}
					print hFILE "</tr>\n";
				}
				elsif($dwnTraffic==1){
					print hFILE "<tr width=50% align=left >\n";
					print hFILE "<td ><ol> Step :\n";
					print hFILE "<li>DOWNLOAD of file<br>\n";
					print hFILE "File Receiver : DUT<br>\n";
					print hFILE "File transmitter : AP	\n";
					print hFILE "</ol> \n";
					print hFILE "</td>\n";
					if($passValue ne ''){
						print hFILE "<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}
					if($dwnIperfRate ne ''){
						print hFILE "<td width=10% align=middle>$dwnIperfRate</td>\n";
					}
					else{
						print hFILE "<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($downloadRemark eq "N.A"){
							print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}				
					}
					elsif($tstResult eq "FAIL"){
						print hFILE "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						print hFILE "<td width=25% align=middle>$downloadRemark</td>\n";
					}
					else{
						print hFILE "<td width=25% align=middle>$tstRemark</td>\n";
					}
					print hFILE "</tr>\n";
				}
				print hFILE "</TABLE>\n";
			}		
			elsif($subtstType eq "Negative"){
				print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				print hFILE "</tr>\n";
				print hFILE "<tr width=40% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>Configure the AP in $configParam[0]\n";
				print hFILE "<li>Associate the AP with DUT\n";
				print hFILE "<li>Run Ping from DUT and AP\n";
				print hFILE "<li>Ping should not happen between AP and DUT.\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($tstResult eq "PASS"){
					print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
				print hFILE "</tr>\n";
				print hFILE "</TABLE>\n";
			}				
		}
		elsif($testType eq "ADKREG_IBSS"){
				print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				print hFILE "</tr>\n";
				print hFILE "<tr width=30% align=left >\n";
				print hFILE "<td ><ol> Step :\n";
				print hFILE "<li>Configure the STA in $testMode with $STASec Security\n";
				print hFILE "<li>Configure the DUT using AT commands\n";
				print hFILE "<li>Associate the STA with DUT\n";
				print hFILE "<li>Run Ping between DUT and STA\n";
				print hFILE "</ol> \n";
				print hFILE "</td>\n";
				if($tstResult eq "PASS"){
					print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
				print hFILE "</tr>\n";
				print hFILE "</TABLE>\n";
			}
		elsif($testType eq "ADKREG"){
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr width=30% align=left >\n";
			print hFILE "<td ><ol> Step :\n";
			print hFILE "<li>Configure the AP in $testMode with $APSec Security\n";
			print hFILE "<li>Configure the DUT using AT commands\n";
			print hFILE "<li>Associate the AP with DUT\n";
			print hFILE "<li>Check Ping between DUT and AP\n";
			print hFILE "</ol> \n";
			print hFILE "</td>\n";
			if($tstResult eq "PASS"){
				print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}
		elsif($testType eq "ADKREGROAM"){
			print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			print hFILE "</tr>\n";
			print hFILE "<tr width=30% align=left >\n";
			print hFILE "<td ><ol> Step :\n";
			print hFILE "<li>Configure all the AP.\n";
			print hFILE "<li>Power off all AP.\n";
			print hFILE "<li>Power on AP1.\n";
			print hFILE "<li>Configure the DUT and associate with AP1\n";
			print hFILE "<li>Check ping between DUT with AP1\n";
			print hFILE "<li>Continue step 3-5 for subsequent APs for 5 Iteration.\n";
			print hFILE "</ol> \n";
			print hFILE "</td>\n";
			if($tstResult eq "PASS"){
				print hFILE "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				print hFILE "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			print hFILE "<td width=25% align=middle>$tstRemark</td>\n";			
			print hFILE "</tr>\n";
			print hFILE "</TABLE>\n";
		}
		print hFILE "</html>\n";
		close(hFILE);    
	
		return($htmlFileName);   
	}
	elsif($test eq "Multiple"){
		print "Inside Multiple block\n";
		my $string='';
		
		$string.="<html>\n";
		$string.="<head>\n";
		$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
		$string.= "<td colspan=14><font color=#800000 size=4 face=Arial><b>$tstName Test Report </b></font></td>\n";
		$string.= "</TABLE>\n";
		$string.= "<br />\n";
		$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
		$string.= "<tr valign=middle><td valign=\middle\ width=\50%\><b>Test Name </b></tr>\n";
		$string.= "<td align=left >$tstName</td>\n";
		$string.= "<tr><td><b>Conducted on </b></tr>\n";
		$string.= "<td align=left >$time</td>\n";
		$string.= "</TABLE>\n";
		if($testType ne "ADKREGROAM"){
			$string.= "<TABLE  BORDER=3  CELLSPACING=1 ALIGN='CENTER' WIDTH=50%>\n";
			$string.= "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.="<th ><font color=#800000 size='2' face='Arial'><b>Test Configuration</b></th>\n";
			if($testType eq "IBSS"){
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>STA Parameters</b></th>\n";
			}
			elsif($testType eq "ADKREG_IBSS"){
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>STA Parameters</b></th>\n";
			}
			else{
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>AP Parameters</b></th>\n";
			}
			
			$string.="<th ><font color=#800000 size='2' face='Arial'><b>DUT Parameters</b></th>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
		 	$string.= "<td align=right width=\50%\><b>IP Address </b></td>\n";
		 	if($testType eq "Roam" || $testType eq "IBSS"){
	 			print hFILE "<td width=\50%\> $APType</td>\n";
			}
			elsif($testType eq "ADKREG_IBSS"){
	 		$string.= "<td width=\50%\>$STAName -> $STAIPAddr</td>\n";
	 		$string.= "<td width=\50%\>$STAUTName -> $STAUTIP</td>\n";
		 	$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Wireless Mode </b></td>\n";
			$string.= "<td width=\50%\>$testMode</td>\n";
			$string.= "<td width=\50%\>$testMode</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Security Mode </b></td>\n";
			$string.= "<td width=\50%\>$STASec</td>\n";
			$string.= "<td width=\50%\>$STAUTSec</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>SSID </b></td>\n";
			$string.= "<td width=\50%\>$STASSID</td>\n";
			$string.= "<td width=\50%\>$STAUTSSID</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Channel </b></td>\n";
			$string.= "<td width=\50%\>$STAChannel</td>\n";
			$string.= "<td width=\50%\>$STAUTChannel</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Beacon </b></td>\n";
			$string.= "<td width=\50%\>$STABeacon</td>\n";
			$string.= "<td width=\50%\>$STAUTBeacon</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>RTS </b></td>\n";
			$string.= "<td width=\50%\>$STARts</td>\n";
			$string.= "<td width=\50%\>$STAUTRts</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Frag </b></td>\n";
			$string.= "<td width=\50%\>$STAFrag</td>\n";
			$string.= "<td width=\50%\>$STAUTFrag</td>\n";
			$string.= "</tr>\n";
			$string.= "</TABLE>\n";
			}
			else{
		 	$string.= "<td width=\50%\>$APType</td>\n";
		 	$string.= "<td width=\50%\>$STAUTName -> $STAUTIP</td>\n";
		 	$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Wireless Mode </b></td>\n";
			$string.= "<td width=\50%\>$testMode</td>\n";
			$string.= "<td width=\50%\>$testMode</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Security Mode </b></td>\n";
			$string.= "<td width=\50%\>$APSec</td>\n";
			$string.= "<td width=\50%\>$STAUTSec</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>SSID </b></td>\n";
			$string.= "<td width=\50%\>$APSSID</td>\n";
			$string.= "<td width=\50%\>$STAUTSSID</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Channel </b></td>\n";
			$string.= "<td width=\50%\>$APChannel</td>\n";
			$string.= "<td width=\50%\>$STAUTChannel</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Beacon </b></td>\n";
			$string.= "<td width=\50%\>$APBeacon</td>\n";
			$string.= "<td width=\50%\>$STAUTBeacon</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>RTS </b></td>\n";
			$string.= "<td width=\50%\>$APRts</td>\n";
			$string.= "<td width=\50%\>$STAUTRts</td>\n";
			$string.= "</tr>\n";
			$string.= "<tr align=middle >\n";
			$string.= "<td align=right width=\50%\><b>Frag </b></td>\n";
			$string.= "<td width=\50%\>$APFrag</td>\n";
			$string.= "<td width=\50%\>$STAUTFrag</td>\n";
			$string.= "</tr>\n";
			$string.= "</TABLE>\n";
		}
		}
 		$string.= "<br/>\n";
		if($testType eq "Ping"){
			$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.=  "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.=  "</tr>\n";
			$string.=  "<tr width=30% align=left >\n";
			$string.=  "<td ><ol> Step :\n";
			$string.=  "<li>Configure the AP in $configParam[0] with $configParam[2] Security\n";
			$string.=  "<li>Associate the AP with DUT\n";
			$string.=  "<li>Run Ping from DUT and AP\n";
			$string.=  "</ol> \n";
			$string.=  "</td>\n";
			if($tstResult eq "PASS"){
				$string.=  "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				$string.=  "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			$string.= "<td width=25% align=middle>$tstRemark</td>\n";			
			$string.= "</tr>\n";
			$string.= "</TABLE>\n";
		}
		elsif($testType eq "Throughput"){	
			$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.= "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.="<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Pass Criteria</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Throughput Rate</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.= "</tr>\n";
			if(($upTraffic == 1)&&($dwnTraffic==1)){
				$string.= "<tr width=50% align=left >\n";
				$string.= "<td ><ol> Step :\n";
				$string.= "<li>UPLOAD of file<br>\n";
				$string.= "File Receiver : AP<br>\n";
				$string.= "File transmitter : DUT	\n";
				$string.= "</ol> \n";
				$string.= "</td>\n";
				if($passValue ne ''){
					$string.="<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}
				if($upIperfRate ne ''){
					$string.= "<td width=10% align=middle>$upIperfRate</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($uploadRemark eq "N.A"){
						$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}		
				}
				elsif($tstResult eq "FAIL"){
					$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					$string.= "<td width=25% align=middle>$uploadRemark</td>\n";
				}
				else{
					$string.= "<td width=25% align=middle>$tstRemark</td>\n";
				}
				$string.= "</tr>\n";
				$string.= "<tr width=50% align=left >\n";
				$string.= "<td ><ol> Step :\n";
				$string.= "<li>DOWNLOAD of file<br>\n";
				$string.= "File Receiver : DUT<br>\n";
				$string.= "File transmitter : AP	\n";
				$string.= "</ol> \n";
				$string.= "</td>\n";
				if($passValue ne ''){
					$string.= "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}
				if($dwnIperfRate ne ''){
					$string.= "<td width=10% align=middle>$dwnIperfRate</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($downloadRemark eq "N.A"){
						$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}							
				}
				elsif($tstResult eq "FAIL"){
					$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					$string.= "<td width=25% align=middle>$downloadRemark</td>\n";
				}
				else{
					$string.= "<td width=25% align=middle>$tstRemark</td>\n";
				}		
				$string.= "</tr>\n";
			}
			elsif($upTraffic == 1){
				$string.="<tr width=50% align=left >\n";
				$string.= "<td ><ol> Step :\n";
				$string.= "<li>UPLOAD of file<br>\n";
				$string.= "File Receiver : AP<br>\n";
				$string.= "File transmitter : DUT	\n";
				$string.= "</ol> \n";
				$string.= "</td>\n";
				if($passValue ne ''){
					$string.= "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}
				if($upIperfRate ne ''){
					$string.= "<td width=10% align=middle>$upIperfRate</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($uploadRemark eq "N.A"){
						$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}
				}
				elsif($tstResult eq "FAIL"){
					$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					$string.= "<td width=25% align=middle>$uploadRemark</td>\n";
				}
				else{
					$string.= "<td width=25% align=middle>$tstRemark</td>\n";
				}
				$string.= "</tr>\n";
			}
			elsif($dwnTraffic==1){
				$string.= "<tr width=50% align=left >\n";
				$string.= "<td ><ol> Step :\n";
				$string.= "<li>DOWNLOAD of file<br>\n";
				$string.= "File Receiver : DUT<br>\n";
				$string.= "File transmitter : AP	\n";
				$string.= "</ol> \n";
				$string.= "</td>\n";
				if($passValue ne ''){
					$string.= "<td width=10% align=middle>$passValue Mbps</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}
				if($dwnIperfRate ne ''){
					$string.= "<td width=10% align=middle>$dwnIperfRate</td>\n";
				}
				else{
					$string.= "<td width=10% align=middle>N.A</td>\n";
				}				
				if($tstResult eq "PASS"){
					if($downloadRemark eq "N.A"){
						$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
					}	
					else{
						$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}								
				}
				elsif($tstResult eq "FAIL"){
					$string.= "<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
				}	
				if($tstRemark eq "N.A"){		
					$string.= "<td width=25% align=middle>$downloadRemark</td>\n";
				}
				else{
					$string.= "<td width=25% align=middle>$tstRemark</td>\n";
				}
				$string.= "</tr>\n";
			}
			$string.= "</TABLE>\n";
		}
		elsif($testType eq "Roam"){
			$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.= "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.= "</tr>\n";
			$string.= "<tr width=40% align=left >\n";
			$string.= "<td ><ol> Step :\n";
			$string.="<li>Configure all the AP and DUT.\n";
			$string.= "<li>Power off all AP.\n";
			$string.="<li>Power on AP1.\n";
			$string.="<li>Associate the DUT with AP1\n";
			$string.="<li>Check ping between DUT with AP1\n";
			$string.= "<li>Continue step 3-5 for subsequent APs.\n";
			$string.="</ol> \n";
			$string.= "</td>\n";
			if($tstResult eq "PASS"){
				$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				$string.= "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			$string.="<td width=25% align=middle>$tstRemark</td>\n";	
			$string.="</tr>\n";
			$string.= "</TABLE>\n";
		}
		elsif($testType eq "Negative"){
			$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.= "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.= "</tr>\n";
			$string.= "<tr width=40% align=left >\n";
			$string.= "<td ><ol> Step :\n";
			$string.= "<li>Configure the AP in $configParam[0]\n";
			$string.= "<li>Associate the AP with DUT\n";
			$string.= "<li>Run Ping from DUT and AP\n";
			$string.= "<li>Ping should not happen between AP and DUT.\n";
			$string.= "</ol> \n";
			$string.= "</td>\n";
			if($tstResult eq "PASS"){
				$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				$string.="<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			$string.= "<td width=25% align=middle>$tstRemark</td>\n";			
			$string.= "</tr>\n";
			$string.= "</TABLE>\n";
		}	
		elsif($testType eq "IBSS"){
			if($subtstType eq "Ping"){
				$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				$string.="<tr valign=\middle\ bgcolor=#6699FF >\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				$string.="</tr>\n";
				$string.="<tr width=30% align=left >\n";
				$string.="<td ><ol> Step :\n";
				$string.="<li>Configure the STA and DUT\n";
				$string.="<li>Associate the STA with DUT\n";
				$string.="<li>Run Ping from DUT and STA\n";
				$string.="</ol> \n";
				$string.="</td>\n";
				if($tstResult eq "PASS"){
					$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					$string.="<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				$string.="<td width=25% align=middle>$tstRemark</td>\n";			
				$string.="</tr>\n";
				$string.="</TABLE>\n";
			}
			elsif($subtstType eq "Throughput"){	
				$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				$string.="<tr valign=\middle\ bgcolor=#6699FF >\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Pass Criteria</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Throughput Rate</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				$string.="</tr>\n";
				if(($upTraffic == 1)&&($dwnTraffic==1)){
					$string.="<tr width=50% align=left >\n";
					$string.="<td ><ol> Step :\n";
					$string.="<li>UPLOAD of file<br>\n";
					$string.="File Receiver : STA<br>\n";
					$string.="File transmitter : DUT	\n";
					$string.="</ol> \n";
					$string.="</td>\n";
					if($passValue ne ''){
						$string.="<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}
					if($upIperfRate ne ''){
						$string.="<td width=10% align=middle>$upIperfRate</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($uploadRemark eq "N.A"){
							$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}									
					}
					elsif($tstResult eq "FAIL"){
						$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						$string.="<td width=25% align=middle>$uploadRemark</td>\n";
					}
					else{
						$string.="<td width=25% align=middle>$tstRemark</td>\n";
					}
					$string.="</tr>\n";
					$string.="<tr width=50% align=left >\n";
					$string.="<td ><ol> Step :\n";
					$string.="<li>DOWNLOAD of file<br>\n";
					$string.="File Receiver : DUT<br>\n";
					$string.="File transmitter : STA	\n";
					$string.="</ol> \n";
					$string.="</td>\n";
					if($passValue ne ''){
						$string.="<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}
					if($dwnIperfRate ne ''){
						$string.="<td width=10% align=middle>$dwnIperfRate</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($downloadRemark eq "N.A"){
							$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}	
					}
					elsif($tstResult eq "FAIL"){
						$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						$string.="<td width=25% align=middle>$downloadRemark</td>\n";
					}
					else{
						$string.="<td width=25% align=middle>$tstRemark</td>\n";
					}		
					$string.="</tr>\n";
				}
				elsif($upTraffic == 1){
					$string.="<tr width=50% align=left >\n";
					$string.="<td ><ol> Step :\n";
					$string.="<li>UPLOAD of file<br>\n";
					$string.="File Receiver : STA<br>\n";
					$string.="File transmitter : DUT	\n";
					$string.="</ol> \n";
					$string.="</td>\n";
					if($passValue ne ''){
						$string.="<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}
					if($upIperfRate ne ''){
						$string.="<td width=10% align=middle>$upIperfRate</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($uploadRemark eq "N.A"){
							$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}									
					}
					elsif($tstResult eq "FAIL"){
						$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						$string.="<td width=25% align=middle>$uploadRemark</td>\n";
					}
					else{
						$string.="<td width=25% align=middle>$tstRemark</td>\n";
					}
					$string.="</tr>\n";
				}
				elsif($dwnTraffic==1){
					$string.="<tr width=50% align=left >\n";
					$string.="<td ><ol> Step :\n";
					$string.="<li>DOWNLOAD of file<br>\n";
					$string.="File Receiver : DUT<br>\n";
					$string.="File transmitter : STA	\n";
					$string.="</ol> \n";
					$string.="</td>\n";
					if($passValue ne ''){
						$string.="<td width=10% align=middle>$passValue Mbps</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}
					if($dwnIperfRate ne ''){
						$string.="<td width=10% align=middle>$dwnIperfRate</td>\n";
					}
					else{
						$string.="<td width=10% align=middle>N.A</td>\n";
					}				
					if($tstResult eq "PASS"){
						if($downloadRemark eq "N.A"){
							$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";		
						}	
						else{
							$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
						}				
					}
					elsif($tstResult eq "FAIL"){
						$string.="<td width=15% align=middle><font color=red><b>FAIL</b></td>\n";
					}	
					if($tstRemark eq "N.A"){		
						$string.="<td width=25% align=middle>$downloadRemark</td>\n";
					}
					else{
						$string.="<td width=25% align=middle>$tstRemark</td>\n";
					}
					$string.="</tr>\n";
				}
				$string.="</TABLE>\n";
			}		
			elsif($subtstType eq "Negative"){
				$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				$string.="<tr valign=\middle\ bgcolor=#6699FF >\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				$string.="<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				$string.="</tr>\n";
				$string.="<tr width=40% align=left >\n";
				$string.="<td ><ol> Step :\n";
				$string.="<li>Configure the STA in $configParam[0]\n";
				$string.="<li>Associate the STA with DUT\n";
				$string.="<li>Run Ping from DUT and STA\n";
				$string.="<li>Ping should not happen between DUT and DUT.\n";
				$string.="</ol> \n";
				$string.="</td>\n";
				if($tstResult eq "PASS"){
					$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					$string.="<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				$string.="<td width=25% align=middle>$tstRemark</td>\n";			
				$string.="</tr>\n";
				$string.="</TABLE>\n";
			}			
		}
		elsif($testType eq "ADKREG_IBSS"){
				$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
				$string.= "<tr valign=\middle\ bgcolor=#6699FF >\n";
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
				$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
				$string.= "</tr>\n";
				$string.= "<tr width=30% align=left >\n";
				$string.= "<td ><ol> Step :\n";
				$string.= "<li>Configure the STA in $testMode with $STASec Security\n";
				$string.= "<li>Configure the DUT using AT commands\n";
				$string.= "<li>Associate the STA with DUT\n";
				$string.= "<li>Run Ping between DUT and STA\n";
				$string.= "</ol> \n";
				$string.= "</td>\n";
				if($tstResult eq "PASS"){
					$string.="<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
					
				}
				elsif($tstResult eq "FAIL"){
					$string.= "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
				}
				$string.= "<td width=25% align=middle>$tstRemark</td>\n";			
				$string.= "</tr>\n";
				$string.= "</TABLE>\n";
			}
		elsif($testType eq "ADKREG"){
			print "Inside ADREG block of report\n";
			$string.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.=  "<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.=  "</tr>\n";
			$string.=  "<tr width=30% align=left >\n";
			$string.=  "<td ><ol> Step :\n";
			$string.=  "<li>Configure the AP in $testMode with $APSec Security\n";
			$string.=  "<li>Configure the DUT using AT commands\n";
			$string.=  "<li>Associate the AP with DUT\n";
			$string.=  "<li>Check Ping between DUT and AP\n";
			$string.=  "</ol> \n";
			$string.=  "</td>\n";
			if($tstResult eq "PASS"){
				$string.=  "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				$string.=  "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			$string.= "<td width=25% align=middle>$tstRemark</td>\n";			
			$string.= "</tr>\n";
# 			$string.= "</TABLE>\n";
		}	
		elsif($testType eq "ADKREGROAM"){
			print "Inside ADKROAM Block of report\n";
			$string.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
			$string.="<tr valign=\middle\ bgcolor=#6699FF >\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Procedure</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
			$string.= "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
			$string.= "</tr>\n";
			$string.= "<tr width=30% align=left >\n";
			$string.= "<td ><ol> Step :\n";
			$string.= "<li>Configure all the AP.\n";
			$string.= "<li>Power off all AP.\n";
			$string.= "<li>Power on AP1.\n";
			$string.= "<li>Configure the DUT and associate with AP1\n";
			$string.= "<li>Check ping between DUT with AP1\n";
			$string.= "<li>Continue step 3-5 for subsequent APs for 5 Iteration.\n";
			$string.= "</ol> \n";
			$string.= "</td>\n";
			if($tstResult eq "PASS"){
				$string.= "<td width=15% align=middle><font color=green><b>$tstResult</b></td>\n";
				
			}
			elsif($tstResult eq "FAIL"){
				$string.= "<td width=15% align=middle><font color=red><b>$tstResult</b></td>\n";
			}
			$string.= "<td width=25% align=middle>$tstRemark</td>\n";			
			$string.= "</tr>\n";
 			$string.= "</TABLE>\n";
		}
 		$string.= "<br>\n";		
		return ($string);
	}
}
#####################################################################################
# Function Name : subAddWiresharkResult
# Description	: Create HTML report 
# Called By		: TestPing,TestTraffic,TestRoam
# Argument List :
# Returning Arg : Name of the HTML File/A string contains information for HTML File
#####################################################################################
sub subAddWiresharkResult
{
	my $self =shift;
	my $reportFile=shift;
	my $test = shift;
	my $wirehsarkRemark=shift;
	my $wiresharkResult =shift;
	
	if($test eq "Single"){
		open(hFILE,">>$dir_to_open/Reports/$reportFile") or $self->subErrorHandler("Can't Open file:$!");
		if($errorText ne ''){return;}
	 	print hFILE "<html>\n";
		print hFILE "<head>\n";
		print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
		print hFILE "<td colspan=14><font color=#800000 size=4 face=Arial><b>Wireless Verification Result </b></font></td>\n";
		print hFILE "</TABLE>\n";
		print hFILE "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
		print hFILE "<tr valign=\middle\ bgcolor=#6699FF >\n";
		print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
		print hFILE "<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
		print hFILE "</tr>\n";
		print hFILE "<tr valign=\middle\ >\n";
		if($wirehsarkRemark ne ''){
			print hFILE "<td width=\50%\>$wirehsarkRemark</td>\n";
		}
		else{
			print hFILE "<td width=15% align=middle>N.A</td>\n";
		}
		if($wiresharkResult eq "PASS"){
			print hFILE "<td width=15% align=middle><font color=green><b>$wiresharkResult</b></td>\n";
		}
		elsif($wiresharkResult eq "FAIL"){
			print hFILE "<td width=15% align=middle><font color=red><b>$wiresharkResult</b></td>\n";
		}
		else{
			print hFILE "<td width=15% align=middle>N.A</td>\n";
		}
		print hFILE "</tr>\n";
		print hFILE "</html>\n";
		return ($reportFile);
 	}
 	elsif($test eq "Multiple"){
# 	 	$reportFile.="<html>\n";
# 		$reportFile.="<head>\n";
# 		$reportFile.="<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' >\n";
# 		$reportFile.="<td colspan=14><font color=#800000 size=4 face=Arial><b>Wireless Verification Result </b></font></td>\n";
# 		$reportFile.="</TABLE>\n";
# 		$reportFile.= "<TABLE BORDER= 2 CELLSPACING=2 ALIGN='CENTER' WIDTH=50%>\n";
# 		$reportFile.="<tr valign=\middle\ bgcolor=#6699FF >\n";
# 		$reportFile.= "<th ><font color=#800000 size='2' face='Arial'><b>Result</b></th>\n";
# 		$reportFile.="<th ><font color=#800000 size='2' face='Arial'><b>Remark</b></th>\n";
# 		$reportFile.= "</tr>\n";
# 		$reportFile.="<tr valign=\middle\ >\n";
# 		if($wirehsarkRemark eq 'N.A'){
# 			$reportFile.="<td width=\50%\>$wirehsarkRemark</td>\n";
# 		}
# 		else{
# 			$reportFile.= "<td width=15% align=middle>N.A</td>\n";
# 		}
		$reportFile.="<td width=45% align=middle >Wireless Verification Result</td></td>\n";
		if($wiresharkResult eq "PASS"){
			$reportFile.="<td width=25% align=middle><font color=green><b>$wiresharkResult</b></td>\n";
		}
		elsif($wiresharkResult eq "FAIL"){
			$reportFile.= "<td width=25% align=middle><font color=red><b>$wiresharkResult</b></td>\n";
		}
		$reportFile.="<td width=15% align=middle>$wirehsarkRemark</td>\n";
# 		else{
# 			$reportFile.="<td width=15% align=middle>N.A</td>\n";
# 		}
		$reportFile.="</tr>\n";
		$reportFile.="</html>\n";
		return ($reportFile);
	}
	
}
#####################################################################################
# Function Name : subMultipleReport
# Description	: Create HTML Report for Batch Test  
# Called By		: MdlBatchTest
# Argument List : Time of the day,HTML Body
# Returning Arg : Name of the HTML File
#####################################################################################
sub subMultipleReport
{
	my $self = shift;
	my $timeStamp= shift;
	my $fileName = shift;
	my @htmlBody = @_;	
	$errorText = '';
	if(defined($fileName)){
		$htmlFileName = $timeStamp ."_Batch_".$fileName.".html"; # File name for HTML Report
	}
	else{
		$htmlFileName = $timeStamp ."_"."BatchTest".".html"; # File name for HTML Report
	}
	  
	open(bFILE,">$dir_to_open/Reports/$htmlFileName") or $self->subErrorHandler("Can't Open file:$!");
	if($errorText ne ''){return;}
	print bFILE "<html>\n";
	print bFILE @htmlBody;
	print bFILE "</html>\n";
	
	close(bFILE);
	
	return($htmlFileName);
}

#####################################################################################
# Function Name	: subErrorHandler
# Description	: Get the text of any error from file handler
# Called By		: Self
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
# Called By		: 
# Argument List : None
# Returning Arg : An error string
#####################################################################################
sub subReturnError
{
	return $errorText;
}
#####################################################################################
#Return a True value to Respective Module
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################