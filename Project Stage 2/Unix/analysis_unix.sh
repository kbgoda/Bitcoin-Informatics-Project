#! /usr/bin/env bash

#The number of lines in the file including the header
wc -l mergeLBAUD.csv

#The number of rows do not have a N/A value for BTC
tail -n+2 mergeLBAUD.csv | egrep -v 'N/A' | wc -l

#The highest weighted price of BTCAUD and the date it was in
cut -d',' -f'1,9' mergeLBAUD.csv | sort -t',' -k'2n' | tail -1

#The total number of rows where the opening price of BTCAUD is greater than $700
cut -d',' -f'3' mergeLBaud.csv | awk '$0 > 700 {print $0}' | wc -l

#Gets the date where LTC was worth 0.008BTC and the BTC high (4rth column)
#at the exchanges was over $315
grep '0.00800' mergeLBAUD.csv | awk -F',' '$4 > 315 {print $1}'

#Gets the largest 'close' value recorded for Bitcoin where
#the 'high' is greater than $350 and the 'low' is less than $300
cut -d',' -f'4,5,6' mergeLBAUD.csv | awk -F',' '$1 > 350 && $2 < 300 { print $3 }' |\
sort -n | tail -1

#The date where both BTCAUD's weighted_price and LTCBTC's were at their lowest together overall
cut -d',' -f'1,2,9' mergeLBAUD.csv | tail -n+2 |\
sort -t',' -k'3,3n' -k'2,2n' | head -1 | cut -d',' -f'1'
