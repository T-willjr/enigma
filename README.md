# enigma

Functionality: 3
  - Enigma methods work
  - Enigma Command Line interface works
  - Uses message.txt file for original message and creates a new file for encrypted/decrypted message 
  - User can give any name for new file in command line 

Object Oriented Programming: 3
  - After refactoring project adheres to single responsibility and no class/module is too big
  - Seperated into three parts. 
    * Enigma Class  
      - Contains only two methods: #Encrypt & #Decrypt       
    * ShiftGenerator Module 
      - Contains only methods related to creating the shift  
    * MessageChanger Module
      - Contains only methods related to changing the message

Ruby Conventions and Mechanics: 2.5 
  - Follows Ruby conventions and mechanics 
  - Some tests expects are kind of long/strange looking. 
    * Needed #encrypt/#decrypt method test to be run first as the expected included results from that method
      * Exp: Lines 64-71      

Test Driven Development: 2.5
  - Test coverage: 100%
  - Git history shows test are being written before implmentation code 
  - Not all methods have tests explicity written for them
  - Methods are tested as a result of being apart of other methods 

Version Control: Passing
  - Has 52 commits. 8 pull requests from related branches demonstrates logical workflow. 
