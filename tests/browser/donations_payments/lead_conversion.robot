*** Settings ***

Resource        tests/NPSP.robot
Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Convert Lead To Account
    ${first_name} =           Generate Random String
    ${last_name} =            Generate Random String
    ${company} =              Generate Random String  
    Go To Object Home         Lead
    Click Object Button       New
    Populate Form
    ...                       First Name=${first_name}
    ...                       Last Name=${last_name}
    ...                       Company=${company}
    Populate Address          Street            50 Fremont Street  
    Populate Address          City              San Francisco
    Populate Address          Zip/Postal Code   95320
    Populate Address          State/Province    CA
    Populate Address          Country           USA 
    Click Dropdown            Lead Status
    Click Link                link=Working - Contacted
    Click Modal Button        Save    
    Wait Until Modal Is Closed
    Go To Object Home         Lead
    Click Link                link=${first_name} ${last_name}
    Click Link                link=Convert
    #Sleep    2
    Select Frame with ID      vfFrameId
    Click Element             //input[@value="Convert"]
    #Sleep    2
    Go To Object Home         Contact
    Reload Page
    Page Should Contain Link    ${first_name} ${last_name}
    Go To Object Home         Account
    Reload Page
    Page Should Contain Link    ${last_name} Household
    Page Should Contain Link    ${company}