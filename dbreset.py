#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: David McCue

import sqlite3, sys

conn = sqlite3.connect('kickstarter.db')

conn.execute("DROP TABLE IF EXISTS 'project';")
conn.execute("CREATE TABLE 'project' ( id INTEGER PRIMARY KEY, name char(20) NOT NULL, target REAL NOT NULL );")

conn.execute("DROP TABLE IF EXISTS 'transaction';")
conn.execute("CREATE TABLE 'transaction' ( id INTEGER PRIMARY KEY, projectid INTEGER NOT NULL, name char(20) NOT NULL, cc INTEGER NOT NULL, amount REAL NOT NULL);")

conn.commit()
conn.close()

sys.exit(0)