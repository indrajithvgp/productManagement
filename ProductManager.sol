pragma solidity ^0.6.0;

import "./Product.sol";
import "./Owner.sol";


contract ProductManager is Owner{
	
	enum SupplyChainState {Created, Paid, Delivered}
	struct SupplyItem{
		Product product;
		string identifier;
		uint price;
		ProductManager.SupplyChainState state;
	}
	mapping(uint => SupplyItem) public product;
	uint index;
	event SupplyChainStep(uint _index, uint _state, address _productAddress);

	function createItem(string memory _identifier, uint _price) public onlyOwner{
		Product _product = new Product(this, index, _price);
		product[index].product = _product;
		product[index].identifier = _identifier; 
		product[index].price = _price;
		product[index].state = SupplyChainState.Created;
		emit SupplyChainStep(index, uint(product[index].state), address(_product));
		index++;
	}

	function triggerPayment(uint _index) public payable{
	    require(product[_index].state == SupplyChainState.Created, "Product is further in chain");
		require(product[_index].price == msg.value, "Only full payments accepted");
		product[_index].state = SupplyChainState.Paid;
		emit SupplyChainStep(_index, uint(product[_index].state), address(product[index].product));

	}

	function triggerDelivery(uint _index) public onlyOwner{
		require(product[_index].state== SupplyChainState.Paid, "Product is further in chain");
		product[_index].state = SupplyChainState.Delivered;
		emit SupplyChainStep(_index, uint(product[_index].state), address(product[_index].product));
	}
}