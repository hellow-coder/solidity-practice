// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {

    uint256 public myNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    event NumberStored(uint256 indexed newNumber);

    function store(uint256 _myNumber) public {
        myNumber = _myNumber;
        emit NumberStored(_myNumber);
    }

    function retrieve() public view returns(uint256) {
        return myNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
       listOfPeople.push(Person({
    favoriteNumber: _favoriteNumber,
    name: _name
}));

        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}