// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19; 

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Contract is ERC20("First Contract ", "FC") {
    mapping(address => uint256) private _balances;
    mapping (address => mapping(address => uint256)) public _allowances;

    string private  _name;
    string private _symbol; 
    address private _ownerOfThisContract;

    uint256 public _totalSupply = 5000;
    
    constructor(string memory name_, string memory symbol_) { 
        _name = name_;
        _symbol = symbol_;
        _balances[msg.sender] = _totalSupply;
        _ownerOfThisContract = msg.sender;
    }

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be the zero address");
        emit OwnershipTransferred(_ownerOfThisContract, newOwner);
        _ownerOfThisContract = newOwner;
    }

    function mint(address account, uint256 amount) public onlyOwner  {
        require(account != address(0),"ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;

        unchecked {
            _balances[account] += amount;
        }

        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);

    }

    function burn(address account, uint256 amount) public onlyOwner virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked{
            _balances[account] -= amount;
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function transfer(address recepient, uint256 amount) public override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, recepient, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount)  override  internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");

        unchecked {
            _balances[from] = fromBalance - amount;
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);

    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) internal override {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    } 

    function allowance(address owner, address spender) public view override returns  (uint256) {
        return _allowances[owner][spender];
    }


    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 substractedValue) public returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= substractedValue, "ERC20: decreased allowance below zero");
        unchecked{
            _approve(owner, spender, currentAllowance - substractedValue);
        }

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public virtual override  returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true; 
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal  override  {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    function whoIsOwner() public view returns (address) {
        return _ownerOfThisContract;
    }

    function totalBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function thisAdress() public view returns (address) {
        return address(this);
    }

    function name () public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal   {}

    function _afterTokenTransfer(address from, address to, uint256 amount) internal  {}

    modifier onlyOwner {
        require(_ownerOfThisContract == msg.sender, "Not the contract owner");
        _;
    }

}

