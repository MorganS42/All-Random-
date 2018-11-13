'''
Created on 18Sep.,2017

@author: 43312942
'''
import nltk, re, random, sqlite3, datetime, time, calendar
from nltk.chat.util import Chat, reflections
from nltk import word_tokenize, compat

conn = sqlite3.connect('train.db')

#pairs as per examples in nltk.chat.util for initial interface

pairs = [
    [
        r"(.*)timetable(.*)",
        [
            "Sure. What station would you like to leave from?"
        ],
    ],
    [
        r"(.*)trackwork(.*)",
        [
            "On what line are you planning to travel on?"
        ],
    ],
    [
        r"(.*)help(.*)",
        [
            "This service can provide information on train timetable or trackwork information. Please type either timetable or trackwork.",
        ],
    ],
    [
        r"quit",
        [
            "Okay, thank you for travelling with Sydney Trains - cost effective, reliable and convenient."
        ],
    ],
    [
        r"(.*)",
        [
            "Hmmm I don't understand. Please type either timetable or trackwork.",
        ],
    ],]


#override the nltk.chat.util functions with a custom Child Class

class ChildChat(Chat):
    
    '''
    TIMETABLE MEMBER FUNCTIONS
    '''
    
    #run the actual query, and interact with the timetable
    
    def trainQuery(self):
        input=""
        global fromStation,toStation,dayWeek,uTime #utilise global variables to keep track of details
        queryList=[]
        for row in conn.execute(sqlBuildTimetable(fromStation, toStation, uTime, dayWeek)):
            queryList = queryList + [row]
        print("Let me see - I have a train leaving "+ fromStation + " at " + queryList[0][1] + " and arriving at " + toStation + " at " + queryList[0][3])
        firstChoice = queryList[0] #save the original closest train
        queryList.sort(key=lambda tup: time.strptime(tup[1], "%H:%M")) #perform an in-place sort for later iteration based on time
        for n,y in enumerate(queryList):
            if y == firstChoice:
                index = n #keep track of the index position for smooth iteration
        if index==0:
            print("Would you like a later train?")
        elif index==len(queryList)-1:
            print('Would you like an earlier train?')
        else:
            print("Would you like an earlier or later train?")
        while 1:
            
            #try/catch block in an infinite loop to ensure smooth, repeatable input
            
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Type 'earlier' to see earlier trains, or 'later' to see later trains. If you are happy with your selection, type 'no thanks'")
                    self.trainQuery()
                inputTokens = word_tokenize(input, language='english') #tokenize to check patterns
                for x in inputTokens:
                    if x.lower() == "no": #always .lower() for matching purpose
                        self.quitChat()
                        break
                    elif x.lower() == "early" or x.lower() == "earlier":
                        if index==0:
                            print("Sorry, no earlier trains found. Would you like a later train?")
                        else:
                            index -=1
                            print("Let me check - I have a train leaving " + fromStation + " at " + queryList[index][1] + " and arriving at "+ toStation + " at " + queryList[index][3])
                            if index==0: #check if earlier/later trains even exist
                                print("Would you like a later train?")
                            else:
                                print("Would you like an earlier or later train?")
                    elif x.lower() == "late" or x.lower() == "later":
                        if index==len(queryList)-1:
                            print("Sorry, no later trains found. Would you like an earlier train?")
                        else:
                            index +=1
                            print("Let me check - I have a train leaving " + fromStation + " at " + queryList[index][1] + " and arriving at "+ toStation + " at " + queryList[index][3])
                            if index==len(queryList)-1:
                                print("Would you like an earlier train?")
                            else:
                                print("Would you like an earlier or later train?")
                    else:
                        print("Sorry, I didn't understand\n")
                        print("Would you like an earlier or later train?")
                        
    def converseTimetableTime(self):
        input=""
        validTime = re.compile(r'^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])') #validate 24h time
        global uTime
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Enter a time in the format of HH:MM (24 hour time), as a digit in range of 1-12, or the written word in range one-twelve")
                    print("What time do you want to leave?")
                    self.converseTimetableTime()
                inputTokens = word_tokenize(input, language='english')
                for p in inputTokens:
                    if validTime.search(p):
                        uTime = p
                        self.trainQuery()
                        break
                    elif (p.isdigit() and int(p) in range(1,12)): #validate whole hour time as ints
                        uTime = p +":00"
                        self.trainQuery()
                        break
                    elif p.lower() in clockNums.keys(): #validate written whole hour times as strings
                        uTime = str(clockNums.get(p.lower())) + ":00"
                        self.trainQuery()
                        break
                else:
                    print("Sorry, I don't understand\n")
                    print("What time do you want to leave?")
            else:
                print("Sorry, I don't understand\n")
                print("What time do you want to leave?")
                
    def converseTimetableDay(self):
        weekDays = ["monday","tuesday","wednesday","thursday","friday"]
        weekEnds = ["saturday","sunday"]
        input=""
        global dayWeek, fromStation
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Enter the day you want to leave by specifying weekend/weekday, the date in nth or n format, name of the day of week, or say 'next' to specify next week's dates")
                    print("Do you want to travel on a weekday or on a weekend?")
                    self.converseTimetableDay()
                nextTrigger = False #for using 'next' keyword eg. next week, next monday etc
                realDate = None #uninitialised date object
                inputTokens = word_tokenize(input, language='english')
                for x in inputTokens:
                    if x.lower() == "next":
                        nextTrigger = True
                    if x.lower() in weekDays or x.lower() in weekEnds:
                        realDate = getDateTime(x.lower(), nextTrigger) #get the date object for the proposed travel date
                    elif x.lower() == "weekday":
                        dayWeek = "WD"
                        print("Travelling on a weekday, and what time would you like to depart from " + fromStation + "?")
                        self.converseTimetableTime()
                        break
                    elif x.lower() == "weekend":
                        dayWeek = "WE"
                        print("Travelling on a weekend, and what time would you like to depart from " + fromStation + "?")
                        self.converseTimetableTime()
                        break
                    elif x.lower() in calNums.keys(): #see calNums, check calendar dates
                        realDate = getDateTime(x.lower(), nextTrigger)
                    elif x.lower()[:2].isdigit() and x.lower()[2:] in ("th","nd","st","rd"): #using slices instead of regex because i can
                        realDate = getDateTime(x.lower()[:2], nextTrigger)
                    elif x.lower()[:1].isdigit() and x.lower()[1:] in ("th","nd","st","rd"):
                        realDate = getDateTime(x.lower()[:1], nextTrigger)
                    elif x.lower() == "today":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d") #set the date used for the trackwork test
                    elif x.lower() == "tomorrow":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d") + datetime.timedelta(1) #timedelta to perform time arithmetic
                if realDate:
                    
                    #specify for SQL query
                    
                    if realDate.weekday() < 5:
                        dayWeek = "WD"
                    else:
                        dayWeek = "WE"
                    print("Travelling on " + realDate.strftime("%A, %B %d") + ", and what time would you like to depart from " + fromStation + "?")
                    self.converseTimetableTime()
                    break
                else:
                    print("Sorry, I don't understand\n")
                    print("Do you want to travel on a weekday or on a weekend?")
            else:
                print("Sorry, I don't understand\n")
                print("Do you want to travel on a weekday or on a weekend?")
                
    def converseTimetableTo(self):
        input=""
        global fromStation, toStation
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Please enter a valid station name (case insensitive)")
                    print("Which station would you like to travel to?")
                elif checkStations(input) and checkStations(input) != fromStation: #validate the names and make sure it's not the same station
                    toStation = checkStations(input)
                    print("Okay, to " + toStation + ", and do you want to travel on a weekday or on a weekend?")
                    self.converseTimetableDay()
                    break
                elif checkStations(input) == fromStation:
                    print("You're already at  " + fromStation + ", please pick a different station.\n")
                    print("Which station would you like to travel to?")
                else:
                    print("Sorry, I don't understand\n")
                    print("Which station would you like to travel to?")
            else:
               print("Sorry, I didn't catch that. Please try again \n")
               print("Which station would you like to travel to?")
               
    def converseTimetableFrom(self):
        input = ""
        global fromStation
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Please enter a valid station name (case insensitive)")
                    print("Which station would you like to travel from?")
                elif checkStations(input):
                    fromStation = checkStations(input)
                    print("Okay, " + fromStation + ", and where to?")
                    self.converseTimetableTo()
                    break
                else:
                    print("Hmmm sorry, I don't know of a station called " + input + "\n")
                    print("Which station would you like to leave from?")
            else:
               print("Sorry, I didn't catch that. Please try again \n")
               print("Which station would you like to leave from?")
               
    '''
    TRACKWORK FUNCTIONS
    I run trackwork and timetable as seperate member function groups to ensure there is no data overlap, but the structure and implementation is mostly similar
    '''
                
    def trackQuery(self):
        global lineName,trackDate,trackTime
        query = conn.execute(sqlBuildTrackwork(lineName, trackDate, trackTime))
        queryList=[]
        for x in query:
            queryList = queryList + [x]
        if queryList:
            queryLine = queryList[0][0]
            queryStartDate = datetime.datetime.strptime(queryList[0][1],"%Y-%m-%d %H:%M")
            queryEndDate = datetime.datetime.strptime(queryList[0][2],"%Y-%m-%d %H:%M")
            queryInfo = queryList[0][3]
            print("There is trackwork on the " + queryLine +  " on " + queryStartDate.strftime("%A %d %B %H:%M") + " to " + queryEndDate.strftime("%A %d %B %H:%M") + "; " + queryInfo)
            print("Would you like more information on timetable or trackwork?")
            self.converseMain()
        else:
            print("There is no trackwork")
            print("Would you like more information on timetable or trackwork?")
            self.converseMain()
            
    def converseTrackworkTime(self):
        input=""
        validTime = re.compile(r'^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])')
        print("At what time?")
        global trackTime
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Enter a time in the format of HH:MM (24 hour time), as a digit in range of 1-12, or the written word in range one-twelve")
                    print("What time do you want to leave?")
                    self.converseTrackworkTime()
                inputTokens = word_tokenize(input, language='english')
                for p in inputTokens:
                    if validTime.search(p):
                        trackTime = p
                        self.trackQuery()
                        break
                    elif (p.isdigit() and int(p) in range(1,12)): #validate whole hour time as ints
                        trackTime = p +":00"
                        self.trackQuery()
                        break
                    elif p.lower() in clockNums.keys(): #validate written whole hour times as strings
                        trackTime = str(clockNums.get(p.lower())) + ":00"
                        self.trackQuery()
                        break
                else:
                    print("Sorry, I don't understand\n")
                    print("At what time will you leave?")
            else:
                print("Sorry, I don't understand\n")
                print("What time do you want to leave?")
                
    def converseTrackworkDay(self):
        weekDays = ["monday","tuesday","wednesday","thursday","friday"]
        weekEnds = ["saturday","sunday"]
        input=""
        print("On what day will you be travelling?")
        global lineName, trackDate
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                    print("Enter the day you want to leave by specifying the day of week, date in nth or n format, or say 'next' in your statement for next week's dates")
                    print("On what day will you be travelling?")
                    self.converseTrackworkDay()
                nextTrigger = False
                realDate = None
                inputTokens = word_tokenize(input, language='english')
                for x in inputTokens:
                    if x.lower() == "next":
                        nextTrigger = True
                    if x.lower() in weekDays or x.lower() in weekEnds:
                        realDate = getDateTime(x.lower(), nextTrigger)
                    elif x.lower() in calNums.keys():
                        realDate = getDateTime(x.lower(), nextTrigger)
                    elif x.lower()[:2].isdigit() and x.lower()[2:] in ("th","nd","st","rd"):
                        realDate = getDateTime(x.lower()[:2], nextTrigger)
                    elif x.lower()[:1].isdigit() and x.lower()[1:] in ("th","nd","st","rd"):
                        realDate = getDateTime(x.lower()[:1], nextTrigger)
                    elif x.lower() == "today":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d")
                    elif x.lower() == "tomorrow":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d") + datetime.timedelta(1)
                if realDate:
                    trackDate = realDate
                    self.converseTrackworkTime()
                    break
                else:
                    print("Sorry, I don't understand\n")
                    print("On what day will you be travelling?")
            else:
                print("Sorry, I don't understand\n")
                print("On what day will you be travelling?")
                
    def converseTrackwork(self):
        input = ""
        global lineName
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                elif input=="help":
                   print("Please enter the name of the line you are travelling on, in the form 'NAME line'")
                   print("On what line are you planning to travel on?")
                   self.converseTrackwork()
                tokenInput = word_tokenize(input, language='english')
                for x,y in enumerate(tokenInput):
                    if x<len(tokenInput)-1:
                        if (y + " " + tokenInput[x+1]).lower() in lineList: #search 2 tokens at once
                            lineName = (y + " " + tokenInput[x+1]).upper()
                            self.converseTrackworkDay()
                            break
                print("Hmmm sorry, I don't understand. On what line are you planning to travel on?")
            else:
                print("I didn't catch that. On what line are you planning to travel on?")
    '''
    UNIVERSAL MEMBER FUNCTIONS
    '''
    def converseMain(self):
        input = ""
        timetable = re.compile(r"(.*)timetable(.*)") #use regex to show i know it but prefer another way
        trackwork = re.compile(r"(.*)trackwork(.*)")
        while 1:
            try: input = compat.raw_input(">")
            except EOFError:
                print(input)
            if input:
                if input=="quit":
                    self.quitChat()
                while input[-1] in "!.": input = input[:-1]
                print(self.respond(input)) #taken from nltk.chat.util to utilise reflections
            if trackwork.search(input):
                self.converseTrackwork()
                break
            if timetable.search(input):
                self.converseTimetableFrom()
                break
            
    def quitChat(self):
        print("Okay, thank you for travelling with Sydney Trains - cost effective, reliable and convenient.")
        quit()
        
'''
DATA STRUCTURES
'''
        
#used for checking station names
trainstations = conn.execute("""SELECT Station_Name from Station""")
stationList = []
for row in trainstations:
    stationList = stationList + [row[0].lower()]

#used for checking line names
trainlines = conn.execute("""SELECT Line_Name from Line""")
lineList = []
for row in trainlines:
    lineList = lineList + [row[0].lower()]

#used for converting written times to valid time strings
clockNums = {
    'one':1,
    'two':2,
    'three':3,
    'four':4,
    'five':5,
    'six':6,
    'seven':7,
    'eight':8,
    'nine':9,
    'ten':10,
    'eleven':11,
    'twelve':12,
}

#used for converting written dates to date objects
calNums = {
    'first': 1,
    'second': 2,
    'third': 3,
    'fourth': 4,
    'fifth': 5,
    'sixth': 6,
    'seventh': 7,
    'eighth': 8,
    'ninth': 9,
    'tenth': 10,
    'eleventh': 11,
    'twelfth': 12,
    'thirteenth': 13,
    'fourteenth': 14,
    'fifteenth': 15,
    'sixteenth': 16,
    'seventeenth': 17,
    'eighteenth': 18,
    'nineteenth': 19,
    'twentieth': 20,
    'twenty-first': 21,
    'twenty-second': 22,
    'twenty-third': 23,
    'twenty-fourth': 24,
    'twenty-fifth': 25,
    'twenty-sixth': 26,
    'twenty-seventh': 27,
    'twenty-eighth': 28,
    'twenty-ninth': 29,
    'thirtieth': 30,
    'thirty-first': 31,
}

'''
HELPER FUNCTIONS
'''

def getDateTime(day, nextornot):
    #returns the date object of the next corresponding day
    weekIndex = ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
    d = datetime.datetime.strptime("2017-09-16","%Y-%m-%d") #set base time to testing time
    
    #IF NAME OF DAY OF WEEK
    
    if day in weekIndex:
        for x,y in enumerate(weekIndex):
            if y == day.lower():
                dayNum = x #because index is same used in .weekday()
        for i in range(0,7):
            if (d.weekday() + i)%7 == dayNum: #modular arithmetic to wrap days of weeks
                if d.weekday() <= dayNum and nextornot==True: #special case for 'next' week
                    return d+datetime.timedelta(i+7)
                else:
                    return d+datetime.timedelta(i)
    
    #IF SPELLED DATES
    
    elif day in calNums.keys():
        if int(d.strftime("%d")) <= calNums.get(day): #int casting on date object string format because i can
            return d+datetime.timedelta(calNums.get(day) - int(d.strftime("%d")))
        elif int(d.strftime("%d")) > calNums.get(day):
            #using modular arithmetic to wrap dates to months
            if int(d.strftime("%m")) in (1,3,5,7,8,10,12):
                dayMod = 31
            elif int(d.strftime("%m")) in (4,6,9,11):
                dayMod = 30
            elif int(d.strftime("%m")) ==2 and isleap(int(d.strftime("%Y"))): #check for leapyear function using from inbuilt calendar module
                dayMod = 29
            elif int(d.strftime("%m")) ==2 and not isleap(int(d.strftime("%Y"))):
                dayMod = 28
            dateCount = int(d.strftime("%d"))
            for i in range(0,31):
                if (dateCount+i)%dayMod == calNums.get(day): #application of modular arithmetic
                    dayDelt = i
                    break
            return d+datetime.timedelta(dayDelt)
    
    #IF NUMERICAL INPUT
    
    elif int(day) in calNums.values(): #same deal, but for the numerical value as input now
        if int(d.strftime("%d")) <= int(day):
            return d+datetime.timedelta(int(day) - int(d.strftime("%d")))
        elif int(d.strftime("%d")) > int(day):
            if int(d.strftime("%m")) in (1,3,5,7,8,10,12):
                dayMod = 31
            elif int(d.strftime("%m")) in (4,6,9,11):
                dayMod = 30
            elif int(d.strftime("%m")) ==2 and isleap(int(d.strftime("%Y"))):
                dayMod = 29
            elif int(d.strftime("%m")) ==2 and not isleap(int(d.strftime("%Y"))):
                dayMod = 28
            dateCount = int(d.strftime("%d"))
            for i in range(0,31):
                if (dayCount+i)%dayMod == int(day):
                    dayDelt = i
                    break
            return d+datetime.timedelta(dayDelt)
    
def checkStations(stringput): #validate station names
    tokenInput = word_tokenize(stringput, language='english')
    #first check for double words, otherwise strathfield and north strathfield confusion
    for x,y in enumerate(tokenInput):
        if x<len(tokenInput)-1:
            if (y + " " + tokenInput[x+1]).lower() in stationList:
                return (y + " " + tokenInput[x+1]).upper()
    for q in tokenInput:
        if q.lower() in stationList:
            return q.upper()
    else:
        return ""


'''
SQL BUILDING FUNCTIONS
I use SQL query building functions to have better control and modularity over my code
'''
    
def sqlBuildTimetable(fromLocation, toLocation, depTime, weekPart):
    Select = "Select '" + fromLocation + "', x.Departure_Time, '" + toLocation + "', strftime('%H:%M',datetime(y.Departure_Time, '-1 minute'))"
    FromWhere = """FROM   Schedule x, Schedule y
    WHERE  x.Station_ID = (SELECT x.Station_ID FROM Station x
                           WHERE  UPPER(x.Station_Name) = '""" + fromLocation + """') 
    AND EXISTS (SELECT y.Station_ID
                WHERE  y.Train_ID = x.Train_ID
                AND y.Station_ID = (SELECT Station_ID FROM Station
                                    WHERE  UPPER(Station_Name) = '""" + toLocation + """')
                AND  x.Departure_Time < y.Departure_Time)"""
    PartOfWeek = """AND (SELECT Part_Of_Week
                    FROM   Train
                    WHERE  Train_ID = x.Train_ID) = '""" + weekPart + "'"
    OrderBy = """ORDER BY
                  ABS(strftime('%s', x.Departure_Time) - strftime('%s', '""" + depTime + """')) ASC;"""
    return Select + "\n" + FromWhere + "\n" + PartOfWeek + "\n" + OrderBy

def sqlBuildTrackwork(line, depDay, depTime):
    return """SELECT Line_Name, Start_Date, End_Date, Message
    FROM  Trackwork x, Line y  
    WHERE x.Line_ID = y.LINE_ID AND UPPER(Line_Name) = '""" + line + """' AND
          (strftime( '%s', Start_Date ) <= strftime( '%s', '""" + depDay.strftime("%Y-%m-%d") + " " + depTime + """') AND
           strftime( '%s', End_Date )   >= strftime( '%s', '""" + depDay.strftime("%Y-%m-%d") + " " + depTime + """'))"""

'''
MAIN RUNNING FUNCTIONS
'''
    
def trainChat_basic():
    print("""Welcome to Sydney Train's text-based rail information service. This service will help you by finding convenient ways to travel by asking you a number of questions. If you are not sure about how to answer a question, simply type 'help'. You can 'quit' the conversation anytime.\n""")
    print("""Would you like timetable information or information on trackwork?""")
    trainBot_basicMain = ChildChat(pairs, reflections) #initialise for pair/reflection combo
    trainBot_basicMain.converseMain()
    
def demo():
    trainChat_basic() #running like this similar to nltk.chat.util
    
if __name__ == "__main__":
   demo()