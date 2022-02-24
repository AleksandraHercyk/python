*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         saucedemo.com
${BROWSER}        Google Chrome
${DELAY}          0
${VALID USER}     standard_user
${VALID PASSWORD}    secret_sauce
${LOGIN URL}      http://${SERVER}
${WELCOME URL}    http://${SERVER}/secure
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Login Page
    Create Webdriver    Chrome    executable_path=C:/usr/local/bin/chromedriver.exe
#   Open Browser    ${LOGIN URL}    ${BROWSER}
    Go To   ${LOGIN URL}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open


Login Page Should Be Open
    Title Should Be    Swag Labs

#Go To Login Page
#    Go To    ${LOGIN URL}
#    Login Page Should Be Open

Open My Page
    [Arguments]     ${page_url}
    Go To           ${page_url}

Input Username
    [Arguments]    ${username}
    Input Text    name=user-name    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    name=password     ${password}

Input First Name
    [Arguments]    ${first_name}
    Input Text    name=firstName     ${first_name}

Input Last Name
    [Arguments]    ${last_name}
    Input Text    name=lastName     ${last_name}

Input Zip Code
    [Arguments]    ${postal_code}
    Input Text    name=postalCode     ${postal_code}

Submit Credentials
    Click Button    //button[@type='submit']

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Swag Labs
