*** Settings ***
Library  OperatingSystem
#Library  Collections
Library  RequestsLibrary

*** Variables ***
${url}  http://flaskapp:5000

*** Keywords ***
Session Creation
   ${headers}=  Create Dictionary  Content-Type=application/json
   Create Session  loginauth  ${url}  headers=${headers}

Api call to get users details  
    ${result}=  Get request  loginauth  /users
    [return]  ${result}

Checking response for users details  
    [Arguments]  ${result}
    Run Keyword If  "${result.json()["error"]}" == "${false}"  Should Be Equal  ${result.status_code}  ${400}
    Run Keyword If  "${result.json()["status"]}" == "${200}"  Should Be Equal  ${result.status_code}  ${200}

*** Test Cases ***
Get Users
   [Tags]  users
   Session Creation
   ${result}  Api call to get users details
   Checking response for users details   ${result}
