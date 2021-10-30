#https://portal.blip.ai

*** Settings ***
Documentation     A test suite containing tests related to invalid accounts create.

Library           SeleniumLibrary
Library           OperatingSystem
Library  		  Collections


Suite Setup  Run Keywords   Open Browser To Login Page
#Suite Teardown  Close All Browsers
Test Setup      Go To Login Page
Test Template   Accounts Create With Invalid Fields Should Fail


*** Variables ***

${LOGIN URL}     https://portal.blip.ai
${BROWSER}       Chrome
${linkNewAccount}        xpath://a[@id='blip-register']
${FullName}              xpath://input[@id='FullName']
${Email}                 xpath://input[@id='Email']
${Password}              xpath://input[@id='Password']
${PhoneNumber}           xpath://input[@id='PhoneNumber']
${CompanySite}           xpath://input[@id='CompanySite']
${placeholder}           xpath://input[@placeholder='Select...']
${checkbox__icon}        id[@class='checkbox__icon']
${recaptcha-checkbox}    id[@class='recaptcha-checkbox-border']
${submitButton}           xpath://button[@id='submitButton']


${VALID PASSWORD}    S3nh4-F0rte
${VALID USER}        email@teste.com

*** Test Cases ***               EMAIL            PASSWORD              NAME         LASTNAME      COMPANYSITE
Invalid Email                    invalid          ${VALID PASSWORD}     +5538999     whatever      www.whatever.com
Invalid Password                 ${VALID USER}    invalid               whatever     whatever      www.whatever.com
Invalid Email And Password       invalid          whatever              whatever     whatever      www.whatever.com
Empty Email                      ${EMPTY}         ${VALID PASSWORD}     whatever     whatever      www.whatever.com
Empty Password                   ${VALID USER}    ${EMPTY}              whatever     whatever      www.whatever.com
Empty Email And Password         ${EMPTY}         ${EMPTY}              whatever     whatever      www.whatever.com
Empty Firstname                  ${VALID USER}    ${VALID PASSWORD}     ${EMPTY}     whatever      www.whatever.com
Empty Lastname                   ${VALID USER}    ${VALID PASSWORD}     whatever     ${EMPTY}      www.whatever.com

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
#    Click Button Accept Cookies    ${buttonAccept}

Go To Login Page
    Go To    ${LOGIN URL}

Click Forgot Password
	Click Element    ${linkForgotPassword}

Input Full Name 
    [Arguments]    ${username}
    Input Text     ${FullName}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text     ${Password}    ${password}

Input Email
    [Arguments]    ${email}
    Input Text     ${Email}    ${email}

Input Phone Number
	[Arguments]    ${phonenumber}
	Input Text     ${PhoneNumber}    ${phonenumber}

Input Company Site
	[Arguments]    ${companysite}
	Input Text     ${CompanySite}    ${companysite}

Select Size Company
	[Arguments]    ${value}
    Select By Value    ${placeholder}    ${value}

Submit Credentials
    Click Button    ${buttonLogin}

Submit Register
    Click Button    ${buttonCreateAccount}

Send Recovery Link
    Click Button    ${buttonSendRecoveryLink}

Accounts Create With Invalid Fields Should Fail
    [Arguments]                    ${full name}    ${email}    ${password}    ${phonenumber}   ${companysite}
    Click Link                     ${linkNewAccount}
    Wait Until Element Is Visible      ${FullName}
    Input Full Name                ${full name}
    Input Email                    ${email}
    Input Password                 ${password}
    Input Phone Number             ${phonenumber}
    Input Company Site             ${companysite}
    Click Button  ${checkbox}
#    Submit Register
#    Page Should Contain Element    ${error message}