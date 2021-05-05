*** Settings ***
Library  SeleniumLibrary
Library  String
*** Variables ***
${task}
*** Keywords ***
Add Task related Property
    [Arguments]  ${propertyReference}   ${taskDescription}  ${dateDue}  ${timeDue}
    set selenium speed  1
    # Step 1 Click Drop down
    set selenium timeout    20 seconds
    wait until page contains element    xpath://a[@title='Tasks' and @href='/robottester/tasks/index']
    click element  xpath://a[@title='Tasks' and @href='/robottester/tasks/index']
    # Step 2 Select Dropdown Task
    wait until page contains element    xpath://ul[@class='children']//a[@href='/robottester/tasks/index']//span[text()='Tasks']
    click element  xpath://ul[@class='children']//a[@href='/robottester/tasks/index']//span[text()='Tasks']
    # Step 3 Click on Add property
    wait until page contains element    xpath://a[contains(text(),'Add Task')]//i[@class='fa fa-plus']
    click element  xpath://a[contains(text(),'Add Task')]//i[@class='fa fa-plus']
    # Step 4 Click Search Related Field
    wait until page contains element    xpath://a[@class='select2-choice select2-default']
    click element  xpath://a[@class='select2-choice select2-default']
    # Step 5 Input task related
    wait until page contains element    xpath://*[@id="select2-drop"]/div/input
    input text  xpath://*[@id="select2-drop"]/div/input     ${propertyReference}
    # Step 6 Enter to select
    wait until page contains element    xpath://div[@class='select2-result-label' and contains(text(),'${propertyReference}')]
    input text  xpath://*[@id="select2-drop"]/div/input     \n
    # Step 7 Input Description
    wait until page contains element    name:data[Task][description]
    input text  name:data[Task][description]    ${taskDescription}
    # Step 8 Input Date due
    wait until page contains element    name:data[Task][date_due]
    input text  name:data[Task][date_due]     ${dateDue}
    # Step 9 Input Time due
    wait until page contains element    name:data[Task][time_due]
    input text  name:data[Task][time_due]     ${timeDue}
    # Step 10 Input Assign to
    wait until page contains element    xpath://input[@class='select2-input select2-default']
    input text  xpath://input[@class='select2-input select2-default']     robot\n
    # Step 11 Click Task type
    wait until page contains element    name:data[Task][task_type_id]
    click element  name:data[Task][task_type_id]
    # Step 12 Select Deposit as Task type
    wait until page contains element    xpath://select[@name="data[Task][task_type_id]"]//option[@value='739684']
    click element  xpath://select[@name="data[Task][task_type_id]"]//option[@value='739684']
    # Step 13 Click save Task
    wait until page contains element    xpath://*[@id="TaskGlobalAddForm"]/div[4]/div[2]/div/input
    click element  xpath://*[@id="TaskGlobalAddForm"]/div[4]/div[2]/div/input
    # Step 14 Click save Task
    wait until page contains element    xpath://div[@class='identifier-detail']//div[@class='title']
    ${task} =   get text  xpath://div[@class='identifier-detail']//div[@class='title']
    return from keyword  ${task}

Validate New Task
    [Arguments]    ${arg}
    set selenium speed  1
    ${count}=    get element count      //ul[@class='children' and contains(@style,'hidden')]//a[@href='/robottester/tasks/index']
    Run Keyword If  "${count}" == "1"   Click DropDown and Submenu      //a[@title='Tasks' and @href='/robottester/tasks/index']    //ul[@class='children']//a[@href='/robottester/tasks/index']//span[text()='Tasks']
    Run Keyword If  "${count}" == "0"   Click SubMenu   //ul[@class='children']//a[@href='/robottester/tasks/index']//span[text()='Tasks']
    # Step 3 Search  Properties
    wait until page contains element    id:_q
    input text  id:_q   ${arg}\n
    # Step 4  Search and Get New Task Name that has been created
    sleep  5
    wait until page contains element    xpath://div[4]/table/tbody/tr[1]/td[2]//span/a
    ${actual} =   get text  xpath://div[4]/table/tbody/tr[1]/td[2]//span/a
    # Step 5 Validate Task is created successful
    log to console  expected:${arg}__actual:${actual}
    should contain    ${arg}    ${actual}