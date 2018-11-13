'''
Created on 18Sep.,2017

@author: 43312942
'''
import nltk, re, random, sqlite3, datetime, time, calendar, collections
from nltk.chat.util import Chat, reflections
from nltk import word_tokenize, compat
from collections import Counter

conn = sqlite3.connect('train.db')

#pairs as per examples in nltk.chat.util for initial interface

pairs = [
    [
        r"(.*)timetable(.*)",
        [
            "Sure. Where are you going, and when?"
        ],
    ],
    [
        r"(.*)trackwork(.*)",
        [
            "Sure. Where and when are you travelling?"
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

class ChildChatAdvanced(Chat):
    #saved as globals and initialised as null to prevent referencing errors
    global fromStation, toStation, dayTrip, dayTime, lineName, queryType, nextTrigger
    fromStation=None
    toStation=None
    dayTrip=None
    dayTime=None
    lineName=None
    queryType=None
    nextTrigger=False
    
        
    def converseMain(self):
        input = ""
        global fromStation, toStation, dayTrip, dayTime, lineName, queryType, nextTrigger
        lastIndex=-1
        validTime = re.compile(r'^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])')
        while 1:
            try: rawInput = compat.raw_input(">")
            except EOFError:
                print(rawInput)
            input=inputWSpellCheck(rawInput)
            if input:
                if input.lower()=="quit":
                    self.quitChat()
                elif input.lower()=="help":
                    print("Let us know how we can help you, by entering the information for timetables or trackwork")
                    self.converseMain() #all help prompts run back to main
                inputTokens = word_tokenize(input,language='english')
                for x,y in enumerate(inputTokens):
                    
                    #CHECK STATION NAMES FROM/TO BASED ON LAST INDICES

                    if checkStations(y.lower()) and x>0 and inputTokens[x-1].lower()=="from" and not fromStation:
                        #print('got here')
                        lastIndex = x
                        fromStation = checkStations(y.lower())
                    elif checkStations(y.lower()) and x>0 and inputTokens[x-1].lower()=="to" and not fromStation:
                        lastIndex = x
                        fromStation = checkStations(y.lower())
                    elif checkStations(y.lower()) and x>lastIndex and not toStation:
                        lastIndex = x
                        toStation = checkStations(y.lower())
                    elif checkStations(y.lower()) and not fromStation:
                        lastIndex = x
                        fromStation = checkStations(y.lower())

                    #CHECK LINE NAMES
                    
                    elif x<len(inputTokens)-1:
                        if (y + " " + inputTokens[x+1]).lower() in lineList: #search 2 tokens at once
                            lineName = (y + " " + inputTokens[x+1]).upper()
                    
                    #CHECKING DATES
                    elif y.lower() == "next":
                        nextTrigger = True
                    elif y.lower() in weekDays or y.lower() in weekEnds:
                        realDate = getDateTime(y.lower(), nextTrigger)
                        dayTrip = realDate
                    elif y.lower() in calNums.keys():
                        realDate = getDateTime(y.lower(), nextTrigger)
                        dayTrip = realDate
                    elif y.lower()[:2].isdigit() and y.lower()[2:] in ("th","nd","st","rd"):
                        realDate = getDateTime(y.lower()[:2], nextTrigger)
                        dayTrip = realDate
                    elif y.lower()[:1].isdigit() and y.lower()[1:] in ("th","nd","st","rd"):
                        realDate = getDateTime(y.lower()[:1], nextTrigger)
                        dayTrip = realDate
                    elif y.lower() == "today":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d")
                        dayTrip = realDate
                    elif y.lower() == "tomorrow":
                        realDate = datetime.datetime.strptime("2017-09-16","%Y-%m-%d") + datetime.timedelta(1)
                        dayTrip = realDate
                    
                    #CHECKING TIMES
                    
                    elif validTime.search(y):
                        dayTime = y
                    elif (y.isdigit() and int(y) in range(1,12)): #validate whole hour time as ints
                        dayTime = y +":00"
                    elif y.lower() in clockNums.keys(): #validate written whole hour times as strings
                        dayTime = str(clockNums.get(y.lower())) + ":00"
                    
                    #QUERY TYPE DEFINED
                    
                    elif y.lower() =="trackwork":
                        queryType='trackwork'
                    elif y.lower() =="timetable":
                        queryType='timetable'
                    
                #QUERY TYPE INFERRED
                
                if (fromStation or toStation) and not queryType:
                    queryType = 'timetable'
                elif lineName and not queryType:
                    queryType = 'trackwork'
                else:
                    print("Sorry, I still don't understand what you're after")
                    self.converseMain()
            #RESPONSE TO INPUT       
            if queryType == 'timetable':
                print("Ok, so you are travelling {frSt}{toSt}{daTi}{daDa}".format(
                    frSt=("from " +fromStation+" ") if fromStation else "",
                    toSt=("to " +toStation+" ") if toStation else "",
                    daTi=("at " +dayTime+" ") if dayTime else "",
                    daDa=("on " +dayTrip.strftime("%A %d %B")+" ") if dayTrip else ""
                    ))
                stillNeeded=[]
                for key,value in {'where you\'re coming from':fromStation, 'where you\'re going to':toStation, 'what time you\'re leaving' :dayTime, 'what day you\'re leaving':dayTrip}.items():
                    if  value== None:
                        stillNeeded = stillNeeded + [key]
                if stillNeeded:
                    print("We still need ",end='')
                for z in stillNeeded:
                    print(", " + z,end='')
                print("\n")
                if not stillNeeded:
                    self.sqlBuilders()
                else:
                    self.converseMain()
            elif queryType == 'trackwork':
                print("Ok, so you are travelling {liNa}{daTi}{daDa}".format(
                    liNa=("on the " +lineName+" ") if lineName else "",
                    daTi=("at " +dayTime+" ") if dayTime else "",
                    daDa=("on " +dayTrip.strftime("%A %d %B")+" ") if dayTrip else ""
                    ))
                stillNeeded=[]
                for key,value in {'lineName':lineName, 'what time you\'re leaving' :dayTime, 'what day you\'re leaving':dayTrip}.items():
                    if  value== None:
                        stillNeeded = stillNeeded + [key]
                if stillNeeded:
                    print("We still need ",end='')
                for z in stillNeeded:
                    print(", " + z,end='')
                print("\n")
                if not stillNeeded:
                    self.sqlBuilders()
                else:
                    self.converseMain()
                
        
    def sqlBuilders(self):
        #SQL BUILDERS
        global queryType, fromStation, toStation, dayTrip, dayTime, lineName
        if queryType == 'timetable':
            if dayTrip.weekday()<5:
                partWeek = 'WD'
            else:
                partWeek = 'WE'
            queryList=[]
            for row in conn.execute(sqlBuildTimetable(fromStation, toStation, dayTime, partWeek)):
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
                
                try: rawInput = compat.raw_input(">")
                except EOFError:
                    print(rawInput)
                input=inputWSpellCheck(rawInput)
                if input:
                    if input=="quit":
                        self.quitChat()
                    elif input=="help":
                        print("Type 'earlier' to see earlier trains, or 'later' to see later trains. If you are happy with your selection, type 'no thanks'")
                        print("Would you like an earlier or later train?")
                        self.sqlBuilders()
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
        if queryType == 'trackwork':
            query = conn.execute(sqlBuildTrackwork(lineName, dayTrip, dayTime))
            queryList=[]
            for x in query:
                queryList = queryList + [x]
            if queryList:
                queryLine = queryList[0][0]
                queryStartDate = datetime.datetime.strptime(queryList[0][1],"%Y-%m-%d %H:%M")
                queryEndDate = datetime.datetime.strptime(queryList[0][2],"%Y-%m-%d %H:%M")
                queryInfo = queryList[0][3]
                print("There is trackwork on the " + queryLine +  " on " + queryStartDate.strftime("%A %d %B %H:%M") + " to " + queryEndDate.strftime("%A %d %B %H:%M") + "; " + queryInfo)
                print("Would you like more information?")
                while 1:
                    try: rawInput = compat.raw_input(">")
                    except EOFError:
                        print(rawInput)
                    input2=inputWSpellCheck(rawInput)
                    if input2:
                        if input2.lower()=="quit":
                            self.quitChat()
                        elif input2.lower()=="help":
                            print("Let us know if you would like more help or not")
                            self.sqlBuilders()
                        tokens=word_tokenize(input2,language='english')
                        for n in tokens:
                            if n.lower() =='yes' or n.lower()=='yeah' or n.lower()=='yep' or n.lower()=='ye' or n.lower()=='yea':
                                print("Would you like any trackwork or timetable information?")
                                #reset variables
                                fromStation=None
                                toStation=None
                                dayTrip=None
                                dayTime=None
                                lineName=None
                                queryType=None
                                nextTrigger=False
                                lastIndex=-1
                                self.converseMain()
                                break
                            elif n.lower()=='no' or n.lower()=='nah' or n.lower()=='nope' or n.lower()=='na':
                                self.quitChat()
                        else:
                            print("Sorry, I don't understand")
                            print("Would you like more information?")
                            
            else:
                print("There is no trackwork")
                print("Would you like any trackwork or timetable information?")
                
                
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
weekDays = ["monday","tuesday","wednesday","thursday","friday"]
weekEnds = ["saturday","sunday"]
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
def inputWSpellCheck(inputstring):
    correctSpelledString=""
    rawString=""
    if inputstring:
        tokens = word_tokenize(inputstring)
        for n in tokens:
            correctSpelledString = correctSpelledString + correction(n) +" "
            rawString=rawString+n+" "
        if rawString != correctSpelledString:
            print("Did you mean \"" + correctSpelledString+"\" ? Type \'yes\' or \'no\'")
            while 1:
                try: input = compat.raw_input(">")
                except EOFError:
                    print(input)
                if input:
                    tokeners=word_tokenize(input)
                    if input.lower()=='quit':
                        self.quitChat()
                    elif input.lower()=="help":
                        print("Simply type yes or no")
                        inputWSpellCheck(inputstring)
                    elif input.lower()=="yes" or input.lower()=="y" or input.lower()=="yep" or input.lower()=="yea" or input.lower()=="yeah":
                            return correctSpelledString
                    elif input.lower()=='no' or input.lower()=='nah' or input.lower()=='nope' or input.lower()=='na':
                        return rawString
                    for j in tokeners:
                        if j.lower()=="yes" or j.lower()=="y" or j.lower()=="yep" or j.lower()=="yea" or j.lower()=="yeah":
                            return correctSpelledString
                        elif j.lower()=='no' or j.lower()=='nah' or j.lower()=='nope' or j.lower()=='na':
                            return rawString
                    print("Sorry, I didn't get that. Please type yes or no")
    else:
        return""

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
SPELLCHECKING FUNCTIONS FROM http://norvig.com/spell-correct.html
'''
def words(text): return re.findall(r'\w+', text.lower())
myString=""
for word in stationList+lineList:
    myString = myString+word+" "
    
seedText = myString+open('big.txt').read()

WORDS = Counter(words(seedText))

def P(word, N=sum(WORDS.values())): 
    "Probability of `word`."
    return WORDS[word] / N

def correction(word): 
    "Most probable spelling correction for word."
    return max(candidates(word), key=P)

def candidates(word): 
    "Generate possible spelling corrections for word."
    return (known([word]) or known(edits1(word)) or known(edits2(word)) or [word])

def known(words): 
    "The subset of `words` that appear in the dictionary of WORDS."
    return set(w for w in words if w in WORDS)

def edits1(word):
    "All edits that are one edit away from `word`."
    letters    = 'abcdefghijklmnopqrstuvwxyz'
    splits     = [(word[:i], word[i:])    for i in range(len(word) + 1)]
    deletes    = [L + R[1:]               for L, R in splits if R]
    transposes = [L + R[1] + R[0] + R[2:] for L, R in splits if len(R)>1]
    replaces   = [L + c + R[1:]           for L, R in splits if R for c in letters]
    inserts    = [L + c + R               for L, R in splits for c in letters]
    return set(deletes + transposes + replaces + inserts)

def edits2(word): 
    "All edits that are two edits away from `word`."
    return (e2 for e1 in edits1(word) for e2 in edits1(e1))

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
    print("""Would you like some information?""")
    trainBot_basicMain = ChildChatAdvanced(pairs, reflections) #initialise for pair/reflection combo
    trainBot_basicMain.converseMain()
    
def demo():
    trainChat_basic() #running like this similar to nltk.chat.util
    
if __name__ == "__main__":
    demo()