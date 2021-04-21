from selenium import webdriver
#from selenium import *

from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')

url = 'https://www.baidu.com'
a=webdriver.Chrome(options=chrome_options)
a.get(url)
count = a.find_element_by_xpath('')
count.send_keys('')
button = a.find_element_by_xpath('')
button.click()

