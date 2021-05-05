*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${expectedLogoutMessage}=    This section on Arthur is locked
*** Keywords ***
Logout to system
    set selenium timeout    10 seconds
    set selenium speed  1
    # Step 1 Click on profile section
    wait until page contains element    xpath://*[@data-panel='account']
    click element  xpath://*[@data-panel='account']
    # Step 2 Click on Dropdown
    wait until page contains element    xpath://div[@id="accountPanel10787264b9e8cd8a1368d166815af95e48dc0b"]//*[@class='btn btn-secondary no-shadow']
    click button  xpath://div[@id="accountPanel10787264b9e8cd8a1368d166815af95e48dc0b"]//*[@class='btn btn-secondary no-shadow']
    # Step 3 Click on Log out
    wait until page contains element    xpath://ul[not(@style='display:none;')]//*[@href="/users/logout/entity:robottester"]
    click element  xpath://ul[not(@style='display:none;')]//*[@href="/users/logout/entity:robottester"]

Validate to Logout to system
    set selenium speed  1
    # Step 1 Get log out message
    wait until page contains element    xpath://div[@class='alert alert-error align-center']//strong
    ${actual} =   get text  xpath://div[@class='alert alert-error align-center']//strong
    # Step 2 Validate Task is created successful
    log to console  expected:${expectedLogoutMessage}__actual:${actual}
    Should Be True     """${expectedLogoutMessage}""".lower() == """${actual}""".lower()