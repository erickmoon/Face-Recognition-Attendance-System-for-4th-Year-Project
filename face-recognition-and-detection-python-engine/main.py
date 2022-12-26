import random
import sys

import cv2
import numpy
import project_face_recognition
import os
from urllib.parse import urlencode
from datetime import datetime
import urllib
import urllib.request

#Args passed from executable build
var1 = (sys.argv[1])
var2 = (sys.argv[2])
var3 = (sys.argv[3])


#Define images path
path = "C:\\xampp\\htdocs\\dlib-face-recognition-backend-ui\\images"
images = []
classNames = []
myList = os.listdir(path)
print("Encoding...")
print(myList)
mode_c = False

# Read images
for cl in myList:
    curImg = cv2.imread(f'{path}/{cl}')
    images.append(curImg)
    classNames.append(os.path.splitext(cl)[0])


# Finding face encodings
def findEncodings(images):
    encodeList = []
    for img in images:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = project_face_recognition.face_encodings(img)[0]
        encodeList.append(encode)
    return encodeList


#### MODE SCREEN (Incase you want to scan image on screen)
# def captureScreen(bbox=(300,300,690+300,530+300)):
#     capScr = np.array(ImageGrab.grab(bbox))
#     capScr = cv2.cvtColor(capScr, cv2.COLOR_RGB2BGR)
#     return capScr

encodeListKnown = findEncodings(images)
print('Encoding Complete')

cap = cv2.VideoCapture(0)

# Marking attendance function
def markAttendance(name):
    try:
        now = datetime.now()
        time = now.strftime('%I:%M:%S:%p')
        date = now.strftime('%d-%B-%Y')

        # API Location
        url = 'http://127.0.0.1/dlib-face-recognition-backend-ui/apis/mark-attendance.php'
        # API parameters
        data = {'name': name, 'date': date, 'time': time, 'var1': var1, 'var2': var2, 'var3': var3}

        f = urllib.parse.urlencode(data)
        f = f.encode('utf-8')
        # encoded_data = urlencode(data)
        website = urllib.request.urlopen(url, f)
        print(website.read())
    except:
        print("Failure!")




# Loop webcam to prevent it from closing immediately after launch
while True:
    success, img = cap.read()
    # img = captureScreen()
    imgS = cv2.resize(img, (0, 0), None, 0.25, 0.25)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)

    facesCurFrame = project_face_recognition.face_locations(imgS)
    encodesCurFrame = project_face_recognition.face_encodings(imgS, facesCurFrame)

    for encodeFace, faceLoc in zip(encodesCurFrame, facesCurFrame):
        matches = project_face_recognition.compare_faces(encodeListKnown, encodeFace)

        #Finding similarity and disimilarity to supposed face
        faceDis = project_face_recognition.face_distance(encodeListKnown, encodeFace)
        # print(faceDis)
        matchIndex = numpy.argmin(faceDis)

        percentage_similarity = faceDis[1] * 100

        print("Similarity score: " + percentage_similarity + "%")

        if matches[matchIndex]:
            name = classNames[matchIndex].upper()
            # print(name)
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.rectangle(img, (x1, y2 - 35), (x2, y2), (0, 255, 0), cv2.FILLED)
            cv2.putText(img, name, (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)

            if percentage_similarity > 50:
                markAttendance(name)
            else:
                print("Face not recognized")


    cv2.imshow('Webcam', img)
    cv2.waitKey(1)
