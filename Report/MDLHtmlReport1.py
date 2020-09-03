from yattag import Doc
import datetime
import time
import os
def subCreateReport(testgroup,testplan,Results={}):
    print("Test Group ==>", testgroup)
    print("Test Plan ==>", testplan)
    if testgroup == 'NAN':
        print("Inside SL4A Test Report Generation Block\n")
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
		with tag('body'):
    return("magya")