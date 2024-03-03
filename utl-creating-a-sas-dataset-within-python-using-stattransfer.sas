%let pgm=utl-creating-a-sas-dataset-within-python-using-stattransfer;

Creating a sas dataset within python using stattransfer (under development)

github
https://tinyurl.com/2jfhcrn9
https://github.com/rogerjdeangelis/utl-creating-a-sas-dataset-within-python-using-stattransfer

  PROGRAM FLOW

      1. Create a Panda dataframe by importing a sas dataset using pyreadstat
      2. Directory c:/temp must be available
      3. You need to create and save the python function at c:\temp\fn_tosas9.py
      4. You need  save the stattransfer script at at c:/temp/statcmd.stcmd(will be edited by python as needed)
      5. You need to load the function in your script
         exec(open('c:/temp/fn_tosas9.py').read())
      6. You need to call the python function
         fn_tosas9(
             students          /* Input python panda dataframe (same name for sas dataset)        */
            ,dfstr="students"  /* Quote input panda dataframe (no deparse(subsitute) in python?)  */
            ,timeest=3         /* You need to estimate the time it takes for stattransfer to work */
            )                  /* It seems that stattransfer does not provide a return code       */
                               /* Some form of a deadly embrace, only termonating the task works  */
                               /* You can only terminateafter the transfer has been completed     */
      8. The function creates a SPSS file that stattransfer will convert to a sas dataset
         Feather does not work and I was unable to conver a sqlite database table using stattransfer ODBC.
      7. The python function creates a subprocess to execute stattransfer
      8. After sleeping for n seconds the stattransfer subprocess is terminated.
         If you do not allow enough time the sas dataste will not be created.
         I looked at python mutiprocessing but gave up because it seems very complex
         I don't think it is posiible to get a completion code from stattrasfer. Looked into spawnging but failed to get it to work.
      9 I also provided a clean task script if yo get zombie tasks. (also easy to close rogue command windows)
/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

 /**************************************************************************************************************************/
 /*                                         |                                                |                             */
 /*     INPUT PANDA DATAFRAME               | PROCESS(NOTE TIME ESTIMATE)                    |    OUTPUT SAS DATASET       */
 /*                                         |                                                |                             */
 /*                                         |                                                |                             */
 /* <class 'pandas.core.frame.DataFrame'>   | %utl_pybegin;                                  |  NAME  SEX AGE HEIGHT WEIGHT*/
 /* RangeIndex: 1900 entries, 0 to 1899     | parmcards4;                                    |                             */
 /*                                         | import os                                      | Alfred  M   14   69   112.5 */
 /* Data columns (total 5 columns):         | import sys                                     | Alfred  M   14   69   112.5 */
 /*  #   Column  Non-Null Count  Dtype      | import pandas as pd                            | Alfred  M   14   69   112.5 */
 /* ---  ------  --------------  -----      | import pyreadstat as ps                        | Alfred  M   14   69   112.5 */
 /*  0   NAME    1900 non-null   object     | import subprocess                              | Alfred  M   14   69   112.5 */
 /*  1   SEX     1900 non-null   object     | import time                                    | Alfred  M   14   69   112.5 */
 /*  2   AGE     1900 non-null   float64    | students,meta=ps.read_sas7bdat \               | Alfred  M   14   69   112.5 */
 /*  3   HEIGHT  1900 non-null   float64    | ("d:/sd1/have.sas7bdat")                       | Alfred  M   14   69   112.5 */
 /*  4   WEIGHT  1900 non-null   float64    | exec(open('c:/temp/fn_tosas9.py').read())      |                             */
 /*                                         | fn_tosas9(students,dfstr="students",timeest=3) |                             */
 /* dtypes: float64(3), object(2)           | ;;;;                                           |                             */
 /* memory usage: 74.3+ KB                  | %utl_pyend;                                    |                             */
 /*                                         |                                                |                             */
 /*          NAME SEX   AGE  HEIGHT  WEIGHT |  PYTHON FUNCTION                               |                             */
 /* 0      Alfred   M  14.0    69.0   112.5 |                                                |                             */
 /* 1      Alfred   M  14.0    69.0   112.5 |  see below                                     |                             */
 /* 2      Alfred   M  14.0    69.0   112.5 |                                                |                             */
 /* 3      Alfred   M  14.0    69.0   112.5 |                                                |                             */
 /* 4      Alfred   M  14.0    69.0   112.5 |                                                |                             */
 /* ...       ...  ..   ...     ...     ... |                                                |                             */
 /* 1895  William   M  15.0    66.5   112.0 |                                                |                             */
 /* 1896  William   M  15.0    66.5   112.0 |                                                |                             */
 /* 1897  William   M  15.0    66.5   112.0 |                                                |                             */
 /* 1898  William   M  15.0    66.5   112.0 |                                                |                             */
 /* 1899  William   M  15.0    66.5   112.0 |                                                |                             */
 /*                                         |                                                |                             */
 /* [1900 rows x 5 columns]                 |                                                |                             */
 /*                                         |                                                |                             */
 /**************************************************************************************************************************/

 /*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  set sashelp.class;
  do i=1 to 100;
    output;
  end;
  drop i;
run;quit

  NAME  SEX AGE HEIGHT WEIGHT

 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5
 Alfred  M   14   69   112.5

This is converted to a panda dataframe.
I wanted to use a python version od R read table but could not find it.
This would have eliminating importing the sas dataset

/*           _      __                  _   _               _                  ___
 _ __  _   _| |_   / _|_   _ _ __   ___| |_(_) ___  _ __   (_)_ __    ___ _   / / |_ ___ _ __ ___  _ __
| `_ \| | | | __| | |_| | | | `_ \ / __| __| |/ _ \| `_ \  | | `_ \  / __(_) / /| __/ _ \ `_ ` _ \| `_ \
| |_) | |_| | |_  |  _| |_| | | | | (__| |_| | (_) | | | | | | | | || (__ _ / / | ||  __/ | | | | | |_) |
| .__/ \__,_|\__| |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_| |_|_| |_| \___(_)_/   \__\___|_| |_| |_| .__/
|_|                                                                                               |_|
*/

filename ft15f001 "c:/temp/fn_tosas9.py";
parmcards4;
def fn_tosas9(dataf,dfstr="location",timeest=0 ):

   pthsav = "c:/temp/" + dfstr + ".sav"
   pthsd1 = "c:/temp/" + dfstr + ".sas7bdat"
   statcmd= "c:/temp/statcmd.stcmd"

   if os.path.exists(pthsav):
       os.remove(pthsav)
   else:
       print("The file does not exist")

   if os.path.exists(statcmd):
       os.remove(statcmd)
   else:
       print("The file does not exist")

   if os.path.exists(pthsd1):
       os.remove(pthsd1)
   else:
       print("The file does not exist")

   ps.write_sav(dataf, (pthsav))

   f = open("c:/temp/statcmd.stcmd", "a");
   f.writelines([
    "set numeric-names        n                "
   ,"\nset log-level          e                "
   ,"\nset in-encoding        system           "
   ,"\nset out-encoding       system           "
   ,"\nset enc-errors         sub              "
   ,"\nset enc-sub-char       _                "
   ,"\nset enc-error-limit    100              "
   ,"\nset var-case-ci        preserve-always  "
   ,"\nset preserve-label-sets y               "
   ,"\nset preserve-str-widths n               "
   ,"\nset preserve-num-widths n               "
   ,"\nset recs-to-optimize   all              "
   ,"\nset map-miss-with-labs n                "
   ,"\nset user-miss          all              "
   ,"\nset map-user-miss      n                "
   ,"\nset sas-date-fmt       mmddyy           "
   ,"\nset sas-time-fmt       time             "
   ,"\nset sas-datetime-fmt   datetime         "
   ,"\nset write-file-label   none             "
   ,"\nset write-sas-fmts     n                "
   ,"\nset sas-outrep         windows_64       "
   ,"\nset write-old-ver      1                "
   ,"\ncopy " + pthsav + " sas9 " + pthsd1 ])
   f.close()
   cmds="c:/PROGRA~1/StatTransfer16-64/st.exe c:/temp/statcmd.stcmd"
   devnull = open('NUL', 'w');
   rc = subprocess.Popen(cmds, stdout=devnull, stderr=devnull)
   time.sleep(timeest)
   os.system(f"taskkill /f /im {'st.exe'}")
;;;;
run;quit;
filename ft15f001 clear;

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_pybegin;
parmcards4;
import os
import sys
import pandas as pd
import pyreadstat as ps
import subprocess
import time
students,meta=ps.read_sas7bdat \
("d:/sd1/have.sas7bdat")
exec(open('c:/temp/fn_tosas9.py').read())
fn_tosas9(
   students
   ,dfstr="students"
   ,timeest=3
   )
;;;;
%utl_pyend;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
           ___  |_|                    __   _             _            _                        _____ _         _       _
  ___ _   / / |_ ___ _ __ ___  _ __   / /__| |_ _   _  __| | ___ _ __ | |_ ___     ___  __ _ __|___  | |__   __| | __ _| |_
 / __(_) / /| __/ _ \ `_ ` _ \| `_ \ / / __| __| | | |/ _` |/ _ \ `_ \| __/ __|  / __|/ _` / __| / /| `_ \ / _` |/ _` | __|
| (__ _ / / | ||  __/ | | | | | |_) / /\__ \ |_| |_| | (_| |  __/ | | | |_\__ \ _\__ \ (_| \__ \/ / | |_) | (_| | (_| | |_
 \___(_)_/   \__\___|_| |_| |_| .__/_/ |___/\__|\__,_|\__,_|\___|_| |_|\__|___/(_)___/\__,_|___/_/  |_.__/ \__,_|\__,_|\__|
                              |_|
*/

libname tmp "c:/temp";
proc print data=tmp.students;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.HAVE total obs=1,900                                                                                              */
/*                                                                                                                        */
/*  Obs     NAME     SEX AGE    HEIGHT WEIGHT                                                                             */
/*                                                                                                                        */
/*    1    Alfred     M   14      69   112.5                                                                              */
/*    2    Alfred     M   14      69   112.5                                                                              */
/*    3    Alfred     M   14      69   112.5                                                                              */
/*    4    Alfred     M   14      69   112.5                                                                              */
/*    5    Alfred     M   14      69   112.5                                                                              */
/*    6    Alfred     M   14      69   112.5                                                                              */
/*    7    Alfred     M   14      69   112.5                                                                              */
/*    8    Alfred     M   14      69   112.5                                                                              */
/*  ....                                                                                                                  */
/* 1896    William    M   15    66.5     112                                                                              */
/* 1897    William    M   15    66.5     112                                                                              */
/* 1898    William    M   15    66.5     112                                                                              */
/* 1899    William    M   15    66.5     112                                                                              */
/* 1900    William    M   15    66.5     112                                                                              */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
