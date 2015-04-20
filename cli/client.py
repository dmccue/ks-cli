#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: David McCue

import sys, re, requests, json

def print_help():
  print """
Usage:

  ./project <project name>

  ./list <project name>

  ./back <name> <project name> <cc> <amount>

  ./backer <backer name>

"""

def printCurrency(inputVal):
  return re.sub('\.00','', "%.2f" % float(inputVal))

server_url = "http://localhost:8080"
headers = {'accept':'application/json', 'content-type' : 'application/json'}

if sys.argv[0] == "./project":
  data = {}
  data['name'] = sys.argv[1]
  data['target'] = sys.argv[2]

  r = requests.post(server_url+'/project', data=json.dumps(data), headers=headers)
  if r.status_code == requests.codes.ok:
    print "Added " + sys.argv[1] + " project with target of $" + printCurrency(sys.argv[2])
  else:
    print r.json()['msg']
    sys.exit(1)

elif sys.argv[0] == "./list":
  r = requests.get(server_url + '/project/' + sys.argv[1])
  if r.status_code == requests.codes.ok:
    jsonProj = r.json()['project']
    jsonBack = r.json()['backers']
    totalFunding = 0.0
    for backer in jsonBack:
      print "-- " + str(backer[0]) + " backed for $" + printCurrency(str(backer[1]))
      totalFunding = totalFunding + backer[1]
    totalGoal = jsonProj[2] - totalFunding
    if totalGoal <= 0.0:
      print sys.argv[1] + " is successful!"
    else:
      print sys.argv[1] + " needs $" + printCurrency(totalGoal) + " more dollars to be successful" 
  else:
    print r.json()['msg']
    sys.exit(1)


elif sys.argv[0] == "./back":
  data = {}
  data['name'] = sys.argv[1]
  data['projectname'] = sys.argv[2]
  data['cc'] = sys.argv[3]
  data['amount'] = sys.argv[4]

  r = requests.post(server_url+'/back', data=json.dumps(data), headers=headers)
  if r.status_code == requests.codes.ok:
    print sys.argv[1] + " backed project " + sys.argv[2] + " for $" + printCurrency(sys.argv[4])
  else:
    print r.json()['msg']
    sys.exit(1)


elif sys.argv[0] == "./backer":
  r = requests.get(server_url + '/backer/' + sys.argv[1])
  if r.status_code == requests.codes.ok:
    for backer in r.json()['backer']:
      print "-- Backed " + backer[0] + " for $" + printCurrency(backer[1])
  else:
    print r.json()['msg']
    sys.exit(1)

else:
  print_help()


sys.exit(0)

##
# project project_name project_amount
# project , 4,20, [0-9\.]+
# 
# back backer_name project_name cc_name backer_amount
# back [A-Za-z0-9_-]+ 4,20, [0-9] >19, luhn-10, unique
# 
# list
# backer

# add_project(project_name, project_target)
#   - print "Added " + project_name + " project with target of $" + project_target
# add_backer(backer_name, project_name, backer_cardnumer, backer_amount)
#   - print backer_name + " backed project " + project_name + " for $" + backer_amount
#
#
# verify_currency(input)
#   - numbers or .
# verify_name(input)
#   - [A-Za-z0-9_-]
#   - 4,20
# verify_creditcard(input)
#   - unique or error
#   - all numbers
#   - less than 19 chars
#   - luhn-10 verify
# list_project(project_name)
#   - project_name
#   - get_backers
#   - get_backer_amounts
# list_backer(backer_name)
#   - get all projects backed by backer and amounts
#
