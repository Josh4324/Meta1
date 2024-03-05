//SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/*
 * @author Joshua Adesanya
 * @title Savings contract
 * @notice This contract allows users to save and withdraw eth. 
 */
contract SAVINGS {
    // Errors
    error NoZeroAmount();
    error AmountGreaterThanBalance();
    // Interfaces, Libraries, Contracts
    // State variables

    mapping(address => uint256) public addressToBalance;
    // Events

    event Deposited(uint256 indexed amount, address indexed addr);
    event Withdrawed(uint256 indexed amount, address indexed addr);
    // Modifiers
    // Functions

    // External Functions

    function deposit() external payable {
        require(msg.value > 0, "You cannot deposit zero amount");

        addressToBalance[msg.sender] = addressToBalance[msg.sender] + msg.value;
        emit Deposited(msg.value, msg.sender);
    }

    function withdraw(uint256 amount) external {
        if (amount > addressToBalance[msg.sender]) {
            revert AmountGreaterThanBalance();
        }

        addressToBalance[msg.sender] = addressToBalance[msg.sender] - amount;
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");

        emit Withdrawed(amount, msg.sender);
    }

    function withdrawToAnotherAddress(uint256 amount, address addr) external {
        assert(amount <= addressToBalance[msg.sender]);

        addressToBalance[msg.sender] = addressToBalance[msg.sender] - amount;
        (bool success,) = addr.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Public

    function getUserBalance() public view returns (uint256) {
        return addressToBalance[msg.sender];
    }
}
