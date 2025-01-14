#!/usr/bin/python3

import os

def allrepofiles():
  repo = '/var/lib/pacman/local'
  files = set()
  for dirpath, dirnames, filenames in os.walk(repo):
    for file in filenames:
      if file != 'files':
        continue
      with open(os.path.join(dirpath, file)) as f:
        files.update('/' + l.rstrip() for l in f)
  return files

def main(startdir):
  managed = allrepofiles()
  for dirpath, dirnames, filenames in os.walk(startdir, topdown=False):
    for f in filenames:
      p = os.path.join(dirpath, f)
      if p not in managed:
        print(p, 'not managed')

if __name__ == '__main__':
  main('/usr')
