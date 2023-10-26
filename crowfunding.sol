// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4;

contract crowFunding{

    struct Proyect{
        uint Id;
        string name;
        uint targetAmount;
        uint collectedAmount;
    }
    uint proyectsCount = 0;
    mapping (string => Proyect) proyects;

    //Allows to create a new proyect
    function newProyect(string memory _name, uint _target) public{
        proyectsCount++;
        proyects[_name] = Proyect(proyectsCount,_name,_target, 0);
    }

    //Returns if target amount was reached
    function targetAmountReached(string memory _name, uint _amount) private view returns (bool) {
        Proyect memory proyect = proyects[_name];
        return proyect.targetAmount < proyect.collectedAmount + _amount;
    }

    //Returns amount left to reach target
    function amountToReachTarget(string memory _name) public view returns (uint) {
        Proyect memory proyect = proyects[_name];
        return proyect.targetAmount - proyect.collectedAmount;
    }

    //Allows to fund an existing proyect
    function fundProyect(string memory _name, uint _amount) public{
        require(!targetAmountReached(_name, _amount),"TARGET AMOUNT REACHED");
        proyects[_name].collectedAmount += _amount;
    }

    //Returns proyect name, target and collected
    function proyectInfo(string memory _name) public view returns(uint, uint, uint){
        Proyect memory proyect = proyects[_name];
        return (proyect.Id,proyect.targetAmount,proyect.collectedAmount); 
    }

     
}