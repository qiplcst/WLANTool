#####################################################################################
#!/usr/bin/perl
#####################################################################################
package IOTObjectCreation;
#####################################################################################
# Description	: List of User Defined Packages
#####################################################################################
use lib "Util";
use IOTFileReader;
use IOTFileCreater;
#####################################################################################
# Function Name : new
# Description	: Create reference of its own module
# Argument List : None
# Returning Arg : Reference of modules
#####################################################################################
sub new 
{
    my $className = shift;
    my $self = {};
    bless($self,$className);
    $self->{'FILEREADER'} = $self->subCreateObject(IOTFileReader);
    $self->{'FILECREATER'} = $self->subCreateObject(IOTFileCreater);   
    return $self;
}
#####################################################################################
# Function Name : subCreateObject
# Description	: Create an object reference of any module
# Called By		: CBUAUTOMATION_GUI,TestTRAFFIC,TestROAM,MdlPingTest,MdlThroughputTest,MdlRoamTest
# Argument List : Module Name
# Returning Arg : reference of that Module
#####################################################################################
sub subCreateObject {
	my $self = shift;
    my $moduleName = shift;     
    my $obj = $moduleName -> new;
    return $obj;
    
}
#####################################################################################
#Return a True value to Respective Module
#####################################################################################
1;
#####################################################################################
#End of Module
#####################################################################################