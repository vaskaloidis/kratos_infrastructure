from bs4 import BeautifulSoup
import urllib2, base64
import os, sys
from urlparse import urljoin
 
 
ips = []
ports = []
both = []
 
if os.geteuid() != 0: #test for root or superuser
    print "[*] You must run this program as root!!"
    sys.exit()
 
 
if len(sys.argv) != 2:
    print "Usage: %s <location of configuration file>" %str(sys.argv[0])
    sys.exit()
 
#open link...parse data with bs(...lol) and return it
def getSoup(url):
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1"}
 
    try:
        req = urllib2.Request(url, None, headers)
        html = urllib2.urlopen(req).read()
    except urllib2.URLError as e:
        print str(e)
        sys.exit()
 
    soup = BeautifulSoup(html, "html.parser") #parsing html
 
    return soup
 
 
#first we get the link from with the raw proxies...
first_soup = getSoup("http://www.samair.ru/proxy/ip-port/")
 
#now we gonna search for the raw proxy ports link
for pports in first_soup.findAll('a', href=True):
    if pports.getText() == "You can do it there":
        new_link = urljoin("http://www.samair.ru",pports['href'])
        break
    else:
        pass
 
 
#now we can get the raw proxies
second_soup = getSoup(new_link)
 
#parsing it to get the proxies from the pre tag
#and also splitting it to make sure it comes in the list
both = str(second_soup.find('pre')).split("\n")
 
for singles in both:
    try:
        #this is a lazy way to get rid of the pre tags because it comes with it
        if singles.startswith("<pre>"):
            singles = singles[5:]
        if singles.startswith("</pre>"):
            singles = singles[6:]
 
        ip_addr, port_num = singles.split(":") #separating ip addresses and ports
        ips.append(ip_addr)
        ports.append(port_num)
    except:
        pass       
   
 
f = open(sys.argv[1], "a")
 
#write proxy settings to proxychains file
for i in range(0,len(ports)):
    f.write("http\t%s\t%s\n" %(ips[i], ports[i]))
 
 
f.close()
 
print "[+] Done!!"
print "[*] Now you can browse anonymously with proxychains"