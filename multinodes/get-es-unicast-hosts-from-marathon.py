#!/usr/bin/python

import sys, getopt, json, requests

def exit_invalid_args():
  print 'usage: get-es-unicast-hosts-from-marathon.py -m <marathon_url> -a <app_name>'
  sys.exit(2)

def main(argv):
  marathon_url = ''
  app_name = ''
  try:
    opts, args = getopt.getopt(argv,"m:a:",["marathon=","app="])
  except getopt.GetoptError:
    exit_invalid_args()
  
  for opt, arg in opts:
    if opt == '-h':
       print 'test.py -i <inputfile> -o <outputfile>'
       sys.exit()
    elif opt in ("-m", "--marathon"):
       marathon_url = arg
    elif opt in ("-a", "--app"):
       app_name = arg
  
  resp = requests.get(url="{0}/v2/apps/{1}".format(marathon_url, app_name))
  data = json.loads(resp.text)

  unicast_hosts = []

  for task in data['app']['tasks']:
    unicast_hosts.append("{0}:{1}".format(task['host'], task['ports'][1]))

  print ",".join(unicast_hosts)

if __name__ == "__main__":
   main(sys.argv[1:])