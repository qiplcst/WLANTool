import subprocess, os,sys,time
from subprocess import Popen, PIPE
print("One line at a time\n")
os.chdir(os.path.abspath('c:\\cygwin64\\bin'))
cwd1 = os.getcwd()
Mode = sys.argv[1]
ACTPath =  sys.argv[2]
TestGroup = sys.argv[3]
TestPlan = sys.argv[4]
print("New Current working directory is:", cwd1)
if Mode == 'Setup':
    print("Inside Setup side\n")
    process = subprocess.Popen(["bash.exe", "-i"], stdin=subprocess.PIPE, stdout=subprocess.PIPE,encoding='utf8')
    process.stdin.write("cd " + str(ACTPath) +"\n")
    process.stdin.write("ls -l" +"\n")
    process.stdin.write("python3.6 setup.py develop" +"\n")
    process.stdin.write("python3.6 setup.py install" +"\n")
    #print(process.communicate()[0])
    process.stdin.close()
elif Mode == 'Execute' and TestGroup == 'NAN':
    print("Inside NAN group\n")
    process = subprocess.Popen(["bash.exe", "-i"], stdin=subprocess.PIPE, stdout=subprocess.PIPE,encoding='utf8')
    process.stdin.write("cd /home/6_8/acts/tests/google/wifi/" +"\n")
    process.stdin.write("ls -l" +"\n")
    process.stdin.write("act.py -c wifi_aware.json -tc " + str(TestPlan) +"\n")
    process.stdin.close()
elif Mode == 'Execute' and TestGroup == 'RTT':
    print("Inside RTT Group\n")
    process = subprocess.Popen(["bash.exe", "-i"], stdin=subprocess.PIPE, stdout=subprocess.PIPE,encoding='utf8')
    process.stdin.write("cd /home/6_8/acts/tests/google/wifi/" +"\n")
    process.stdin.write("ls -l" +"\n")
    process.stdin.write("act.py -c wifi_rtt.json -tc " + str(TestPlan) +"\n")
    #print(process.communicate()[0])
    process.stdin.close()
elif Mode == 'Execute' and TestGroup == 'Sanity':
    print("Inside RTT Group\n")
    process = subprocess.Popen(["bash.exe", "-i"], stdin=subprocess.PIPE, stdout=subprocess.PIPE,encoding='utf8')
    process.stdin.write("cd /home/6_8/acts/tests/google/wifi/" +"\n")
    process.stdin.write("ls -l" +"\n")
    process.stdin.write("act.py -c wifi_sanity.json -tc " + str(TestPlan) +"\n")
    #print(process.communicate()[0])
    process.stdin.close()
elif Mode == 'Execute' and TestGroup == 'SAP':
    print("Inside RTT Group\n")
    process = subprocess.Popen(["bash.exe", "-i"], stdin=subprocess.PIPE, stdout=subprocess.PIPE,encoding='utf8')
    process.stdin.write("cd /home/6_8/acts/tests/google/wifi/" +"\n")
    process.stdin.write("ls -l" +"\n")
    process.stdin.write("act.py -c WiFi_ACS.txt -tc " + str(TestPlan) +"\n")
    #print(process.communicate()[0])
    process.stdin.close()   
for line in process.stdout:
    print(line)


