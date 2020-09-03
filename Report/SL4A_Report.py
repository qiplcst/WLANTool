from MDLHtmlReport import *
from list_dir import *
from MDLACSChannel import *
import sys, os, json, time, datetime, glob
from datetime import timedelta
from datetime import datetime
print("Inside report\n")
TestGroup = sys.argv[1]
TestPlan = sys.argv[2]
TestLoc = sys.argv[3]
print("\nTestGroup=>",TestGroup)
print("\nTestPlan=>",TestPlan)
print("\nReportLocation=>",TestLoc)
resultpath=[]
Results = {}
if (TestGroup == 'NAN'):
    print("Inside NAN Test Group")
    dirs = os.listdir('c:\\cygwin64\\home\\Results\\WifiAwareAllAttached')
    for dir in dirs:
        print(dir)
        resultpath.append(dir)
    n=len(resultpath)
    ResultPath = resultpath[n-2]
    print(ResultPath)  
    #ResultPath = '2020-06-04_17-59-06-669'
    (NDPChannel, NDPPhyMode) = subFetchNDPInfo(TestPlan, ResultPath)
    print("\nNDP_Channel====>",NDPChannel)
    print("\nNDP_Phymode====>",NDPPhyMode)
    #Results = {}
    #for file in os.listdir('2020-06-04_17-59-06-669'):
    with open("c:\\cygwin64\\home\\Results\\WifiAwareAllAttached\\" + ResultPath + "\\" + 'test_run_summary.json') as json_file:  
        data = json.load(json_file)
        TotalTC=data['Summary']['Executed']
        PassedTC=data['Summary']['Passed']
        FailedTC=data['Summary']['Failed']
        print("Total TC=>",TotalTC)
        print("Passed TC=>",PassedTC)
        print("Failed TC=>",FailedTC)
        for i in range(TotalTC):
            print(i)
            testclass=(data['Results'][i]['Test Class'])
            testcase=(data['Results'][i]['Test Name'])
            testresult=(data['Results'][i]['Result'])
            testduration1=(data['Results'][i]['Log Begin Time'])
            T1_Date = datetime.strptime(testduration1, '%Y-%m-%d %H:%M:%S.%f')
            T1 = timedelta(hours=T1_Date.hour, minutes=T1_Date.minute, seconds=T1_Date.second)
            testduration2=(data['Results'][i]['Log End Time'])
            T2_Date = datetime.strptime(testduration2, '%Y-%m-%d %H:%M:%S.%f')
            T2 = timedelta(hours=T2_Date.hour, minutes=T2_Date.minute, seconds=T2_Date.second)
            actual = (T2 - T1)
            print("Actual Time ::", actual)
            ndpchannel = NDPChannel[i]
            print("Test Case::::",testcase)
            print("NDP_Channel::::",ndpchannel)
            phymode = NDPPhyMode[i]
            testremark=(data['Results'][i]['Details'])
            Results.setdefault('Test Module', [])
            Results.setdefault('Test Case', [])
            Results.setdefault('Test Result', [])
            Results.setdefault('Duration', [])
            Results.setdefault('NDP CHANNEL', [])
            Results.setdefault('NDP PHYMODE', [])
            Results.setdefault('Comments', [])
            Results['Test Module'].append(testclass)
            Results['Test Case'].append(testcase)
            Results['Test Result'].append(testresult)
            Results['Duration'].append(str(actual))
            Results['NDP CHANNEL'].append(ndpchannel)
            Results['NDP PHYMODE'].append(phymode)
            Results['Comments'].append(testremark)
            #TmpResult.update({TmpResult['Test Case'], testcase})
            #total_dur +=actual 
            print("New List=>",Results)
            #Report_Generated=subCreateReport(TestGroup,TestPlan,TestLoc,Results)
            #print(total_dur)
elif TestGroup == 'RTT':
    dirs = os.listdir('c:\\cygwin64\\home\\Results\\WifiRttAllAttached')
    for dir in dirs:
        print(dir)
        resultpath.append(dir)
    n=len(resultpath)
    ResultPath = resultpath[n-2]
    print(ResultPath)  
    #Results = {}
    #for file in os.listdir('2020-06-04_17-59-06-669'):
    with open("c:\\cygwin64\\home\\Results\\WifiRttAllAttached\\" + ResultPath + "\\" + 'test_run_summary.json') as json_file:  
        data = json.load(json_file)
        TotalTC=data['Summary']['Executed']
        PassedTC=data['Summary']['Passed']
        FailedTC=data['Summary']['Failed']
        print("Total TC=>",TotalTC)
        print("Passed TC=>",PassedTC)
        print("Failed TC=>",FailedTC)
        for i in range(TotalTC):
            print(i)
            testclass=(data['Results'][i]['Test Class'])
            testcase=(data['Results'][i]['Test Name'])
            testresult=(data['Results'][i]['Result'])
            testduration1=(data['Results'][i]['Log Begin Time'])
            T1_Date = datetime.strptime(testduration1, '%Y-%m-%d %H:%M:%S.%f')
            T1 = timedelta(hours=T1_Date.hour, minutes=T1_Date.minute, seconds=T1_Date.second)
            testduration2=(data['Results'][i]['Log End Time'])
            T2_Date = datetime.strptime(testduration2, '%Y-%m-%d %H:%M:%S.%f')
            T2 = timedelta(hours=T2_Date.hour, minutes=T2_Date.minute, seconds=T2_Date.second)
            actual = (T2 - T1)
            print("Actual Time ::", actual)
            testremark=(data['Results'][i]['Details'])
            Results.setdefault('Test Module', [])
            Results.setdefault('Test Case', [])
            Results.setdefault('Test Result', [])
            Results.setdefault('Duration', [])
            Results.setdefault('Comments', [])
            Results['Test Module'].append(testclass)
            Results['Test Case'].append(testcase)
            Results['Test Result'].append(testresult)
            Results['Duration'].append(str(actual))
            Results['Comments'].append(testremark)
            #TmpResult.update({TmpResult['Test Case'], testcase})
            #total_dur +=actual 
            print("New List=>",Results)
            #Report_Generated=subCreateReport(TestGroup,TestPlan,TestLoc,Results)
            #print(total_dur)
elif TestGroup == 'Sanity':
    print("Inside SL4A_Report....Sanity\n")
    dirs = os.listdir('c:\\cygwin64\\home\\Results\\WifiSanityTest')
    for dir in dirs:
        print(dir)
        resultpath.append(dir)
    n=len(resultpath)
    ResultPath = resultpath[n-2]
    print(ResultPath)  
    #Results = {}
    #for file in os.listdir('2020-06-04_17-59-06-669'):
    with open("c:\\cygwin64\\home\\Results\\WifiSanityTest\\" + ResultPath + "\\" + 'test_run_summary.json') as json_file:  
        data = json.load(json_file)
        TotalTC=data['Summary']['Executed']
        PassedTC=data['Summary']['Passed']
        FailedTC=data['Summary']['Failed']
        print("Total TC=>",TotalTC)
        print("Passed TC=>",PassedTC)
        print("Failed TC=>",FailedTC)
        for i in range(TotalTC):
            print(i)
            testclass=(data['Results'][i]['Test Class'])
            testcase=(data['Results'][i]['Test Name'])
            testresult=(data['Results'][i]['Result'])
            testduration1=(data['Results'][i]['Log Begin Time'])
            T1_Date = datetime.strptime(testduration1, '%Y-%m-%d %H:%M:%S.%f')
            T1 = timedelta(hours=T1_Date.hour, minutes=T1_Date.minute, seconds=T1_Date.second)
            testduration2=(data['Results'][i]['Log End Time'])
            T2_Date = datetime.strptime(testduration2, '%Y-%m-%d %H:%M:%S.%f')
            T2 = timedelta(hours=T2_Date.hour, minutes=T2_Date.minute, seconds=T2_Date.second)
            actual = (T2 - T1)
            print("Actual Time ::", actual)
            testremark=(data['Results'][i]['Details'])
            Results.setdefault('Test Module', [])
            Results.setdefault('Test Case', [])
            Results.setdefault('Test Result', [])
            Results.setdefault('Duration', [])
            Results.setdefault('Comments', [])
            Results['Test Module'].append(testclass)
            Results['Test Case'].append(testcase)
            Results['Test Result'].append(testresult)
            Results['Duration'].append(str(actual))
            Results['Comments'].append(testremark)
            #TmpResult.update({TmpResult['Test Case'], testcase})
            #total_dur +=actual 
            print("New List=>",Results)
            #Report_Generated=subCreateReport(TestGroup,TestPlan,TestLoc,Results)
            #print(total_dur)
elif TestGroup == 'SAP':
    print("Inside SL4A_Report....Sanity\n")
    dirs = os.listdir('c:\\cygwin64\\home\\Results\\WifiSoftApAcsTest')
    for dir in dirs:
        print(dir)
        resultpath.append(dir)
    n=len(resultpath)
    ResultPath = resultpath[n-2]
    print(ResultPath)
    #ACSChannel = subFetchACSChannel(TestPlan, ResultPath)
    #print("\nACS_Channel====>",ACSChannel)  
    #Results = {}
    #for file in os.listdir('2020-06-04_17-59-06-669'):
    with open("c:\\cygwin64\\home\\Results\\WifiSoftApAcsTest\\" + ResultPath + "\\" + 'test_run_summary.json') as json_file:  
        data = json.load(json_file)
        TotalTC=data['Summary']['Executed']
        PassedTC=data['Summary']['Passed']
        FailedTC=data['Summary']['Failed']
        print("Total TC=>",TotalTC)
        print("Passed TC=>",PassedTC)
        print("Failed TC=>",FailedTC)
        for i in range(TotalTC):
            print(i)
            testclass=(data['Results'][i]['Test Class'])
            testcase=(data['Results'][i]['Test Name'])
            testresult=(data['Results'][i]['Result'])
            testduration1=(data['Results'][i]['Log Begin Time'])
            T1_Date = datetime.strptime(testduration1, '%Y-%m-%d %H:%M:%S.%f')
            T1 = timedelta(hours=T1_Date.hour, minutes=T1_Date.minute, seconds=T1_Date.second)
            testduration2=(data['Results'][i]['Log End Time'])
            T2_Date = datetime.strptime(testduration2, '%Y-%m-%d %H:%M:%S.%f')
            T2 = timedelta(hours=T2_Date.hour, minutes=T2_Date.minute, seconds=T2_Date.second)
            actual = (T2 - T1)
            print("Actual Time ::", actual)
            testremark=(data['Results'][i]['Details'])
            Results.setdefault('Test Module', [])
            Results.setdefault('Test Case', [])
            Results.setdefault('Test Result', [])
            Results.setdefault('Duration', [])
            Results.setdefault('Comments', [])
            Results['Test Module'].append(testclass)
            Results['Test Case'].append(testcase)
            Results['Test Result'].append(testresult)
            Results['Duration'].append(str(actual))
            Results['Comments'].append(testremark)
            #TmpResult.update({TmpResult['Test Case'], testcase})
            #total_dur +=actual 
            print("New List=>",Results)
            #Report_Generated=subCreateReport(TestGroup,TestPlan,TestLoc,Results)
            #print(total_dur)
Report_Generated=subCreateReport(TestGroup,TestPlan,TestLoc,Results)
print("Test Results Created @:", Report_Generated)
