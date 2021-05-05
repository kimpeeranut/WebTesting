*** Settings ***
Library  SeleniumLibrary
Library  String
Resource  ../Resource/Common.robot

*** Variables ***
${ProfileAddressName}
${Address} =   Catenate    SEPARATOR=---   HouseNo.   empty
${Checkbox}

*** Keywords ***
Add property
    ${RandomNumber} =  Generate Random String  8  [NUMBERS]
    ${ProfileAddressName} =  Generate Random String  8  [LETTERS]
    ${Address} =   Catenate    SEPARATOR=-   HouseNo.   ${RandomNumber}
    ${UnitCount} =  set variable  4
    set selenium speed  1
    # Step 1 Click Drop down
    set selenium timeout    20 seconds
    wait until page contains element    xpath://a[@title='Properties' and @href='/robottester/properties/index']
    click element  xpath://a[@title='Properties' and @href='/robottester/properties/index']
    # Step 2 Select Dropdown Property
    wait until page contains element    xpath://ul[@class='children']//a[@href='/robottester/properties/index']//span[text()='Properties']
    click element  xpath://ul[@class='children']//a[@href='/robottester/properties/index']//span[text()='Properties']
    # Step 3 Click on Add property
    wait until page contains element    xpath://a[contains(text(),'Add Property')]//i[@class='fa fa-plus']
    click element  xpath://a[contains(text(),'Add Property')]//i[@class='fa fa-plus']
    # Step 4 Click add as Multiple rentable units
    wait until page contains element    xpath://*[text()='Property with multiple rentable units']
    click element  xpath://*[text()='Property with multiple rentable units']
    # Step 5 Input Profile Name
    wait until page contains element    name:data[Profile][address_name]
    input text  name:data[Profile][address_name]    ${ProfileAddressName}
    # Step 6 Click Dropdown property owner
    wait until page contains element    xpath://div[@id='s2id_PropertyOwnerId']//div//b
    click element  xpath://div[@id='s2id_PropertyOwnerId']//div//b
    # Step 7 Click Select Owner 1 - Sansiri
    wait until page contains element    xpath://div[@class='select2-result-label' and text()='Owner 1 - Sansiri']
    click element  xpath://div[@class='select2-result-label' and text()='Owner 1 - Sansiri']
    # Step 8 input text  address
    wait until page contains element    name:data[Profile][address1]
    input text  name:data[Profile][address1]    ${Address}
    # Step 9 input text  postcode
    wait until page contains element    name:data[Profile][postcode]
    input text  name:data[Profile][postcode]    ${RandomNumber}
    # Step 10 input text  City
    wait until page contains element    name:data[Profile][city]
    input text  name:data[Profile][city]    Bangkok
    # Step 11 input text  Country
    wait until page contains element    name:data[Profile][county]
    input text  name:data[Profile][county]    Thailand
    # Step 12 click area code
    wait until page contains element    name:data[Profile][area_id]
    click element  name:data[Profile][area_id]
    # Step 13 click no match found
    wait until page contains element    xpath://select[@name='data[Profile][area_id]']//option[text()='No matches found']
    click element  xpath://select[@name='data[Profile][area_id]']//option[text()='No matches found']
    # Step 14 Input certificate type - Enter Gas and Enter to select auto suggestion
    wait until page contains element    xpath://div[@id='s2id_PropertyPropertyRequiredCertificateTypeIds']
    input text  id:s2id_autogen8     Gas\n
    # Step 15 Check checkbox should be selected on I manage this Property - If not then checked box I manage this Property
    wait until page contains element    xpath://input[@type='checkbox' and @name='data[Property][full_access]']
    ${Checkbox} =  Run Keyword And Return Status    checkbox should be selected  xpath://input[@type='checkbox' and @name='data[Property][full_access]']
    run keyword if  ${Checkbox} == False  check box if it is unchecked
    # Step 16 Input No. of Rentable Units
    wait until page contains element    name:data[Property][unit_count]
    input text  name:data[Property][unit_count]    ${UnitCount}
    # Step 17 Click submit form
    wait until page contains element    xpath://input[@value='Next, Units Settings ']
    click element  xpath://input[@value='Next, Units Settings ']
    # Step 18 Select Dropdown to select Unit type
    wait until page contains element    name:data[Prefix][Unit][unit_type_id]
    click element  name:data[Prefix][Unit][unit_type_id]
    # Step 19 Select Flat as unit type
    wait until page contains element    xpath://select[@name='data[Prefix][Unit][unit_type_id]']/option[3]
    click element  xpath://select[@name='data[Prefix][Unit][unit_type_id]']/option[3]
    # Step 20 Select Dropdown to select Manager
    wait until page contains element    xpath://div[@id='s2id_PrefixUnitUnitManagerManagerPersonId']
    click element  xpath://div[@id='s2id_PrefixUnitUnitManagerManagerPersonId']
    # Step 21 Select Robot tester 1 as Manager
    wait until page contains element    xpath://*[@id="select2-drop"]/ul/li[2]/div
    click element  xpath://*[@id="select2-drop"]/ul/li[2]/div
    # Step 22 Fill Each unit value
    FOR  ${value}    IN RANGE   3  ${UnitCount}+3
       #Click on Unit type
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][Unit][unit_type_id]']
       click element  xpath://select[@name='data[MultiUnit][${value}][Unit][unit_type_id]']
       #Select Barn as Unit type
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][Unit][unit_type_id]']//option[@value='17982']
       click element  xpath://select[@name='data[MultiUnit][${value}][Unit][unit_type_id]']//option[@value='17982']
       #Click on Unit Owner
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][Unit][owner_id]']
       click element  xpath://select[@name='data[MultiUnit][${value}][Unit][owner_id]']
       #Select Owner 1 - Sansiri as Unit Owner
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][Unit][owner_id]']//option[@value='107876']
       click element  xpath://select[@name='data[MultiUnit][${value}][Unit][owner_id]']//option[@value='107876']
       #Click on Property Manager
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][UnitManager][manager_person_id]']
       click element  xpath://select[@name='data[MultiUnit][${value}][UnitManager][manager_person_id]']
       #Select Robot Tester as Property Manager
       wait until page contains element    xpath://select[@name='data[MultiUnit][${value}][UnitManager][manager_person_id]']//option[@value='630435']
       click element  xpath://select[@name='data[MultiUnit][${value}][UnitManager][manager_person_id]']//option[@value='630435']
    END
    # Step 23 Confirm
    wait until page contains element    xpath://input[@type='submit' and @value='Add Property']
    click element  xpath://input[@type='submit' and @value='Add Property']
    # Step 23 Click to view property
    wait until page contains element    xpath://a[text()='View this Property']
    click element  xpath://a[text()='View this Property']
    return from keyword  ${ProfileAddressName}


Validate Created Property
    [Arguments]    ${_propertyName}
    set selenium speed  1
    ${count}=    get element count      //ul[@class='children' and contains(@style,'hidden')]//a[@href='/robottester/properties/index']
    Run Keyword If  "${count}" == "1"   Click DropDown and Submenu  //a[@title='Properties' and @href='/robottester/properties/index']  //ul[@class='children']//a[@href='/robottester/properties/index']//span[text()='Properties']
    Run Keyword If  "${count}" == "0"   Click SubMenu   //ul[@class='children']//a[@href='/robottester/properties/index']//span[text()='Properties']
    # Step 3 Search  Properties
    wait until page contains element    id:_q
    input text  id:_q   ${_propertyName}\n
    # Step 4 Get New Property Name that has been created
    wait until page contains element    xpath://div[4]/table/tbody/tr/td[2]/span/a
    ${actual} =   get text  xpath://div[4]/table/tbody/tr/td[2]/span/a
    # Step 5 Validate Task is created successful
    log to console  expected:${_propertyName}__actual:${actual}
    Should contain      ${_propertyName}      ${actual}

Check box If it is unchecked
    log to console  Check box is unchecked
    click element  xpath://input[@type='checkbox' and @name='data[Property][full_access]']






