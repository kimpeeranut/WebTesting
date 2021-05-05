*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${expectedLogin}=  Robot Tester 1
*** Keywords ***
Login to system
    set selenium timeout    10 seconds
    set selenium speed  1
    maximize browser window
    input text  name:data[User][email]   robot+tester_1@firecreekweb.com
    input text  name:data[User][password]    Qwerty66#
    wait until page contains element    xpath://input[@value='Log in']
    click button    xpath://input[@value='Log in']

Validate to Login to system
    set selenium timeout    10 seconds
    set selenium speed  1
    # Step 1 Click on profile section
    wait until page contains element    xpath://*[@data-panel='account']
    click element  xpath://*[@data-panel='account']
    # Step 2 Click on profile section
    wait until page contains element    xpath://div[@class='my-account main-account']//div[@class='name']
    ${actual} =   get text  xpath://div[@class='my-account main-account']//div[@class='name']
    # Step 3 Validate Task is created successful
    log to console  expected:${expectedLogin}__actual:${actual}
    Should Be True     """${expectedLogin}""".lower() == """${actual}""".lower()
