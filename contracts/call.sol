pragma solidity ^0.8.9;

contract Create2Contract {
function requestData() public returns (bytes32 requestId)
{
   Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
   request.add("get", "https://api.github.com/fruitbox12");
   request.add("path", "status");    
   return sendChainlinkRequestTo(oracle, request, fee);
}
function fulfill(bytes32 _requestId, uint256 _response) public recordChainlinkFulfillment(_requestId)
{
   response = _response;
}
}
