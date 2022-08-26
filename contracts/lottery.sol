// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.9;

// A simple lottery contract that allows anybody to participate and stake ETH
// and once any random person wins the round, it immediately starts a new pool
contract Lottery {
    address public LotteryManager;
    uint public LotteryEndTime;
    address[] public LotteryParticipants;

    event JoinLottery(address Sender, uint amount);
    event LotteryPayout(address Receiver, uint amount);

    // Set the lotteryManager to be the contract deployer. The lottery manager
    // can determine WHEN the lottery ends, but can't influence who wins the round

    constructor(uint _lotteryEndTime) {
        LotteryManager = msg.sender;
        LotteryEndTime = block.timestamp + _lotteryEndTime;
    }
    // To join the lottery you must send the required amount

    function enterLottery(uint256 _amountToEnter) public payable {
        uint256 amountToEnter = _amountToEnter;
        require( msg.value = amountToEnter, "Amount too low, Not Up to the Required");
        LotteryParticipants.push[msg.sender];

        emit JoinLottery(msg.sender, amountToEnter);      
    }

    function SelectWinnerRandomly() private view {
        keccak256(abi.encodePacked(LotteryEndTime, LotteryParticipants));
    }

    // Get the random winner from the function above, and automatically do payouts,
    // then start a new array of addresses to kickstart lottery

    function PickWinnerAndPayout() public {
               require(msg.sender = LotteryManager, "Not Authorised to call this Function");
               uint ID = SelectWinnerRandomly() % LotteryParticipants.length;
               payable(LotteryParticipants[ID]).transfer(address(this).balance);
               LotteryParticipants = new address[](0);

               emit LotteryPayout(LotteryParticipants[ID], address(this).balance);
    }
}