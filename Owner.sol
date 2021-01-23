pragma solidity ^0.6.0;


contract Owner{

    address payable owner;
    constructor()public{
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(isOwner(), "You are not the Owner");
        _;
    }
    function isOwner()public view returns(bool){
        return (msg.sender == owner);
    }

}