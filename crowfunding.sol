// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract crowFunding{

    struct Proyect{
        bytes32 Id;
        string name;
        uint targetAmount;
        uint collectedAmount;
    }
    uint proyectsCount = 0;
    mapping (string => Proyect) proyects;

    function giveID() private view returns(bytes32){
        return keccak256(abi.encodePacked(block.timestamp,msg.sender,block.number));
    }

   //Allows to create a new proyect
    function newProyect(string memory _name, uint _target) external{
        require(proyects[_name].Id == 0, "Project with this name already exists");
        proyectsCount++;
        proyects[_name] = Proyect(giveID(),_name,_target, 0);
    }

    //Returns if target amount was reached
    function targetAmountReached(string memory _name, uint _amount) public view returns (bool) {
        Proyect memory proyect = proyects[_name];
        return proyect.targetAmount < proyect.collectedAmount + _amount;
    }

    //Returns amount left to reach target
    function amountToReachTarget(string memory _name) external view returns (uint) {
        require(proyects[_name].Id != 0, "Project doesn't exists");
        Proyect memory proyect = proyects[_name];
        return proyect.targetAmount - proyect.collectedAmount;
    }

    //Allows to fund an existing proyect
    function fundProyect(string memory _name, uint _amount) public{
        require(proyects[_name].Id != 0, "Project doesn't exists");
        require(!targetAmountReached(_name, _amount),"TARGET AMOUNT REACHED");
        proyects[_name].collectedAmount += _amount;
    }

    //Returns proyect name, target and collected
    function proyectInfo(string memory _name) external view returns(bytes32, uint, uint){
        require(proyects[_name].Id != 0, "Project doesn't exists");
        Proyect memory proyect = proyects[_name];
        return (proyect.Id,proyect.targetAmount,proyect.collectedAmount); 
    }

    //Returns proyects amount
    function getProyectsCount() external view returns(uint){
        return proyectsCount;
    }

     
}