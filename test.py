#!/usr/bin/env python

#######################################################################################
# 
#
# Script Name:      test.py
#
# Description:      This will test the nodejs crud application and insert the 36000000  
#                                                                             round of test data.
#                   
#
# %Version:         1.0
# %Creating Date:   Thu Dec 24 2015
# %Created by:      Jai
#######################################################################################


import unittest
import re
from selenium import webdriver
import os

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait # available since 2.4.0
from selenium.webdriver.support import expected_conditions as EC # available since 2.26.0
from selenium.webdriver.common.by import By

class Test_Home_page(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def testTitle(self):
        self.browser.get('http://10.80.34.174:2145/webserver1.com/public_html/') 
	#print(self.browser.page_source)
        self.assertIn('User Management System', self.browser.title)

    def tearDown(self):
        self.browser.quit()

class Test_Login(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def testTitle(self):        
	# Create a new instance of the Firefox driver
	driver = webdriver.Firefox()

	driver.get('http://10.80.34.174:2145/webserver1.com/public_html/') 
	#print driver.title

	# find the element that's name attribute is q (the google search box)
	driver.find_element_by_name('first_name').send_keys("Carol")
	driver.find_element_by_name('last_name').send_keys("Pereira")
	driver.find_element_by_name('btn-save').click()

	src = driver.page_source
	text_found = re.search(r'Operations', src)
	self.assertNotEqual(text_found, None)
	driver.quit()

    def tearDown(self):
        self.browser.quit()

class Test_SignUpLink(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Firefox()

    def testTitle(self):        
	# Create a new instance of the Firefox driver
	driver = webdriver.Firefox()

	driver.get('http://10.80.34.174:2145/webserver1.com/public_html/') 
	#print driver.title

	# find the element that's name attribute is q (the google search box)
	
	driver.find_element_by_partial_link_text('Signup').click()
	driver.find_element_by_name('first_name').send_keys("Genius")
	driver.find_element_by_name('last_name').send_keys("KA")
	driver.find_element_by_name('city_name').send_keys("India")
	driver.find_element_by_name('btn-save').click()
	
	src = driver.page_source
	text_found = re.search(r'Signup Page', src)
	self.assertNotEqual(text_found, None)
	driver.quit()

    def tearDown(self):
        self.browser.quit()

if __name__ == '__main__':
     log_file = '/root/TestSuite/test_result.log'
     f = open(log_file, "w")
     runner = unittest.TextTestRunner(f)
     unittest.main(testRunner=runner)
     f.close()