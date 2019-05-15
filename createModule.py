import os
import re
import subprocess
import sys
filename="android/app/build.gradle"
def mainfunc():
    if len(sys.argv)>=2 and sys.argv[1] == 'app':

        subprocess.call("mv android/app/build.gradle_1  android/app/build.gradle",shell=True)
        return
    if os.path.exists(filename):
        print("exist")
        file_str=""
        file_str_copy=""
        with open(filename ,'r',encoding='utf-8') as gradle_file:
            file_str=gradle_file.read()
            file_str_copy=str(file_str)
            file_str=file_str.replace("'com.android.application'","'com.android.library'",1)

            try:
                file_str=file_str.replace(re.findall(r"applicationId \".*?\"",file_str)[0],"")
            except Exception as identifier:
                pass
        with open(filename+"_temp" ,'w',encoding='utf-8') as gradle_file:
            gradle_file.write(file_str)
        subprocess.call("mv android/app/build.gradle  android/app/build.gradle_1",shell=True)
        subprocess.call("mv android/app/build.gradle_temp  android/app/build.gradle",shell=True)
if __name__ == "__main__":
    mainfunc()

