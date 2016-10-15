from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
import time
import csv
from datetime import datetime

def to_military(m):
    in_time = datetime.strptime(m, "%I:%M %p")
    out_time = datetime.strftime(in_time, "%H:%M")
    return out_time

url = "http://studentservices.uwo.ca/secure/timetables/mastertt/ttindex.cfm"

chromedriver = "/Users/Josh/Desktop/chromedriver"

driver = webdriver.Chrome(chromedriver)
driver.get(url)

courseCodes = ["ACTURSCI","AMERICAN"]

#,"ANATCELL","ANTHRO","APPLMATH","ARABIC","ARTHUM","ASTRONOM","BIBLSTUD","BIOCHEM","BIOLOGY","BIOPHYS","BIOSTATS","MTP-TVSN","BUSINESS","CALCULUS","CGS"

data = []

# Where H is Thursday.
days = ["M","T","W","H","F"]

f = csv.writer(open("Data.csv", "w"))
data.append(["Course Code Start End Location Days"])

for j, code in enumerate(courseCodes):
    # Take a break after every scrape otherwise we run into a captcha.
    time.sleep(10)
    print(code)
    select = Select(driver.find_element_by_id('inputSubject'))
    select.select_by_value(code)

    driver.find_element_by_css_selector('.btn.btn-info.span2').click()

    html = driver.page_source
    soup = BeautifulSoup(html, "html.parser")

    table = soup.find(class_='table table-striped')

    for t in soup.find_all('table'):

        try:
            caption = t.find_all('caption')
            split = caption[0].text.split()
            course = split[0]
            code = split[1]
        except:
            pass

        for row in t.find_all('tr'):
            a = []
            l = 0
            daySequence = ""
            for i, col in enumerate(row.find_all('td')):
                if i > 3 and i < 9:
                    if col.contents[0] and col.contents[0].strip():
                        daySequence = daySequence + days[i - 4]
                elif i > 8 and i < 12:
                    try:
                        a.append(col.contents[0])
                        l = l + 1
                    except:
                        pass

            if l == 3:
                data.append([split[0] + " " + split[1] + " " + to_military(a[0]) + " " + to_military(a[1]) + " " + a[2] + " " + daySequence])

f.writerows(data)