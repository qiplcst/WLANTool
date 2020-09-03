import os, re, glob
def subFetchACSChannel(tstplan,resultpath):
    print("TestPlan::::",tstplan)
    print("ResultPath::::",resultpath)
    testplan = 'WifiSoftApAcsTest'
    p = glob.glob("c:\\cygwin64\\home\\Results\\WifiSoftApAcsTest\\" + resultpath + "\\" + tstplan + "\\*")
    adblog=[]
    ACS_Channel = {}
    PHY_Mode = {}
    for dir in p:
        #print("\nDir====>",dir)
        if os.path.isdir(dir):
            if "test_" in dir:
                print(dir)
                for device in os.listdir(dir):
	                adblog.append(device)
                print("ADBLOG::::,",adblog[0])
                for logfile in os.listdir(dir + "\\" + adblog[0]):
                    log_path = dir + "\\" + adblog[0]
                    #print("LogPath :: ",log_path)
                    #print("Logfile::::::",logfile)
                    with open(log_path + "\\" + logfile,"r", encoding='utf-8') as file:
                        lines = file.readlines()
                        for line in lines:
                            #print("Line:",line)
                            if 'ACS-COMPLETED' in line:
                                print("Line=",line)
                                ACS_Channel.setdefault('CHANNEL', [])
                                channel = re.search(r"freq=\d+",line)
                                ACS_Channel['CHANNEL'].append(channel.group())
                            elif 'nl80211: Set freq' in line:
                                print("Line=",line)
                                PHY_Mode.setdefault('PHY', [])
                                phymode = re.search(r"ht_enabled=(\d),\svht_enabled=(\d),\she_enabled=(\d),\sbandwidth=(\d+)",line)
                                print("Phymode===>",phymode.group(3))
                                PHY_Mode['PHY'].append(phymode.group(0))
                        #print("NDP_Channel=>",NDP_Channels)
                        #print("NDP_Phymode=>",NDP_Phymode)
                        #print(NDP_Channels["NDP_Channel"])
                        #print(NDP_Phymode["NDP_PHYMODE"])
            else:
                print("Device Details::",dir)
                #adblog.append(device)
            #Initfile=adblog[1]
            #for logfile in os.listdir(dir + adblog[1]):
            #    log_path = dir + adblog[1]
            #   print("LogPath :: ",log_path)
            #  print("LogPath+LogFile::", log_path + logfile)

        else:
            print("FileName::::",dir)
    #print("NDP_Channel=>",NDP_Channels)
    #print("NDP_Phymode=>",NDP_Phymode)
    print(ACS_Channel["CHANNEL"])
    #print(PHY_Mode["PHY"])
    return(ACS_Channel["CHANNEL"])
