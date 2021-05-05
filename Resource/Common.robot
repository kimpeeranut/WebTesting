*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Click SubMenu
    [Arguments]    ${XpathMenu}
    # Step 2 Select Dropdown Task
    wait until page contains element    xpath:${XpathMenu}
    click element  xpath:${XpathMenu}

Click DropDown and Submenu
    [Arguments]    ${XpathMenu}     ${XpathSubMenu}
    # Step 1 Click Drop down
    set selenium timeout    20 seconds
    wait until page contains element    xpath:${XpathMenu}
    click element  xpath:${XpathMenu}
    # Step 2 Select Dropdown Task
    wait until page contains element    xpath:${XpathSubMenu}
    click element  xpath:${XpathSubMenu}