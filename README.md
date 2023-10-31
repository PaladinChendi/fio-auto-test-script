## fio auto test script
this is a shell script for automated testing of fio tool.<br/>
the script can execute test cases automatically, obtain and display test results.<br/>

## referennce document
fio official documents：https://fio.readthedocs.io/en/latest/fio_doc.html<br/>
linux user manul：https://linux.die.net/man/1/fio<br/>

## usage method
edit the fio.conf, rename the conf file, suck as iodepth.conf, numjobs.conf and so on. <br/>
sh fio_cases.sh [runtime|blocksize|numjobs|iodepth|combo] <br/>

## example
```
[root@localhost ~]# sh run iodepth
randread_4k
iodepth iops    bw(Mib/s)       clat(usec)
1       2128 8.512 892.69
2       4926 19.2 766.98
4       9808 38.3 774.15
8       20100 78.3 773.88
16      30500 119 1030.79
24      38400 150 1231.68
32      52000 203 1214.18
40      49000 195 1584.82
50      38400 150 2586.52
60      37100 145 3211.02
70      35000 140 3871.24
80      34700 136 4583.65
randwrite_4k
iodepth iops    bw(Mib/s)       clat(usec)
1       1369 5.478 1412.22
2       2816 11.0 1371.93
4       5478 21.4 1413.40
8       10600 41.2 1470.22
16      19600 76.5 1604.12
24      28400 111 1665.18
32      34100 133 1854.52
40      41400 162 1914.70
50      43700 171 2271.41
60      45600 178 2613.06
70      45400 178 3064.07
80      45200 176 3525.63
read_1m
iodepth iops    bw(Mib/s)       clat(usec)
1       190 190 10303.29
2       386 386 10154.59
4       705 705 11055.01
8       1429 1430 10957.94
16      1476 1476 21425.68
24      1442 1443 33029.10
32      1438 1438 44250
40      1437 1437 55400
50      1422 1422 69020
60      1486 1486 79420
70      1502 1502 91820
80      1453 1454 108650
write_1m
iodepth iops    bw(Mib/s)       clat(usec)
1       96 96.7 20396.58
2       176 176 22361.33
4       311 311 25270
8       661 661 23840
16      985 985 32120
24      994 995 47910
32      993 994 64050
40      1003 1004 79330
50      1011 1011 98210
60      1015 1016 116220
70      1009 1010 136610
80      986 986 160090
```
