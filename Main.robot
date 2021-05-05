*** Settings ***
Library  SeleniumLibrary
Resource  Scenario/Login_to_system.robot
Resource  Scenario/Logout_of_system.robot
Resource  Scenario/Add_a_property_with_a_multiple_rentable_units.robot
Resource  Scenario/Add_a_task_related_to_above_property.robot

Test Setup      open browser  https://staging.arthuronline.co.uk/login?X-MODE=QA-eW91LXdpbi1ub3RoaW5nCg  chrome
Test Teardown   close browser

*** Variables ***
${PropertyName}
${TaskName}


*** Test Cases ***
Scenario1
    Login to system
    Validate to Login to system

Scenario2
    Login to system
    ${PropertyName}=     Add property
    log to console  Created Property Name : ${PropertyName}
    set global variable     ${PropertyName}
    Validate Created Property       ${PropertyName}

Scenario3
    log to console  Created Task related to Property Name : ${PropertyName}
    Login to system
    ${TaskName}=    Add Task related Property  ${PropertyName}  Test_description    20/10/2099  11:15
    set global variable     ${TaskName}
    Validate New Task   ${TaskName}

Scenario4
    Login to system
    Logout to system
    Validate to Logout to system





