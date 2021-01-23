pragma solidity ^0.6.0;


contract Owner{

    address payable authorizer;
    constructor()public{
        authorizer = msg.sender;
    }
    modifier onlyOwner(){
        require(isOwner(), "You are not the Authorizer");
        _;
    }
    function isOwner()public view returns(bool){
        return (msg.sender == authorizer);
    }

}