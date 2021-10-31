*** Settings ***
Documentation     A test suite containing tests related to invalid login.

Library           SeleniumLibrary
Library           OperatingSystem
Library           Collections

Suite Setup  Run Keywords   Open Browser To Login Page
Suite Teardown  Close All Browsers
Test Setup      Go To Login Page
Test Template   Login With Invalid Credentials Should Fail


*** Variables ***

${LOGIN URL}     https://portal.blip.ai
${BROWSER}       Chrome

${loginbutton}           xpath://button[@id='blip-login']
${Email}                 xpath://input[@id='email']
${Password}              xpath://input[@id='password']

${VALID USER}        email@test.com
${VALID PASSWORD}    S3nh4-ForT3

*** Test Cases ***               EMAIL            PASSWORD
Invalid Email                    invalid          ${VALID PASSWORD}
Invalid Password                 ${VALID USER}    invalid
Invalid Email And Password       invalid          whatever
Empty Email                      ${EMPTY}         ${VALID PASSWORD}
Empty Password                   ${VALID USER}    ${EMPTY}
Empty Email And Password         ${EMPTY}         ${EMPTY}

*** Keywords ***

Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
#    Click Button Accept Cookies    ${buttonAccept}

Go To Login Page
    Go To    ${LOGIN URL}

Input Email
    [Arguments]    ${email}
    Input Text     email    ${email}

Input Password
    [Arguments]    ${password}
    Input Text     password    ${password}

Submit Credentials
    Click Button    ${loginbutton}

Login With Invalid Credentials Should Fail
    [Arguments]    ${email}    ${password}
    Input Email    ${email}
    Input Password    ${password}
    Submit Credentials