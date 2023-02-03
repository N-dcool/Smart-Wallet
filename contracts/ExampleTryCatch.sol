// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract WillThrow {
    error NotAllowedError(string);
    function aFunction() public pure{
        //require(false, "Error Message.");     // => catch Error(){}
        //assert(false);                          // => catch Panic(){}
        /*
        if its not error or panic and it is custom Error // => catch(byte memory lowLevelData)
        */  
        revert NotAllowedError("You are not allowed");     
    }
}

contract ErrorHandling {
    event errorLogging(string reason);
    event errorLogCode(uint code);
    event errorLogBytes(bytes lowLevelData);

    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //add code here if it works
        } catch Error(string memory reason){
            emit errorLogging(reason);
        } catch Panic(uint errorCode){
            emit errorLogCode(errorCode);
        } catch(bytes memory lowLevelData){
            emit errorLogBytes(lowLevelData);
        }
    }
    
}