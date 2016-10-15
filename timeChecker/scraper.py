from bs4 import BeautifulSoup
import requests
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
import time
import csv


url = "http://studentservices.uwo.ca/secure/timetables/mastertt/ttindex.cfm"

chromedriver = "/Users/jasonlee/chromedriver"

driver = webdriver.Chrome(chromedriver)  #driver initialized
driver.get(url)

select = Select(driver.find_element_by_id('inputSubject'))
print "selected the drop down"
#time.sleep(3)
select.select_by_value('ACTURSCI')
print "hi"
#time.sleep(2)

driver.find_element_by_css_selector('.btn.btn-info.span2').click()
print "line 20"
#time.sleep(3)


#r = requests.get(driver.url)
html = driver.page_source
soup = BeautifulSoup(html, "html.parser")

table = soup.find(class_='table table-striped')

f = csv.writer(open("Data.csv", "w"))
f.writerow(["Course Name", "Start Time", "End Time", "Location"])  # Write column headers as the first line
#rows = table.find_all('tr')
for t in soup.find_all('table'):
    caption = t.find_all('caption')
    try:
        print caption[0].text
    except:
        pass

    for row in t.find_all('tr'):
        list = []
        for i, col in enumerate(row.find_all('td')):
            if i == 9 or i== 10  or i == 11:
                print i
                list.append(col.contents[0])
                print col.contents[0]
                #f.writerow([col.contents[0]])

        #f.writerow([list[0]])

        #print col.contents[0]
