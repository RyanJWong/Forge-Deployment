pragma solidity ^0.7.0;

// This contract includes functions for signaling, such as sending offers and answers,
// as well as functions for managing the state of the connection.

contract WebRTC {
    // The address of the client that initiated the connection
    address public initiator;

    // The address of the client that accepted the connection
    address public acceptor;

    // The state of the connection (disconnected, connecting, connected)
    enum State { Disconnected, Connecting, Connected }
    State public state;

    // The WebRTC offer message
    string public offer;

    // The WebRTC answer message
    string public answer;

    // Constructor function that sets the initiator as the contract owner
    constructor() public {
        initiator = msg.sender;
        state = State.Disconnected;
    }

    // Function that allows the initiator to send an offer message
    function sendOffer(string memory _offer) public {
        require(msg.sender == initiator, "Only the initiator can send an offer");
        require(state == State.Disconnected, "Cannot send offer in current state");
        offer = _offer;
        state = State.Connecting;
    }

    // Function that allows the acceptor to send an answer message and complete the connection
    function sendAnswer(string memory _answer) public {
        require(msg.sender != initiator, "Only the acceptor can send an answer");
        require(state == State.Connecting, "Cannot send answer in current state");
        acceptor = msg.sender;
        answer = _answer;
        state = State.Connected;
    }

    // Function that allows either client to disconnect the connection
    function disconnect() public {
        require(state == State.Connected, "Cannot disconnect in current state");
        require(msg.sender == initiator || msg.sender == acceptor, "Only the initiator or acceptor can disconnect the connection");
        state = State.Disconnected;
        offer = "";
        answer = "";
        acceptor = address(0);
    }
}
