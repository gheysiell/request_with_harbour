#include <hmg.ch>
#include "fileio.ch"

function Main
    Load Window Main
    Main.Center
    Main.Activate
return

//---------------------------------------------------------------------------------------------------------------

function call_webservice()
    local url := "https://send-email-integration.herokuapp.com/15"
    local nHandle, nLenReadFile
    local cBuffer, cReadFile

    if file('C:\Sicaf\output.txt')
        fErase('C:\Sicaf\output.txt')
    endif

    run("curl -X POST "+url+" >> C:\Sicaf\output.txt")

    nHandle := fOpen("C:\Sicaf\output.txt")
    cReadFile := fReadStr(nHandle, nHandle)
    nLenReadFile := len(cReadFile) - 14
    cMessageBody := subStr(cReadFile, 13, nLenReadFile)

    if cMessageBody == "email successfully sent."
        msgInfo("E-mail sent with success.", "Hello")
    else
        msgStop("Error sending email.", "Error")
    endif

    fClose(nHandle)
return