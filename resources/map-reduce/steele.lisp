(in-package "ACL2")
(include-book "map-reduce")

(defconst *STEELETEXT*
'( Growing a Language Guy L STOP Steele Jr STOP Sun Microsystems Laboratories
 October 22 1998

  Most of the time I do not read my talks SEMISTOP I plan the main points
 and then speak off the top of my head STOP For this talk I need to stick
 to a text and for good cause STOP Please bear with me STOP
 I think you know what a man is STOP A woman is more or less like a man
 but not of the same sex STOP This may seem like a strange thing for me
 to start with but soon you will see why STOP Next I shall say that a
 person is a woman or a man young or old STOP

 To keep things short when
 I say  he  I mean  he or she  and when I say  his  I mean  his or her STOP 
 A machine is a thing that can do a task with no help or not much help from
 a person STOP As a rule we can speak of two or more of a thing if we add n 
 s  or  z  sound to the end of a word that names it STOP These are names of
 persons: Alan Turing Alonzo Church Charles Kay Ogden Christopher Alexander
 Eric Raymond Fred Brooks John Horton Conway James Gosling Bill Joy and
 Dick Gabriel STOP The word other means  not the same STOP  The phrase other
 than means  not the same as STOP  A number may be nought or may be one more
 than a number STOP In this way we have a set of numbers with no bound STOP
 There are other numbers as well but I shall not speak more of them yet
 STOP These numbers nought or one more than a number can be used to count
 things STOP We can add two numbers if we count up from the first number
 while we count down from the number that is not the first till it come to
 nought SEMISTOP then the first count is the sum STOP 4+2 = 5+1 = 6+0 = 6 

 We shall take the word many to mean  more than two in number STOP  Think
 of a machine that can keep track of two numbers and count each one up or
 down and test if a number be nought and by such a test choose to do this or
 that STOP The list of things that it can do and of choices that it can make
 must be of a known size that is some number STOP Here you can see the two
 numbers and a list STOP Each row in the list has a state name SEMISTOP
 the word  up  or  down SEMISTOP and which number to count upor count down STOP
 For  up  we have the name of the next state to go to and the machine counts the
 number up by one SEMISTOP for  down  the machine first tests the number and so
 we have the name of the new state to go to if the number be nought and the
 name of the new state to go to if the number be other than nought in which
 case the machine counts the number down by one STOP A computer is a machine
 that can do at least what that machine can and we have good cause to think
 that if a computer task can be done at all then the two-number machine can
 do it too if you put numbers in and read them out in the right way STOP

 In some sense all computers are the same SEMISTOP we know this thanks to
 the work of such persons as Alan Turing and Alonzo Church STOP A vocabulary
 is a set of words STOP A language is a vocabularyand rules for what a string
 of words might mean to a person or a machine that hears them STOP To define
 a word is to tell what it means STOPWhen you define a word you add it to your
 vocabulary and to the vocabulary of each person who hears you STOP Then you 
can use the word STOP To program is to make up a list of things to do and
 choices to make to be done by a computer STOP Such a list is called a program
 STOP A noun can be made from a verb to mean that which is done as meant by that
 verb SEMISTOP to make such a noun we add  ing  to the verb stem STOP Thus we
 can speak of  programming STOP  A programming language is a language that
 we can use to tell a computer a program to do STOP Java is abrand name for a
 computer programming language STOP I shall speak of the Java programming
 language a great deal more in this talk STOP I haveto say the full phrase 
 Java programming language  for there is a guy who works where I do who deals
 with the laws of marks of trade and he told me I have to say it that way
 STOP Names of other programming languages are Fortran APL Pascal and PL/I STOP

 A part of a program that does define a new word for use in other parts of the
 program is called a definition STOP Not all programming languages have a way
 to code definitions but most do STOP Those that do not are for wimps STOP
 Should a programming language be small or large? A small programming language
 might take but a short time to learn STOP A large programming language may take
 a long long time to learn but then it is less hard to use for we then have a lot
 of words at hand|or I should say at the tips of our tongues|to use at the drop
 of a hat STOP If we start with a small language then in most cases we can not
 say much at the start STOP We must first define more words SEMISTOP then we
 can speak of the main thing that is on our mind STOP We can use a verb in the
 past tense if we add a  d  or  ed  sound at the end of the verb STOP In the
 same way we can form what we call a past participle which is a form of the
 verb that says of a noun that what the verb means has been done to it STOP

 For this talk I wanted to show you what it is like to use a language that is
 much too small STOP You have now had agood taste of it STOP I must next define
 a few more words STOP An example is some one thing out of a set of things that
 I put in front of you so that you can see how some part of that thing is in
 fact a partof each thing in the set STOP A syllable is a bit of sound that a
 mouth and tongue can say all at one time more or less in a smooth way STOP
 Each word is made up of one or more syllables STOP A primitive is a word for
 which we can take it for granted that we all know what it means STOP For this
 talk I chose to take as my primitives all the wordsof one syllable and no more 
 from the language I use for most of my speech each day which is called English
 STOP My firm rule for this talk is that if I need to use a word of two or more
 syllables I must first define it STOP I can do this by defining one word at a
 time and I have done so or I can give a rule by which a new word can be made
 from some other known word so that many new words can be defined at once|and
 I have done this as well STOP This choice to start withjust words of one
 syllable was why I had to define the word  woman  but could take the word
 man  for granted STOP I wanted to define machine  in terms of the word 
 person  and it seemed least hard to define  person  as  a man or a woman 
 but then by chance the word  man  has one syllable and so is a primitive
 but the word  woman  has two syllables and so I had to define it STOP

 In a language other than English the words that mean  man  and  woman 
 might each have one syllable or might each have two syllables in which
 case one would have to take some other tack STOP We have to dothis a lot
 when we write real computer programs: a thought that seems like a primitive
 in our minds turns out not to be a primitive ina programming language and
 in each new program we must define it once more STOP A good example of this
 is max which yields the more large of two numbers STOP It is a primitive
 thought to me but few programming languages have it as a primitive SEMISTOP
 I have to define it STOP This is the sort of thing that makes a computer look
 like a person who is but four years old STOP Next to English all computer  
 programming languages are small SEMISTOP as we write code we must stop now and
 then to define some new term that we will need to use in more than one place STOP
 Some persons find that their programs have a few large chunks of code that do
 the  real work  plus a large pile of small bits of code that define new words
 so to speak to be used as if they were primitives STOP I hope that this talk
 brings home to you in a way you can feel in your heart not just think in your
 head what it is like to have to program in that way STOP This should show you
 true to life what it is like to use a small language STOP

 Each time I have tried this sort of thing I have found that I can not say much
 at all till I take the time to define at least a few new terms STOP In other
 words if you want to get far at all with a small language you must first add
 to the small language to make a language that is more large STOP In some cases
 we will find it more smooth to add the syllable  er  tothe end of a word than
 to use the word  more  in front of it SEMISTOP inthis way we might say  smoother
 in place of  more smooth STOP  Let me add that better means  more good STOP
 In truth the words of one syllable form quite a rich vocabulary with which you
 can say many things STOP You may note that this vocabulary is much larger than
 that of the language called Basic English defined by Charles Kay Ogden in the
 year one-nine-three-nought STOP I chose not to use Basic English for this talk
 the cause being that Basic English has many wordsof two or more syllables some
 of them quite long handed down to us from the dim past of Rome STOP While Basic
 English has fewer words it does not give the feel to one who speaks full English
 of being a small language STOP By the way from now on I shall use the word
 because to mean  the cause being that STOP  If we look at English and then
 at programming languages we see that all our programming languages seem small
 STOP And yet we can say too in some cases that one programming language is
 smaller than some other programming language STOP A design is a plan for how
 to build a thing STOP To design is to build a thing in one's mind but not yet
 in the real world or better yet to plan how the real thing can be built STOP

 The main thing that I want to ask in this talk is: If I want to help other
 persons to writeall sorts of programs should I design a small programming
 language or a large one? I stand on this claim: I should not design a small
 language and I should not design a large one STOP I need to design a language
 that can grow STOP I need to plan ways in which it might grow|but I need too
 to leave some choices so that other persons can make those choices at a later
 time STOP This is not a new thought STOP We have known for some time that huge
 programs can not be coded from scratch all at once STOP There has to be a plan
 for growth STOP What we must stop to think on now is the fact that languages
 have now reached that large size where they can not be designed all at once
 much less built all at once STOP 

 Let me pause to define some names for numbers STOP Twenty is twice ten STOP
 Thirty is thrice ten STOP Forty is twice twenty STOP A hundred is ten times
 ten STOP A million is a hundred times a hundred times a hundred STOP Sixteen
 is twice eight STOP Seven is one plus six STOP Fifty is one more than seven
 squared STOP One more thing: ago means  in the past counting back from now STOP

 In the past it made sense to design a whole language once for all STOP
 Fortran was a small language forty years ago designed for tasks with numbers
 and it served well STOP PL/I was thought a big language thirty years ago but
 now we would think of it as small STOP Pascal was designed as a small whole
 language with no plan to add to it at a later time STOP That was five-and-twenty
 years ago STOP What came to pass? Fortran has grown and grown STOP Many new
 words and new rules have been added STOP The new design is not bad SEMISTOP
 the parts fit well one with the other STOP But to many programmers who have
 used Fortran for a long time the Fortran of here and now is not at all the
 same as the language they first came to know and love STOP It looks strange STOP

 PL/I has not grown much STOP It is for the most part just as it was when it
 first came out STOP It may be that this is just from lack of use STOP The flip
 side is that the lack of use may have two causes STOP Number one: PL/I was not
 designed to grow STOP It was designed to be all things to all who program right
 from the start STOP Number two: for its time it started out large STOP
 No one knew all of PL/I SEMISTOP some said that no one could know all of PL/I
 STOP Pascal grew just a tad and was used to build many large programs STOP
 One main fault of the first design was that strings were hard to use because
 they were all of fixed size STOP Pascal would have been of no use for the
 building of large programs for use in the real world if this had not been changed
 STOP But Wirth had not planned for the language to change in such ways and in
 fact few changes were made STOP At times we think of C as a small language
 designed from whole cloth STOP But it grew out of a smaller language called B
 and has since grown to be a larger language called C plus plus STOP A language
 as large as C plus plus could nothave spread so wide if it had been foisted
 on the world all at once STOP It would have been too hard to port STOP

 One more rule for making words: if we add the syllable  er  to a verb stem
 we make a noun that names the person or thing that does what the verb says
 to do STOP For example a buyer is one who buys STOP A user is one who does
 use STOP As you may by now have guessed I am of like mind with my good friend 
 Dick Gabriel who wrote the well known screed Worse Is Better STOP 
 The real name was  Lisp: Good News Bad News How to Win Big  which is all words
 of just one syllable which might seem like good luck for me but the truth is
 that Dick Gabriel knew how to choose words with punch STOP Yet what first comes
 to mind for most persons is the part headed  Worse Is Better and so that is how
 they cite it STOP The gist of it is that the best way  to get a language used
 by many persons is not to design and build  The Right Thing because that will
 take too long STOP In a race a small language with warts will beat a well
 designed language because users will not wait for the right thing SEMISTOP
 they will use the language that is quick and cheap and put up with the
 warts STOP 
 Once a small language fills a niche it is hard to take its place STOP Well
 then could not  The Right Thing  be a small language not hard to port but
 with no warts? I guess it could be done but I for one am not that smart or
 have not had that much luck STOP But in fact I think it can not be done STOP
 Five-and-twenty years ago when users did not want that much from a programming
 language one could try STOP Scheme was my best shot at it STOP But users will
 not now with glad cries glom on to a language that gives them no more than
 what Scheme or Pascal gave them STOP They need to paint bits lines and boxes
 on the screen in hues bright and wild SEMISTOP they need to talk to printers
 and servers through the net SEMISTOP they need to load code on the y SEMISTOP
 they need their programs to work with other code they don't trust SEMISTOP
 they need to run code in many threads and on many machines SEMISTOP they need
 to deal with text and sayings in all the world's languages STOP 
 A small programming language just won't cut it STOP So a small language can
 not do the job right and a large language takes too long to get o the ground
 STOP Are we doomed to use small languages with many warts because that is
 the sole kind of design that can make it in the world? At one time this
 thought filled me with gloom STOP But then I saw a gap in my thinking STOP
 I said that users will not wait for  The Right Thing  but will use what comes
 first and put up with the warts STOP 
 But|users will not put up with the warts for all time STOP It is not long till
 they scream and moan and beg for changes STOP The small language will grow
 STOP The warts will be shaved o or patched STOP If one person does all the work
 then growth will be slow STOP But if one lets the users help do the work growth
 can be quick STOP If many persons work side by side and the best work is added
 with care and good taste a great deal can be added in a short time STOP APL was
  designed by one man a smart man|and I love APL|but it had a aw that I think
 has all but killed it: there was no way for a user to grow the language in a
 smooth way STOP In most languages a user can define at least some new words
 to stand for other pieces of code that can then be called in such a way that
 the new words look like primitives STOP In this way the usercan build a larger
 language to meet his needs STOP But in APL new words defined by the user do not
 look like language primitives at all STOP The name of a piece of user code is a
 word but things that are built in are named by strange glyphs STOP To add what
 look like new primitives to keep the feel of the language takes a real hacker
 and a ton of work STOP This has stopped users from helping to grow the language
 STOP APL has grown some but the real work has been done by just the few 
 programmers that have the source code STOP If a user adds to APL and what he
 added seems good to the hackers in charge of the language they might then make
 it be built in but code to use it would not look the same SEMISTOP the user
 would have to change his code to a new form because in APL a use of what is
 built in does not look at all like a call to user code STOP Lisp was designed
 by one man a smart man and it works in a way that I think he did not plan for
 STOP In Lisp newwords defined by the user look like primitives and what is more
 all primitives look like words defined by the user! In other words if a user has
 good taste defining new words what comes out is a larger language that has no
 seams STOP The designer in charge can grow the language with close to no work
 on his part just by choosing withcare from the work of many users STOP
 And Lisp grew much faster than APL did because many users could try things
 out and put their best code out there for other users to use and to add to the
 language STOP Lisp is not used quite as much as it used to be but parts of it
 live on in other languages the best of which is called garbage collection and

 I will not try to tell you now what that means in words of one syllable | 
 I leave it to you as a task to try in your spare time STOP This leads me to claim
 that from now on a main goal in designing a language should be to plan for
 growth STOP The language must start small and the language must grow as the
 set of users grows STOP I nowthink that I as a language designer helping out
 with the Java programming language need to ask not  Should the Java programming
 language grow?  but  How should the Java programming language grow?  There is 
 more than one kind of growth and more than one way to doit STOP But as we shall
 see if the goal is to be quick and yet to dogood work one mode may be better by
 far than all other modes STOP There are two kinds of growth in a language STOP
 One can change the vocabulary or one can change the rules that say what a string
 of words means STOP A library is a vocabulary designed to be added to a 
 programming language to make the vocabulary of the programming language larger
 STOP Libraries means more than one library STOP A true library does not change
 the rules of meaning for the language SEMISTOP it just adds new words STOP

 You can see from this that in my view the code that lets you do a  long jump
 in C is not a true library STOP Of course there must be a way for a user to make
 libraries STOP But the key point is that the new words defined by a library
 should look just like primitives of the language STOP Some languages are like
 this and some are not STOP Those that are not are harder to grow with the help
 of users STOP It maybe good as well to have a way to add to the rules of meaning
 for a language STOP Some ways to do this work better than other ways STOP
 But the language should let work done by a user look just like what was designed
 at the start STOP I would like to grow the Java programming language in such a
 way that users can do more of this STOP In the same way there are two ways to
 do the growing STOP
 One way is for one person or a small group to be in charge and to take in
 test judge and add the work done by other persons STOP The other way is to
 just put all the source code out there once things start to work and let each
 person do as he wills STOP To have a person in charge can slow things down but
 to have no one in charge makes it harder to add up the workof many persons STOP

 The way that is faster and better than all other ways does both STOP Put the
 source code out there and let all persons play with it STOP Have a person in
 charge who is a quick judge of good work and who will take it in and shove
 it back out fast STOP You don't have to use what he ships and you don't have
 to give back your work but he gives all persons a fast way to spread new code
 to those who want it STOP The best example of this way to do things is Linux
 which is an operating system which is a program that keeps track of other
 programs in a computer and gives each its due in space and time STOP You ought
 to read what Eric Raymond had to say of how Linux came to be STOP I shall tell
 you a bit of it once I define two more words for you STOP A cathedral is a huge
 church STOP It may be made of stone SEMISTOP it may fill you with awe SEMISTOP
 but the key thought in the mind of Eric Raymond is that there is but one design
 one grand plan which may takea long time many years to make real STOP As the
 years pass few changes are made to the plan STOP Many many persons are needed
 to build it but there is just one designer STOP

 A bazaar is a place with many small shops or stalls where you can buy things
 from many persons who are there to sell their wares STOP The key thought here
 is that each one sells what he
 wants to sell and each one buys what he wants to buy STOP There is no one
 plan STOP Each seller or buyer may change his mind atwhim STOP Eric Raymond
 wrote a short work called  The Cathedral and the Bazaar  in which he looks
 at how programs are built or have been built in the past STOP You can find
 it on his web site STOP http://www STOPtuxedo STOPorg/~esr/writings/cathedral-bazaar
 He talks of how he builta mail fetching program with the help of more than
 two hundred users STOP He quotes Fred Brooks as saying  More users find more
 bugs  and backs him up with tales from this example of building a program in
 the bazaar style STOP As for the role of the programmer-in-charge Eric Raymond
 says that it is fine to come up with good thoughts but much better to know them
 when you see them in the work of other persons STOP You can get a lot more done
 that way STOP

 Linux rose to its heights of fame and wide use in much the same way though on
 a much larger scale STOP To take this thought to the far end of the line:
 it maybe that one could write an operating system by putting a million apes
 to work at a million typing-machines then just spotting the bits of good work
 that come out by chance and pasting them up to make a whole STOP But that might
 take a long time I guess STOP Too bad! But the key point of the bazaar is not
 that you can get many persons to work with you at a task for cathedral-builders
 had a great deal of help too STOP Nor is the key point that you get help with
 the designing as well as with the building though that in fact is a big win STOP

 No the key point is that in the bazaar style of building a program or designing
 a language or what you will the plan can change in real time to meet the needs
 of those who work on it and use it STOP This tends to make users stay with it
 as time goes by SEMISTOP they will take joyin working hard and helping out if
 they know that their wants and needs have s ome weight and their hard work can
 change the plan for the better STOP Which brings me to the high point of my
 talk STOP It seems in the last few years at least that if one is asked to speak
 at this meeting one must quote Christopher Alexander STOP I know a bit of his
 work though not a lot and I must say thanks to Dick Gabriel for pointing out
 to me a quote that has a lot to do with the main point of this talk STOP I am
 sad to say that I do not know what this quote means because Christopher
 Alexander tends to use many words of more than one syllable and he does not
 define them first STOP But I have learned to say these words by rote and it
 may be that you out there can glean some thoughts of use to you STOP
 Christopher Alexander says: Master plans have two additional unhealthy
 characteristics STOP To begin with the existence of a master plan alienates
 the users STOP After all the very existence of a master plan means by definition
 that the members of the community can have little impact on the future shape
 of their community because most of the important decisions havealready been
 made STOP In a sense under a master plan people are living with a frozen future
 able to affect only relatively trivial details STOP When people lose the sense
 of responsibility for the environment they live in and realize that they are
 merely cogs in someone else's machine how can they feel any sense of
 identification with the community or any sense of purpose there? from The 
Oregon Experiment I think this means in part that it is good to give your
 users a chance to buy in and to pitch in STOP It is good for them and it
 is good for you STOP In point of fact a number of cathedrals were built
 in the bazaar mode STOP Does this mean then that it is of no use to design?
 Not at all STOP But instead of designing a thing you need to design a way
 of doing STOP And this way of doing must make some choices now but leave
 other choices to a later time STOP
 Which brings me to the word you all want to hear: a pattern is a plan that
 has some number of parts and shows you how each part turns a face to the
 other parts how each joins with the other parts or stands off how each part
 does what it does and how the other parts aid it or drag it down and how
 all the parts may be grasped as a whole and made to serve as one thing for
 some higher goal or as part of a larger pattern STOP A pattern should give
 hints or clues as to when and where it is best put to use STOP What is more
 some of the parts of a pattern may beholes or slots in which other things
 may be placed at a later time STOP A good pattern will say how changes can
 be made in the course oftime STOP Thus some choices of the plan are built
 in as part of the pattern and other choices wait till the time when the
 pattern is to be used STOP In this way a pattern stands for a design space
 in which you can choose on the y your own path for growth and change STOP
 It is good to design a thing but it can be far better and far harder to
 design a pattern STOP Best of all is to know when to use a pattern STOP

 Now for some more computer words STOP A datum is a set of bits that has a
 meaning SEMISTOP data is the mass noun for a set of datums STOP An object 
is a datum the meanings of whose parts are laid down by a set of language
 rules STOP In the Java programming language these rules use types to make
 clear which parts of an object may cite other objects STOP Objects may be
 grouped to form classes STOP Knowing the class of an object tells you most
 of what you need to know of how that object acts STOP Objects may have
 fields SEMISTOP each field of an object can hold a datum STOP Which datum
 it holds may change from time to time STOP Each field may have a type which
 tells you what data can be in that field at run time and what is more it
 tells you what data can not be in that field at run time STOP A method is
 a named piece of code that is part of an object STOP If you can name or
 cite an object then you can call amethod of that object SEMISTOP the method
 then does its thing STOP The Java programming language has objects and classes
 and fields and methods and types STOP Now I shall speak of some things that
 the Java programminglanguage does not yet have STOP

 A generic type is a map
 from one or more types to a type STOP Put an other way a generic type is a
 pattern for building types STOP A number of groups of persons have set forth
 ways to add generic types to the Java programming language SEMISTOP each way
 has its own good points STOP We heard three talks on adding generic types to
 the Java programming language at this meeting less than three-and-twenty hours
 ago STOP An operator is a glyph such as a plus sign that can be used in a
 language as if it were a word STOP In C or the Java programming language as
 in English the sign first known as  and per se and  is an operator but a full
 stop or quote mark is notan operator STOP A word is said to be overloaded if 
 it is made to meantwo or more things and the hearer has to choose the meaning
 based on the rest of what is said STOP For example using the rules defined
 near the start of this talk a verb form such as  painted  might bea past tense
 or a past participle and it is up to you the hearer to make the call as to which
 I mean when I say it STOP At some times by some persons an overloaded word is
 called polymorphic which means that the word has many forms SEMISTOP but the
 truth is that the word has but one form and many meanings STOP The definition
 of a word may bepolymorphic but the word as such is not STOP An operator can
 be overloaded in C plus plus but right now operators in the Java programming
 language can not be overloaded by the programmer though names ofmethods may
 be overloaded STOP I would like to change that STOP I have said in the past
 and will say now that I think it would be a good thing for the Java programming
 language to add generic types and to let the user define overloaded operators STOP
 Just as a user can code methods that can be used in just the same way as methods
 that are built in the user ought to have a way to define operators for
 user-defined classes that can be used in just the same way as operators
 thatare built in STOP What is more I would add a kind of class that is of
 light weight one whose objects can be cloned at will with no harmand so could
 be kept on a stack for speed and not just in the heap STOP Classes of this kind
 would be well-suited for use as user-defined number types but would have other
 uses too STOP You can find a plan for all this on a web page by James Gosling
 STOP

 There are a few other things we could add as well such as tail calls and
 ways to read and write those machine ags for numbers whose points oat STOP
 But these are small language tweaks next to generic types and overloaded
 operators STOP If we grow thelanguage in these few ways then we will not
 need to grow it in a hundred other ways SEMISTOP the users can take on
 the rest of the task STOP To see why think on these examples STOP
 A complex number is a pair of numbers STOP There are rules for how to
 find the sum of two complex numbers or a complex number times a complex
 number: a SEMISTOP b + c SEMISTOP d = a + c SEMISTOP b+ d  a SEMISTOP
 b x c SEMISTOP d = a x c + b x d SEMISTOP a x d + b x c Some programmers
 like to use them a lot SEMISTOP other programmers do not use themat all STOP
 So should we make  complex number  a type in the Java programming language?
 Some say yes of course SEMISTOP other persons say no STOP A rational number
 is a pair of numbers STOP There are rules not the same as the rules for
 complex numbers of course for how to find thesum of two rational numbers or
 a rational number times a rationalnumber: a SEMISTOP b + c SEMISTOP
 d = a x d + b x c SEMISTOP b x d  a SEMISTOP b x c SEMISTOP d = a x c SEMISTOP
 b x d A few programmers like to use them a lot SEMISTOP most do not use them
 at all STOP So should we make  rational number  a type in the Java programming
 language?

 An interval is a pair of numbers STOP There are rules not the same as the
 rules for complex numbers or rational numbers of course for how to find
 the sum of two intervals or an interval times an interval: a SEMISTOP
 b + c SEMISTOP d = a + c SEMISTOP b + d  a SEMISTOP b x c SEMISTOP
 d = min a x c SEMISTOP a x d SEMISTOP b x c SEMISTOP b x d SEMISTOP
 max a x c SEMISTOP ax d SEMISTOP b x c SEMISTOP b x d  A few programmers
 like to use them a lot and wish all the other programmers who use numbers
 would use them too SEMISTOP but most do not use them at all STOP So should
 we make  interval  a type in the Java programming language?

 John Horton Conway once defined a game to be a pair of sets of games see
 his book On Numbers and Games  then pointed out that some games may be
 thought of as numbers that say how many moves it will take to win the
 game STOP There arerules for how to find the sum of two games and so on:
 A SEMISTOPB + C SEMISTOPD = { a + C SEMISTOPD | a in A} U { A SEMISTOP
B + c | c in C SEMISTOP {b + C SEMISTOPD | b in B} U { A SEMISTOPB + d | d
 in D} - A SEMISTOPB = {-b | b in B} SEMISTOP{-a | a in A} A ?? B = A + 
??B  A SEMISTOPB  STOP C SEMISTOPD = {a STOP C SEMISTOPD + A SEMISTOPB 
 STOP c - a STOPc | a in A SEMISTOP c in C} U {b STOP C SEMISTOPD +
 A SEMISTOPB
  STOP d - b STOP d | b in B SEMISTOPd inD} SEMISTOP {a STOP C SEMISTOPD
 + A SEMISTOPB  STOP d - a STOP d | a in A SEMISTOP d in D| U {b STOP C
 SEMISTOPD + A SEMISTOPB  STOP c - b STOP c | b in B SEMISTOP c in C}

 From this he worked out for hundreds of kinds of real games how to know
 which player will win STOP I think oh three persons in the world want
 to use this kind of number STOP Should we make it a type in the Java
 programming language? A vector is a row of numbers all of the same type
 with each place in the row named by the kind of number we first spoke
 of in this talk STOPThere are rules STOP STOP STOP In fact for vectors
 of length three there aretwo ways to do  a vector times a vector  so you
 can have twice the fun! a SEMISTOP b SEMISTOP c + d SEMISTOP e SEMISTOP
 f = a + d SEMISTOP b + e SEMISTOP c + f  a SEMISTOP b SEMISTOP c x d
 SEMISTOP e SEMISTOP f = a x d + b x e + c x f a SEMISTOP b SEMISTOP
 c x d SEMISTOP e SEMISTOP f = b x f -c x e SEMISTOP c x d - a x f
 SEMISTOP a x e - b x d Vectors of length three or four are a great
 aid in making bits on the screen look like scenes inthe real world
 STOP So should we make  vector  a type in the Java programming language?
 A matrix is a set of numbers laid out in a square STOP And there are rules
 not shown here! STOP So should we make  matrix  a type in the Java
 programming language? And so on and so on and so on STOP I might say
 yes  to each one of these but it is clear that I must say  no  to all
 of them!

 And so would James Gosling and Bill Joy STOP To add all these types to the
 Java programming language would be just too much STOP Some parts of the
 programming vocabulary are fit for all programmers to use but other parts
 are just for their own niches STOP It would not be fair to weigh down all
 programmers with the need to have or to learn all the words for all niche
 uses STOP

 We should not make the Java programming language a cathedral but a plain
 bazaar might be too loose STOP What we need is more like a shopping mall
 where there are not quite as many choices but most of the goods are well
 designed and sellers stand up and back what they sell STOP I could speak
 at length on the ways in which a shopping mall is like a cathedral but
 not here not now! Now the user could define objects for such numbers
 to have methods that act in the rightways but code to use such numbers
 would look strange STOP Programmers used to adding numbers with plus signs
 would kvetch STOP In fact the Java programming language does have a class of 
 big numbers  thathave methods for adding them and telling which is larger and
 all the rest and you can not use the plus sign to add such numbers and
 programmers who have to use them do kvetch STOP Generic types and overloaded
 operators would let a user code up all of these and in such a way that they
 would look in all ways just like types that are built in STOP They would let
 users grow the Java programming language in a smooth and clean way STOP


 And it would not be just for numbers SEMISTOP generic types would be good for
 coding hash sets for example and thereare many other uses STOP And each user
 would not have to code up such number classes each for his own use STOP When
 a language gives you theright tools such classes can be coded by a few and
 then put up aslibraries for other users to use or not as they choose SEMISTOP
 but they don't have to be built in as part of the base language STOP
 If you give a person a fish he can eat for a day STOP If you teach a person
 to fish he can eat his whole life long STOP If you give a person tools he
 can make a fishing pole|and lots of other tools! He can build a machine to
 crank out fishing poles STOP In this way he can help other persons to catch
 fish STOP Meta means that you step back from your own place STOP What you
 used to do is now what you see STOP What you were is now what you act on STOP
 Verbs turn to nouns STOP What you used to think of as apattern is now treated
 as a thing to put in the slot of an other pattern STOP A meta-foo is a foo in
 whose slots you can put parts of a foo STOP In a way a language design of the
 old school is a pattern for programs STOP But now we need to  go meta STOP 
 We should now think of a language design as being a pattern for language
 designs a tool for making more tools of the same kind STOP This is the nub
 of what I want to say STOP A language design can no longer be a thing STOP

 It must be a pattern|a pattern for growth|a pattern for growing the pattern
 for defining the patterns that programmers can use for their real work and
 their main goal STOP My point is that a good programmer in these times 
 does not just write programs STOP A good programmer builds a working vocabulary
 STOP In other words a good programmer does language design though not from
 scratch but building on the frame of a base language STOP In the course of
 giving this talk because I started with a small language I have had to define
 fifty or more new words or phrasesand sixteen names of persons or things
 SEMISTOP and I laid out six rules for making new words from old ones STOP

 In this way I added to the base language STOP If I were to write a book
 starting from just the words ofone syllable I am sure that I would have
 to define hundreds of new words STOP It should give no one pause to note
 that the writing of a program having a million lines of code might need
 many many hundreds of new words -- that is to say a new language built
 up on the base language STOP I will be so bold as to say that it can
 be done in no other way STOP Well there may be one other way which is
 to use a large rich programming language that has grown in the course
 of tens or hundreds of years that has all we need to say what we want
 to say that we are taught as we grow up and take for granted STOP It
 may be that a hundred years from now there will be a programming language
 that by then has stood the test of time needs no more changes for most
 uses and is used by all persons who write programs because each child
 learns it in school STOP But that is not where we are now STOP So STOP
 Language design is not at all the same kind of work it was thirty years
 ago or twenty years ago STOP Back then you could set out to design a
 whole language and then build it by your own self or with a small team
 because it was small and because what you would then do with it was small
 STOP

 Now programs are big messes with many needs STOP A small language won't
 do the job STOP If you design a big language all atonce and then try to
 build it all at once you will fail STOP You willend up late and some
 other language that is small will take your place STOP It would be great
 if there were some small programming language that felt large the way
 Basic English is small but feels large in some ways STOP But I don't
 know how to do it and I have good cause todoubt that it can be done
 at all STOP In its day APL was a small language that felt large SEMISTOP
 but our needs have grown and APL did not have a good pattern for growth
 STOP So I think the sole way to win is to plan for growth with help from
 users STOP This is a win for you because you have help STOP This is a
 win for the users because they get to have their say and get to bend
 the growth to their needs STOP But you need tohave one or more persons
 too or one or more groups to take on the task of judging and testing
 and sifting what the users do and say and adding what they think best
 to the big pile of code in the hope that other users will trust what
 they say and not have to go toall the work to test and judge and sift
 each new claim or each newpiece of code each for his own self STOP
 Parts of the language must be designed to help the task of growth
 STOP A good set of types ways for a user to define new types to add
 new words and new rules to the language to define and use all sorts
 of patterns|all these are needed STOP The designer should not for
 example define twenty kinds of number types in the language STOP

 blah blah blah

 But in real life it has worked out fine because the users have grown with
 the language and learned it piece by piece and they buy in to it because
 they have had some say in how to change the language STOP And the Java
 programming language needs to grow yet some more|but I hope not a lot
 more STOP At least I think only a few more rules areneeded|the rest
 can be done with libraries most of them built by users and not by Sun STOP

 If we add hundreds of new things to the Java programming language we will
 have a huge language but it will take a long time to get there STOP
 But if we add just a few things -- generic types operator overloading
 and user-defined types of light weight for use as numbers and small vectors
 and such | that are designed to let users make and add things for their own
 use I think we can go a long way and much faster STOP We need to put tools
 for language growth in the hands of the users STOP I hope that we can in 
 this way or some other way design a programming language where we don't
 seem to spend most of our time talking and writing in words of just one
 syllable STOP 
 
 One of the good things I can say for short words is that they make for
 short talks STOP They gave me an hour and a half for this talk and I
 have used less than an hour STOP Once I am done you will have time to
 go out in the hall have a cup of tea and talk with your friends STOP
 But first I would like to tell you what I have learned from the task
 of designing this talk STOP In choosing to give up themany long words
 that I have come to know since I was a child words that have many fine
 shades of meaning I made this task much harder than it needed to be STOP

 I hope that you have not found it too hard on your ears STOP But I found
 that sticking to this rule made me think STOPI had to take time to think
 through how to phrase each thought STOP And there was this choice for
 each new word: is it worth the work to define it or should I just stick
 with the words I have? Should I dothe work of defining a new word such
 as  mirror  or should I just say  looking glass  each time I want to
 speak of one? As an example I was tempted more than once to state the 
 ly  rule for making new words that change what verbs mean but in the
 end I chose to cast all such words to one side and make do STOP

 And I came that close to defining the word  without  but each time for
 better or for worse I found some other way to phrase my thought STOP
 I learned in my youth from the books of such great teachers of writing
 as Strunk and White that it is better to choose short words when I can STOP
 I should not choose long hard words just to make other persons think that
 I know a lot STOP I should try to make my thoughts clear SEMISTOP if they
 are clear and right then other persons can judge my work as it ought to be
 judged STOP From the work of planning this talk in which I have tried to
 go with this rule much more far than in the past I found that for the most
 part they were right STOP Short words work well if I choose them well STOP

 Thus I think that programming languages need to be more like the languages
 we speak but it might be good too if we were to use the languages we speak
 more in the way that we now use programming languages STOP All in all I think
 it might be a good thing if those who rule our lives those in high places who
 do the work of state those who judge what we do and most of all those who make
 the laws were made to define their terms and to say all else that they say
 in words of one syllable STOP For I have found that this mode of speech makes
 it hard to hedge STOP It takes work and greatcare and some skill to find just
 the right way to say what you want to say but in the end you seem to have no
 choice but to talk straight STOP If you do not veer wide of the truth you are
 forced to hit it dead on STOP I urge you too to give it a try STOP

))

