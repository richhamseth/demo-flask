*** Settings ***
Library  OperatingSystem
Library  Collections
Library  RequestsLibrary

*** Variables ***
${url}  http://3.83.163.216:5004

*** Keywords ***
Session Creation
   ${headers}=  Create Dictionary  Content-Type=application/json
   Create Session  loginauth  ${url}  headers=${headers}

Api call to get users details  
    [Arguments]  ${object}
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
   ${result}  Api call to get users details    ${object}
   Checking response for users details   ${result}
