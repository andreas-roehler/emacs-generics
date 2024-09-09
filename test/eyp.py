#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import pdb
import random
import re
import sys
import time

# import wx

# app = wx.PySimpleApp()
# frame = wx.Frame(None,-1,"Roulade")
# frame.Show(1)
# app.MainLoop()

# treffer, gruen, rot, schwarz, pair, impair, passe, manque
args = sys.argv
# pdb.set_trace()
# Get the name of the file to count the words in

def usage():
    print("""Fehler: %s
Es muß die aufzurufende Ziehungszahl als Argument angegeben werden:
'python roulette.py 1, 'python roulette.py 2', ... 'python roulette.py n'.
""" % (
          os.path.basename(sys.argv[0])))

def main():
    if len(sys.argv) == 1:
        usage()
        # sys.exit()

    class asdf(object):
        zeit = time.strftime('%Y%m%d--%H-%M-%S')

        # def Utf8_Exists(filename) -> a[1:2]:
        def Utf8_Exists(filename):
            return os.path.exists(filename.encode('utf-8'))

if __name__ == "__main__":
    main()

import ipdb
ipdb.set_trace()
try:
    anzahl = int(args[1])
except:
    print("Setze anzahl auf 1")
    anzahl = 1

# class kugel(object) -> a[1:2]:
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    # zeit = time.strftime('%Y-%m-%d--%H-%M-%S')
    spiel = []
    gruen = [0]
    rot = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    schwarz = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]
    ausgabe = []
    treffer = None
    fertig = ''
    treffer = random.randint(0, 36)

    def pylauf(self):
        """Eine Doku fuer pylauf"""
        ausgabe = [" "," "," "," "," "," "," "," ", " "]

        ausgabe[0] = treffer
        fertig = ''
#        print("treffer, schwarz, gruen, rot, pair, impair, passe, manque, spiel")
        if treffer in gruen:

            ausgabe[1] = treffer
            ausgabe[2] = treffer
            ausgabe[3] = treffer
            ausgabe[4] = treffer
            ausgabe[5] = treffer
            ausgabe[6] = treffer
            ausgabe[7] = treffer

        elif treffer in schwarz:

            ausgabe[1] = treffer

        elif treffer in rot:

            ausgabe[3] = treffer

        self.geradheit = treffer % 2

        if 0 < self.geradheit:

            ausgabe[5] = treffer
        else:
            if 0 < treffer:

                ausgabe[4] = treffer

        if 0 < treffer:
            if 18 < treffer:

                ausgabe[6] = treffer
            else:

                ausgabe[7] = treffer
        ausgabe[8] = str(i+1)
#        print("ausgabe: %s " % ausgabe)
#        print("len(ausgabe): %s " % len(ausgabe))
        for laenge in range(len(ausgabe)):
            fertig = fertig + ";" + str((ausgabe[laenge]))
        fertig = fertig[1:]
#        print("fertig: %s " % fertig)
        spiel.append(fertig)
        print("treffer: %s " % treffer)
        return treffer
#        print("len(spiel): %s " % len(spiel))

zeit = kugel.zeit
ausgabe = kugel.ausgabe
spiel = kugel.spiel
gruen = kugel.gruen
rot = kugel.rot
schwarz = kugel.schwarz
treffer = kugel.treffer
fertig = kugel.fertig

klauf = kugel()

# with file("roulette-" + zeit + ".csv", 'w') as datei:
#     for i in range(anzahl):
#         klauf.pylauf()
#         datei.write(str(spiel[i]) + " ")

#     datei.write("treffer; schwarz; gruen; rot; pair; impair; passe; manque; spiel")
#     pri

''' asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf
'''

asd = 'asdf asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf'

afd = "asdf asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf"

a, b, c = (1, 2, 3)
a = b = c = 5

print('%(language)s has %(number)03d quote types.' %
       {'language': "Python", "number": 2})

print("%(language)s has %(number)03d quote types." %
       {'language': "Python", "number": 2})

# Ruby
# def deliver(from: "A", to: nil, via: "mail")
#  "Sending from #{from} to #{to} via #{via}"
