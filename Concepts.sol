// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*
Constructor function that is called when the smart contract is first deployed.



*/

/* 
(1) Function outputs
*/

contract FunctionOuts {
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    function assigned() public pure returns (uint x, bool b){
        x = 1;
        b = true;      //saves gas as we are directly assigning
    }

    function destructuringAssignments() public pure {
        (uint x, bool b) = returnMany();  // directly assign to x, b
        (, bool _b) = returnMany();      // if you only want 1 value
    }
}


/*
(2) Arrays
    dynamic or fixed size
    Initialization
    Insert (push), get, update, delete, pop, length
    Creating array in memory
    Returning array from function
 */

 contract Array {
    uint[] public nums = [1,2,3];
    uint[3] public numsFixed = [4,5,6];

    function examples() external {
        nums.push(4); // [1,2,3,4]
        uint x = nums[1];
        nums[2] = 777; // [1,2,777,4]
        delete nums[1]; // [1,0,777,4]
        nums.pop(); // [1,0,777]
        uint len = nums.length;

        //create array in memory
        uint[] memory a = new uint[][5];
        a[1] = 123;
    }

    function returnArray() external view returns (uint[] memory){
        return nums;
    }
 }

 /*
(3) Remove an element from Array by Shifting 
*/

contract ArrayShift {
    uint[] public arr;

    function example() public {
        arr = [1,2,3];
        delete arr[1]; // [1,0,3]

        // [1,2,3] -- remove(1) --> [1,3,3] --> [1,3]
    }
}


/*
(4) Mapping
*/

contract Mapping {
    mapping(address => uint) public balance;
    mapping(address => mapping(address => uint)) public isFriend;

    function examples() external {
        balance[msg.sender] = 123;
        uint bal = balance[msg.sender];
        uint bal2 = balance[address(1)];  //0

        balance[msg.sender] += 456; // 123+456

        delete balance[msg.sender]; //0

        isFriend[msg.sender][address(this)] = 12;

    }
}

/*
(5) Iterable Mapping

    --We use 2 mapping for this
        1st to store key-value
        2nd to check if key was earlier inserted and also push it to an array
*/

contract IterableMapping {
    mapping (address => uint) public balances;
    mapping (address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        balances[_key] = _val;

        if(!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function first() external view returns (uint) {
        return balances[keys[0]];
    }
}

/*
(6) Struct
*/

contract Struct {

    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;       // variable 'car' of type 'Car'
    Car[] public cars;   //array of Car

    function examples() external {
        Car memory toyota = Car("toyota", 1990, msg.sender)  // memory because 'Car' will only be stored in memory once function executes.

        //can also be declared as key-value pairs

        Car memory lambo = Car({model : "lamborghini", year : 1980, owner : msg.sender});

        //for key-value, order doesn't matter

        Car memory lambo = Car({year : 1980, owner : msg.sender, model : "lamborghini"});

        // if no value is assigned then it will be :

        Car memory tesla ; //model = "" , year = 0 , owner = address(0);
        tesla.model = "Tesla";
        tesla.year = 1990;
        tesla.owner = msg.sender;

        // push into array

        cars.push(lambo);
        cars.push(toyota);

        cars.push(Car("maruti", 1999, msg.sender));

        // now to grab values from array

        Car memory _car = cars[0];
        _car.model; // etc...

        //now to change some property of Car , we need to use 'storage' and not 'memory' as if we change in memory, after function execution
        //the data will be lost.. but storage helps to retain the value of changed state

        Car storage _car2 = cars[0];
        _car2.year = 2000; //value changed and will be saved

        delete _car2.owner // this will reset owner value to default (address(0));

        //similarly we can delete the Car struct in the array

        delete cars[1] // this will make struct of Car at index 1 to default values .. 
    }
}

/*
(7) Enum
*/

contract Enum {

    enum Status {
        Accepted, //0
        None, //1
        Rejected,  //2
        Canceled    //3
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    function get() view external returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;          //when we set , we give index of value we want to set .. example : 3 for Canceled
    }

    function reset() external {
        delete status;          //default item of enum is first item defined inside curly brace (i.e , Accepted)
    }
}


/*
(8) Event
*/

contract Event {
    event Log(string message, uint val);
    //upto 3 index, we can used indexed
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 789);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}


/*
(9) Inheritance

    -If there are 2 contracts A,B and B is inherited from A, meaning B can use/customize functions of A
     then every function in A that can be used by B should have 'virtual' in it.
     And whatever functions B uses and modifies it, it will user 'override'.
*/

contract A {
    function foo () public pure virtual returns (string memory){
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function baz() public pure returns (string memory) {
        return "A";
    }
}

contract B is A{    //will have access to foo = B, bar= B , baz = A
    function foo () public pure override returns (string memory){
        return "B";
    }

    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {  // will have access to foo = B, bar = C, baz = A
    function bar() public pure override returns (string memory) {
        return "C";
    }
}


/*
(10) Multiple Inheritances

    - We need to write order of inheritance - most base like to derived
*/


contract X {
    function foo () public pure virtual returns (string memory){
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X{    
    function foo () public pure override returns (string memory){
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X,Y {   //most base like to derived order  
    function bar() public pure override(X,Y) returns (string memory) { //order doesn't matter inside 'override'
        return "Z";
    }
}


/*
(11) Calling Parent Constructors
*/

contract S {

    string public name;
    constructor (string memory _name){
        name = _name;
    }
}

contract T {

    string public text;
    constructor (string memory _text){
        text = _text;
    }
}

contract U is S("s"), T("t") {    // initialising with static values in S, T
}

//order of execution --> S then T then V
contract V is S , T {    // initialising with dynamic values in S, T of what user uses in V
    constructor(string memory _name, string memory _text) S(_name) T(_text){}
}

contract W is S("s") , T {    // initialising with dynamic values in T, while S has static value of what user uses in W
    constructor(string memory _text)T(_text){}
}


/*
(12) Calling parent function
    - direct
    - super

    
*/

contract ee {

    function foo() public virtual {
        emit Log("ee.foo");
    }

    function bar() public virtual {
        emit Log("ee.bar");
    }
}

contract ff is ee {

    function foo() public virtual override {
        emit Log("ff.foo");
        ee.foo();   //  calling directly
    }

    function bar() public virtual override {
        emit Log("ff.bar");
        super.bar()    //using super
    }
}

contract hh is ee,ff {
    function foo() public virtual override {
        emit Log("hh.foo");
        ff.foo();   //  this calls foo from ff only 
    }

    function bar() public virtual override {
        emit Log("hh.bar");
        super.bar()    //this calls bar from both parents ee,ff
    }
}

/*
(13) Visibility

    - private    : only inside contract
    - internal   : only inside contract and child contracts
    - public     : inside and outside contract
    - external   : only from outside contract
*/

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() externall pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x+y+z; // can access x, y , z

        privateFunc();
        internalFunc();
        publicFunc();
        // but not externalFunc()
        //to call externalFunc(), we can use
        this.externalFunc(); // its like calling function of another contract
        //but it is gas inefficient , so not recommended

    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {

        //only accessbility of
        y+z;
        internalFunc();
        publicFunc();

        //externalFunc cannot be called as VisibilityChild is inherting from VisibilityBase
        //so it typically is not an external contract
    }
}


/*
(14) Immutable
*/

contract Immutable {

    address public immutable owner = msg.sender
    //immutable is like constant except the fact that it can be initalised only once and when the
    //contract is formed

    //more code
}


/*
(15) Payable
        - to send/receive ether
        - only payable function can do this.
*/

contract Payable {

    address public payable owner;

    constructor() {
        owner = payable(msg.sender);  //need to cast msg.sender as payable as owner is payable address
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}


/*
(16) Fallback / Receive function

    - when function that is called doesn't exist, fallback() is executed
    - directly send ETH
    - difference b/w fallback() and receive()
        - if msg.data ( or the ether that is sent to this contract) is not empty , fallback is executed
        - if msg.data is empty and receive() is present, then receive is executed , otherwise fallback will be executed
*/

contract Fallback {

    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
}


/*
(17) Send ETH
        - 3 ways
            - transfer : 2300 gas, reverts
            - send : 2300 gas , returns bool
            - call : all gas, returns bool and data
*/

contract SendETH { 

    constructor() payable {}          // 1 way to receive ether is to have payabale constructor when contract is deployed

        // fallback() external payable {     //another way is to have fallback payable function

        // }

        // instead we use receive payable function as that will tell that if a function doesnt exist
        // and it does not have fallback, that function call will fail
        
        receive() external payable {}     //another way is to have receiver payable function
    
        function sendViaTransfer(address payable _to) external payable {
            _to.transfer(123);
        }

        function sendViaSend(address payable _to) external payable {   //not usually used in mainnet
            bool sent = _to.send(123);
            require(sent, "send failed");
        }

        function sendViaCall(address payable _to) external payable {
            (bool success, ) = _to.call{value: 123}("");
            require(success, "call failed");
        }
    
}

contract ETHReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}


/*
(18) EtherWallet
        - Only owner can send ETH from the wallet
        - It can receive ETH
*/

contract EtherWallet {

    address payable public owner;

    constructor(){
        owner = msg.sender;
    }

    function withdraw(uint _amount) external{
        require(msg.sender == owner, "caller is not owner");    
        owner.transfer(_amount);           // for owner to use transfer() , we need to make it payable
        //to save gas, we can use
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint _amount) {
        return address(this).balance ;
    }
}


/*
(19) Call other Contracts

    - call functions of other contracts

    here we are setting values (eth in this case , x) by calling functions from another contract.
    CallTestContract is manipulating data (x) / sending eth to another contract TestContract.
*/

contract CallTestContract {

    function setX(address _test, uint _x) external {
        TestContract(_test).setX(_x);
    }

    //another way to write it
    /*
    function setX(TestContract _test, uint _x) external {
        _test.setX(_x);
    }
    */

    function getX(address _test) external view returns (uint x){
        x = TestContract(_test).getX();
    }

    function setXandSendEther(address _test, uint _x) external payable {
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _test) external view returns (uint x , uint value) {
        (x , value) = TestContract(_test).getXandValue();
    }
}

contract TestContract {

    uint x;
    uint public value = 123;

    function setX(uint _x) external {
        x= _x;
    }

    function getX() external view returns (uint){
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint , uint) {
        return (x , value);
    }
}


/*
(20) Interface 

        - it helps to call functions of another contract even if we don't have access to the code

*/

    // in this example, we already know that some contract 'Coounter' is already deployed
    // but we dont want to copy paste all the code here to call its functions.
    // hence , we declare interface
interface ICounter {
    function count() external view returns (uint);   // we use ';' to declare what functions we are going to use
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}


/*
(21) Call 
    -call is a low level function to interact with other contracts.
    -This is the recommended method to use when you're just sending Ether via calling the fallback function.
    -However it is not the recommend way to call existing functions.
*/
contract Receiver {
    event Received(address caller, uint256 amount, string message);

    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint256 _x)
        public
        payable
        returns (uint256)
    {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

contract Caller {
    event Response(bool success, bytes data);

    // Let's imagine that contract Caller does not have the source code for the
    // contract Receiver, but we do know the address of contract Receiver and the function to call.
    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) = _addr.call{
            value: msg.value,
            gas: 5000
        }(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123));   // 2 arguements

        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
}

/*
(22) New

    - if we want to deploy 1 contract from another contract
    - After deploying AccountFactory, select it in Remix.
        In the Value field (above the list of functions), enter the amount of wei you want to send to the new Account contract.
        Call the createAccount function with the required _owner address.
        Remix will send the specified amount of Ether with the transaction to the createAccount function.
        The createAccount function then passes this Ether to the Account contract using the value parameter in the contract creation expression:Account account = new Account{value: msg.value}(_owner);
        
        Account account = new Account{value: msg.value}(_owner);


*/

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;   //this will be the address of other contract (AccountFactory) that created this contract
        owner = _owner;
    }
}

contract AccountFactory {
    Account[] public accounts;

    // if i want to deploy 'Account' contract, I would need to also pass in arguements
    //that it requires for its constructor
    function createAccount(address _owner) external payable{
        Account account = new Account{value: 111}(_owner);           //incase we also want to send some ether to it when it gets deployed
        accounts.push(account);
    }
}


/*
(23) Self Destruct
        -deletes contract
        - force send Ether to any address even if it doesnt have any fallback function
*/

contract Kill {

    constructor() payable {}   //should be payable , so we can send ether to this contract when it is deployed
     
    function kill() external {
        selfdestruct(payable(msg.sender)); // we are sending remaining eth to msg.sender. It should be of payable
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}
// helper contract to check if kill sends ether to this as msg.sender will be this contract
contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    // function to call kill function of Kill contracts
    function kill (Kill _kill) external {
        _kill.kill();
    }
}


/*
(24) Piggy Bank
        - anyone can send eth to the contract
        - only owner can withdraw the balance
        - once withdrawn, piggy bank is destroyed
*/

contract PiggyBank {
    Event Withdraw(uint amount);
    Event Deposit(uint amount);
    address public owner = msg.sender;  // or you can initialize this in a constructor
    receive() external payable {
        emit Deposit(msg.value);   //log the event , amount deposited
    }   

    function withDraw() external {
        require(msg.sender == owner , "only owner can withdraw");
        emit Withdraw(address(this).balance);   //withdraw before it gets destructed
        selfdestruct(payable(msg.sender));  //sending eth back to owner
    }
}



/*
(25) Simple Storage
        to understand
            - calldata
            - memory
*/

contract SimpleStorage {
    string public text;

    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns (string memory) {
        return text;
    }
}


/*
(26) WETH
*/

contract WETH is ERC20{
    
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    constructor() ERC20("Wrapped Ether", "WETH", 18);

    fallback() external payable {
        deposit();
    }

    function deposit() external payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);

    }

    function withdraw(uint _amount) external {
        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }
}


/*
(27) Library
        - used to store all functions which will be used multiple times in contracts
        - contracts can call these functions easily and use them
        - libraries can be imported like normal contracts
        - libraries cannot store state variables . Only functions
*/

library functions {
    function add() public pure returns (uint) {
        return 5+6;
    }
}

contract main {
    function call() public pure returns (uint){
        return fun.add();
    }
}


/*
(28) Override
        - Inherited contracts can override functions which are 'virtual'
        - name of functions cannot be changed
        - if a contract is inherited from multiple contracts and all use same function, then use override (contract1, contract2)
*/

contract contract1 {
    function foo() virtual public returns (uint){
        return 1;
    }
}

contract contract2 {
    function foo() virtual public returns (uint){
        return 2;
    }
}

contract contract3 is contract1, contract2{
    function foo() override(contract1, contract2) public returns (uint){
        return 3;
    }
}



/*
(29) Abstract Contracts

        - Used to keep un-implemented functions (virtual) 
        - so, inherited contracts can use those.
*/

abstract contract base {

    function call() public pure virtual returns(uint);  //no body
}

contract main is base {

    function call() public pure override returns(uint){
        return 1;
    }
}