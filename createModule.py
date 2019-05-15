import os
import re
import subprocess
filename="android/app/buid.gradle"
if os.path.exists(filename):
    print("exist")
    with open(filename ,'r+',encoding='utf-8') as gradle_file:
        file_str=gradle_file.read()
        file_str_copy=str(file_str)
        file_str.replace("'com.android.application'","'com.android.library'",1)
        file_str.replace(re.findall(r"applicationId \".*?\"",file_str)[0],"")
        gradle_file.write(file_str)
        subprocess.call("flutter build apk",shell=True)
        gradle_file.write(file_str_copy)

