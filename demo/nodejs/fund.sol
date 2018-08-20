pragma solidity ^0.4.11;

contract Fund {

    // Contract to keep track of unit dealing on a Fund, storing the units owned by a buyer
    
	address buyer;
	
    enum State { Open, Traded, Settle }; 
    
    event FundTran(uint32 price, uint32 quantity, uint256 transDate, string isin);
    event SellUnits(address seller, address newOwner, uint32 units, string isin);

    struct fundTran{
        uint32 price;
        uint32 quantity;
        uint256 transDate;
        string isin;
        State tranState;
    }

    mapping (address => fundTran[]) buyerTrans;

    function Unit(uint32 _price, uint32 _quantity, uint256 _transDate, string _isin) public payable {
        buyer = msg.sender;
        fundTran currentBuyerTran = buyerTrans[buyer]
        State tranState = buyerTrans[buyer].tranState; 
        require(tranState != 0);
        buyerTrans[buyer].price = _price;
        buyerTrans[buyer].quantity = _quantity;
        buyerTrans[buyer].transDate = _transDate;
        buyerTrans[buyer].isin = _isin;
        buyerTrans[buyer].tranState = State.Open;
        FundTran( _price,  _quantity,  _transDate,  _isin);
    }

    function trade(uint32 _price){
        buyer = msg.sender;
        State tranState = buyerTrans[buyer].tranState;
        require(tranState != 0 && tranState==State.Open);
        buyerTrans[buyer].price = _price;
        buyerTrans[buyer].tranState = State.Traded;
    }
    
    function settle(uint32 _price){
        buyer = msg.sender;
        State tranState = buyerTrans[buyer].tranState;
        require(tranState != 0 && tranState==State.Trade);
        buyerTrans[buyer].price = _price;
        buyerTrans[buyer].tranState = State.Settle;
    }
    
    function fundValue() public returns uint{
    	uint transLength = buyerTrans.length;
    	uint totalUnits = 0;
    	for(uint i =0; i<length,i++){
    		if(buyerTrans[i].tranState == StateSettle){
    			totalUnits += buyerTrans[i].quantity;
    		}
    	}
    	return totalUnits;
    }
    
    function sellUnits(address newBuyer){
    	require(newBuyer != address(0));
    	seller = msg.sender;
        fundTran currentUnits = buyerTrans[seller];
        require(currentUnits != 0 && currentUnits.tranState==State.Settle);
        fundTran newBuyerCurUnits = buyerTrans[newBuyer];
		newBuyerCurUnits.quantity += currentUnits.quantity;        
		buyerTrans[newBuyer] = newBuyerCurUnits;
		delete(buyerTrans[seller]);
		SellUnits(seller, newBuyer, newBuyerCurUnits.quantity, newBuyerCurUnits.isin);
    }
}