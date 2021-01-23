pragma solidity ^0.6.0;

import "./ProductManager.sol";
	
contract Product{
	uint public index;
	uint public  price;
	uint public pricePaid;
	ProductManager productManager;

	constructor(ProductManager _productManager, uint _index, uint _price) public {
		productManager = _productManager;
		index = _index;
		price = _price;
	}

	receive()external payable{
		require(pricePaid == 0, "Product paid already");
		require(price == msg.value, "Only full payments accepted");
		pricePaid += msg.value;
		(bool success, ) = address(productManager). call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
		require(success, "The transaction was not successful");

	}
	fallback() external{

	}
}