import re
import subprocess
import locale
import sys
import time
import json
from bs4 import BeautifulSoup

# if unsupported locale setting reported, you can use locale -a to see whether zh_CN or zh_CN.utf-8 should be used
locale.setlocale(locale.LC_TIME, "zh_CN.utf-8")
news_txt = open('news.txt', 'w')
sys.stdout = news_txt
filter_reg = re.compile('(.*epochtimes.*)|(.*dw.com.*)')

TODAY = time.strftime("%Y年%-b月%-d日星期%a")
TOPK = 10

subprocess.Popen("bash liaocheng-news.sh",  shell=True).communicate()
#print('news json is ready!')
filtered_news = []

with open('news.json') as fp:
    news = json.load(fp)
    for v in news:
        if not filter_reg.match(v['link']):
            filtered_news.append(v)
			
print('\n\n'.join('▶ title: %s\nlink: %s\ndate: %s'%(v['title'], v['link'], v['date']) for v in filtered_news[:TOPK]))
news_txt.close()
