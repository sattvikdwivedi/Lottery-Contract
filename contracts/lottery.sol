// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Lottery{
   address manager;
   address payable[] public player;
   constructor(){
    manager=msg.sender;
   }
     receive() external payable{
       require(msg.value==1 ether);
       player.push(payable(msg.sender));
   }
   function getBalance() public view returns(uint){
      require(msg.sender==manager);
      return address(this).balance;
   }
   function Random() public view returns(uint){
      return uint(keccak256 (abi.encodePacked(block.prevrandao, block.timestamp, player.length)));
   }
   function selectWinner() public{
       require(msg.sender==manager);
       require(player.length>=3);
       uint r=Random();
       address  payable winner;
       uint index=r%player.length;
       winner = player[index];
       winner.transfer(getBalance());
       player=new address payable[](0);
   }
}