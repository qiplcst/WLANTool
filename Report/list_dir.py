import os, re, glob
def subFetchNDPInfo(tstplan,resultpath):
    print("TestPlan::::",tstplan)
    print("ResultPath::::",resultpath)
    #return('5745','10')
    p = glob.glob("c:\\cygwin64\\home\\Results\\WifiAwareAllAttached\\" + resultpath +"\\" + tstplan + "\\*")
    print(p)
    NDP_Channels = {}
    NDP_Phymode = {}
    NDP_Channels.setdefault('NDP_Channel', [])
    NDP_Phymode.setdefault('NDP_PHYMODE', [])
    myList = []
    adblog=[]
    for dir in p:
        if os.path.isdir(dir):
            if "test_" in dir:
                #print(dir)
                for device in os.listdir(dir):
                    adblog.append(device)
                #print("ADBLOG::::,",adblog[1])
                for logfile in os.listdir(dir + "\\" + adblog[0]):
                    log_path = dir + "\\" + adblog[0]
                    print("LogPath :: ",log_path)
                    print("Logfile::::::",logfile)
                    with open(log_path + "\\" + logfile,"r", encoding='utf-8') as file:
                        lines = file.readlines()
                        #print("\nLines",lines)
                        for line in lines:
                            #print("Line:",line)
                            if 'NDP_CHANNEL' in line:
                                myList.append(line)
                                break
                            else:
                                pass
                    file.close()
                    if myList == []:
                        NDP_Channels['NDP_Channel'].append(' ')
                        NDP_Phymode['NDP_PHYMODE'].append(' ')
                    else:
                        for myline in myList:
                            if 'NDP_CHANNEL' in myline:
                                channel = re.search(r"mhz=\d+",myline)
                                phymode = re.search(r"phymode=\d+",myline)
                                NDP_Channels['NDP_Channel'].append(channel.group())
                                NDP_Phymode['NDP_PHYMODE'].append(phymode.group())
                    myList.clear()
                print("\nMadarchod*********************\n")
                #NDP_Channels['NDP_Channel'].append('')
                #NDP_Phymode['NDP_PHYMODE'].append('')
                #NDP_Phymode['NDP_PHYMODE'].append(phymode.group())

            else:
                print("Device Details::",dir)
                #adblog.append(device)
                #Initfile=adblog[1]
                #for logfile in os.listdir(dir + adblog[1]):
                #log_path = dir + adblog[1]
                #print("LogPath :: ",log_path)
                #print("LogPath+LogFile::", log_path + logfile)

        else:
            print("FileName::::",dir)
    #print(NDP_Channels["NDP_Channel"])
    #print(NDP_Phymode["NDP_PHYMODE"])
    return(NDP_Channels["NDP_Channel"],NDP_Phymode["NDP_PHYMODE"])
