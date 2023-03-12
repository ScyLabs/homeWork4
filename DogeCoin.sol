//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;



contract DogeCoin {

    address private deployer;
    address private owner;
    uint private totalSupply;

    struct Payment {
        address to;
        uint amount;
    }

    mapping(address => uint) public balances;
    mapping(address => Payment[]) public payments;
    
    event IncreaseTotalSupply(address indexed from,uint indexed newSupply);
    event Transfert(address indexed from,address indexed to,uint indexed amount);
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Caller is not the owner");
        _;
    }

    constructor(){
        deployer = msg.sender;
        owner = msg.sender;
        totalSupply = 2*(10**6);
        balances[msg.sender] = totalSupply;    
    }
    
    function getDeployer() external view returns (address) {
        if(deployer == msg.sender){
            return 0x000000000000000000000000000000000000dEaD;
        }
        return deployer;
    }
    
    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function increaseTotalSupply() external onlyOwner  {
        totalSupply += 1000;
        emit IncreaseTotalSupply(msg.sender,totalSupply);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function transfert(uint amount,address to) public {
        require(amount <= balances[msg.sender],"transfer amount exceeds balance");
        
        uint fromBalance = balances[msg.sender];
        
				unchecked{
					balances[msg.sender] = fromBalance - amount;
	        balances[to] += amount;
				}

        payments[to].push(Payment(to,amount));
    
        emit Transfert(msg.sender,to,amount);
        
    }

}
