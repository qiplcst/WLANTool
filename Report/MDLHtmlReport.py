from yattag import Doc
import datetime
import time
import os
def subCreateReport(testgroup,testplan,testreportloc,Results={}):
    print("Test Group ==>", testgroup)
    print("Test Plan ==>", testplan)
    print("Test Report Location==>", testreportloc)
    if testgroup == 'NAN':
        reportname=testplan + "_{:%Y-%m-%d_%H_%M_%S}".format(datetime.datetime.now())
        print(reportname)
        doc, tag, text = Doc().tagtext()
        doc.asis('<!DOCTYPE html>')
        with tag('html'):
            with tag('head'):
                with tag('title'):
                    text('Generated Report')
                with tag('style'):
                    text("""td h2 {text-decoration: underline overline wavy blue;}{white-space:pre-line;}""")
                    text("""td h2 div.absolute {position: absolute;top: 80px;right: 0; width: 200px;height: 100px;}""")
        with tag('body'):
            with tag('div', style="float:left; margin-right:8px;"):
                with tag('H1'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:25pt"):
                        text("Test Completed")
                with tag('H2'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:20pt"):
                        text("Test Plan :: " +testplan)
                with tag('H2'):
                    with tag('font', color="darkgreen", style="font-family:Calbri;font-size:20pt"):
                        text("Test Result :: PASSED")						
                with tag('H2'):
                    with tag('font', color="black",style="font-family:Calbri;font-size:20pt"):
                        text("Test Result Summary")
                with tag('H2'):
                    with tag("a",'font', color="#FFFFFF", style="font-family:Calbri;font-size:20pt",href=testreportloc):
                        text("Report Location :: " +testreportloc)
            #with tag('div', style="float:right; margin-right:4px;",id='photo-container'):
                #doc.stag('img', src='graph.png', klass="photo",height="400" , width="800")
            with tag('table', border="1", cellspacing="6",cellpadding="6", style="border-collapse:collapse;font-family:Verdana;font-size:12pt", width="100%"):
                with tag('th', bgcolor="RoyalBlue", color="white", width="2%"):
                    with tag('font', color="#FFFFFF"):
                        text("S.No#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="6%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Module#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%", style="text-align:left;"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Case#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Result")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Duration")
                with tag('th', bgcolor="RoyalBlue", color="white", width="8%"):
                    with tag('font', color="#FFFFFF"):
                        text("NDP CHANNEL")
                with tag('th', bgcolor="RoyalBlue", color="white", width="6%"):
                    with tag('font', color="#FFFFFF"):
                        text("NDP PHYMODE")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%"):
                    with tag('font', color="#FFFFFF"):
                        text("Comments")
                testlen=len(Results['Test Case'])
                for i in range(testlen):
                    with tag('tr'):
                        with tag('td'):
                            with tag("a", href=i+1):
                                text(i+1)
                        with tag('td', style="text-align:Center;"):
                            text(Results['Test Module'][i])
                        with tag('td'):
                            text(Results['Test Case'][i])
                        if  Results['Test Result'][i] == 'PASS':
                            with tag('td', bgcolor="#00ff00", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP CHANNEL'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP PHYMODE'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'FAIL':
                            with tag('td', bgcolor="#ff6347", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP CHANNEL'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP PHYMODE'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'UNKNOWN':
                            with tag('td', bgcolor="#ffa500", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP CHANNEL'][i])
                            with tag('td',style="text-align:Center;"):
                                text(Results['NDP PHYMODE'][i])
                            with tag('td'):
                                text('')
    elif testgroup == 'Sanity':
        reportname=testplan + "_{:%Y-%m-%d_%H_%M_%S}".format(datetime.datetime.now())
        print(reportname)
        doc, tag, text = Doc().tagtext()
        doc.asis('<!DOCTYPE html>')
        with tag('html'):
            with tag('head'):
                with tag('title'):
                    text('Generated Report')
                with tag('style'):
                    text("""td h2 {text-decoration: underline overline wavy blue;}{white-space:pre-line;}""")
                    text("""td h2 div.absolute {position: absolute;top: 80px;right: 0; width: 200px;height: 100px;}""")
        with tag('body'):
            with tag('div', style="float:left; margin-right:8px;"):
                with tag('H1'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:25pt"):
                        text("Test Completed")
                with tag('H2'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:20pt"):
                        text("Test Plan :: " +testplan)
                with tag('H2'):
                    with tag('font', color="darkgreen", style="font-family:Calbri;font-size:20pt"):
                        text("Test Result :: PASSED")                       
                with tag('H2'):
                    with tag('font', color="black",style="font-family:Calbri;font-size:20pt"):
                        text("Test Result Summary")
                with tag('H2'):
                    with tag("a",'font', color="#FFFFFF", style="font-family:Calbri;font-size:20pt",href=testreportloc):
                        text("Report Location :: " +testreportloc)
            #with tag('div', style="float:right; margin-right:4px;",id='photo-container'):
                #doc.stag('img', src='graph.png', klass="photo",height="400" , width="800")
            with tag('table', border="1", cellspacing="6",cellpadding="6", style="border-collapse:collapse;font-family:Verdana;font-size:12pt", width="100%"):
                with tag('th', bgcolor="RoyalBlue", color="white", width="2%"):
                    with tag('font', color="#FFFFFF"):
                        text("S.No#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="6%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Module#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%", style="text-align:left;"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Case#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Result")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Duration")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%"):
                    with tag('font', color="#FFFFFF"):
                        text("Comments")
                testlen=len(Results['Test Case'])
                for i in range(testlen):
                    with tag('tr'):
                        with tag('td'):
                            with tag("a", href=i+1):
                                text(i+1)
                        with tag('td', style="text-align:Center;"):
                            text(Results['Test Module'][i])
                        with tag('td'):
                            text(Results['Test Case'][i])
                        if  Results['Test Result'][i] == 'PASS':
                            with tag('td', bgcolor="#00ff00", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'FAIL':
                            with tag('td', bgcolor="#ff6347", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'UNKNOWN':
                            with tag('td', bgcolor="#ffa500", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
    elif testgroup == 'SAP':
        reportname=testplan + "_{:%Y-%m-%d_%H_%M_%S}".format(datetime.datetime.now())
        print(reportname)
        doc, tag, text = Doc().tagtext()
        doc.asis('<!DOCTYPE html>')
        with tag('html'):
            with tag('head'):
                with tag('title'):
                    text('Generated Report')
                with tag('style'):
                    text("""td h2 {text-decoration: underline overline wavy blue;}{white-space:pre-line;}""")
                    text("""td h2 div.absolute {position: absolute;top: 80px;right: 0; width: 200px;height: 100px;}""")
        with tag('body'):
            with tag('div', style="float:left; margin-right:8px;"):
                with tag('H1'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:25pt"):
                        text("Test Completed")
                with tag('H2'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:20pt"):
                        text("Test Plan :: " +testplan)
                with tag('H2'):
                    with tag('font', color="darkgreen", style="font-family:Calbri;font-size:20pt"):
                        text("Test Result :: PASSED")                       
                with tag('H2'):
                    with tag('font', color="black",style="font-family:Calbri;font-size:20pt"):
                        text("Test Result Summary")
                with tag('H2'):
                    with tag("a",'font', color="#FFFFFF", style="font-family:Calbri;font-size:20pt",href=testreportloc):
                        text("Report Location :: " +testreportloc)
            #with tag('div', style="float:right; margin-right:4px;",id='photo-container'):
                #doc.stag('img', src='graph.png', klass="photo",height="400" , width="800")
            with tag('table', border="1", cellspacing="6",cellpadding="6", style="border-collapse:collapse;font-family:Verdana;font-size:12pt", width="100%"):
                with tag('th', bgcolor="RoyalBlue", color="white", width="2%"):
                    with tag('font', color="#FFFFFF"):
                        text("S.No#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="6%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Module#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%", style="text-align:left;"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Case#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Result")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Duration")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%"):
                    with tag('font', color="#FFFFFF"):
                        text("Comments")
                testlen=len(Results['Test Case'])
                for i in range(testlen):
                    with tag('tr'):
                        with tag('td'):
                            with tag("a", href=i+1):
                                text(i+1)
                        with tag('td', style="text-align:Center;"):
                            text(Results['Test Module'][i])
                        with tag('td'):
                            text(Results['Test Case'][i])
                        if  Results['Test Result'][i] == 'PASS':
                            with tag('td', bgcolor="#00ff00", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'FAIL':
                            with tag('td', bgcolor="#ff6347", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'UNKNOWN':
                            with tag('td', bgcolor="#ffa500", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
    elif testgroup == 'RTT':  
        reportname=testplan + "_{:%Y-%m-%d_%H_%M_%S}".format(datetime.datetime.now())
        print(reportname)
        doc, tag, text = Doc().tagtext()
        doc.asis('<!DOCTYPE html>')
        with tag('html'):
            with tag('head'):
                with tag('title'):
                    text('Generated Report')
                with tag('style'):
                    text("""td h2 {text-decoration: underline overline wavy blue;}{white-space:pre-line;}""")
                    text("""td h2 div.absolute {position: absolute;top: 80px;right: 0; width: 200px;height: 100px;}""")
        with tag('body'):
            with tag('div', style="float:left; margin-right:8px;"):
                with tag('H1'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:25pt"):
                        text("Test Completed")
                with tag('H2'):
                    with tag('font', color="black", style="font-family:Calbri;font-size:20pt"):
                        text("Test Plan :: " +testplan)
                with tag('H2'):
                    with tag('font', color="darkgreen", style="font-family:Calbri;font-size:20pt"):
                        text("Test Result :: PASSED")                       
                with tag('H2'):
                    with tag('font', color="black",style="font-family:Calbri;font-size:20pt"):
                        text("Test Result Summary")
                with tag('H2'):
                    with tag("a",'font', color="#FFFFFF", style="font-family:Calbri;font-size:20pt",href=testreportloc):
                        text("Report Location :: " +testreportloc)
            #with tag('div', style="float:right; margin-right:4px;",id='photo-container'):
                #doc.stag('img', src='graph.png', klass="photo",height="400" , width="800")
            with tag('table', border="1", cellspacing="6",cellpadding="6", style="border-collapse:collapse;font-family:Verdana;font-size:12pt", width="100%"):
                with tag('th', bgcolor="RoyalBlue", color="white", width="2%"):
                    with tag('font', color="#FFFFFF"):
                        text("S.No#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="6%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Module#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%", style="text-align:left;"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Case#")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Test Result")
                with tag('th', bgcolor="RoyalBlue", color="white", width="4%"):
                    with tag('font', color="#FFFFFF"):
                        text("Duration")
                with tag('th', bgcolor="RoyalBlue", color="white", width="16%"):
                    with tag('font', color="#FFFFFF"):
                        text("Comments")
                testlen=len(Results['Test Case'])
                for i in range(testlen):
                    with tag('tr'):
                        with tag('td'):
                            with tag("a", href=i+1):
                                text(i+1)
                        with tag('td', style="text-align:Center;"):
                            text(Results['Test Module'][i])
                        with tag('td'):
                            text(Results['Test Case'][i])
                        if  Results['Test Result'][i] == 'PASS':
                            with tag('td', bgcolor="#00ff00", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'FAIL':
                            with tag('td', bgcolor="#ff6347", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
                        elif Results['Test Result'][i] == 'UNKNOWN':
                            with tag('td', bgcolor="#ffa500", style="text-align:Center;"):
                                text(Results['Test Result'][i])
                            with tag('td', style="text-align:Center;"):
                                text(Results['Duration'][i])
                            with tag('td'):
                                text('')
    print(doc.getvalue())
    result = doc.getvalue()
    location=os.getcwd()
    print(location)
    os.chdir(testreportloc)
    newlocation=os.getcwd()
    print(newlocation)
    with open(reportname + ".html", "w+") as file:
        file.write(result)
    file.close()
    return(newlocation)
