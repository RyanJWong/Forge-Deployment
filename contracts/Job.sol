pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Address.sol";

// This contract extends the ERC1155 contract from OpenZeppelin to add a namespace and fractionalization
// functionality.
contract WebRTC is ERC1155 {
  using SafeMath for uint256;
  using Address for address;
  address private _owner;

  // The namespace for this token.
  string private _namespace;

  // Mapping from token ID to the fractionalization factor for that token.
  mapping(uint256 => uint256) private _fractionalizationFactors;

  // Mapping from token ID to the balance of the ERC20 token for that token.
  mapping(uint256 => uint256) private _erc20Balances;

  // The constructor sets the namespace and owner of the contract.
  constructor(string memory namespace) public {
    _namespace = namespace + ".zap";
    _owner = msg.sender;
  }

  // Returns the namespace for this token.
  function getNamespace() public view returns (string memory) {
    return _namespace;
  }

  // Sets the fractionalization factor for a given token ID. Only the contract owner can do this.
  function setFractionalizationFactor(uint256 tokenId, uint256 factor) public {
    require(_owner == msg.sender, "Only the contract owner can set the fractionalization factor.");
    require(factor > 0, "The fractionalization factor must be greater than zero.");
    _fractionalizationFactors[tokenId] = factor;
  }

  // Mints a new ERC1155 token and assigns it the specified namespace.
  function mint(address[] memory to, uint256[] memory tokenIds, uint256[] memory amounts) public {
    require(_owner == msg.sender, "Only the contract owner can mint new tokens.");
    super.mint(to, tokenIds, amounts);
  }

  // Allows a user to exchange a fraction of an ERC1155 token for an equivalent amount of the corresponding
  // ERC20 token.
  function exchange(uint256 tokenId, uint256 amount) public {
    // Ensure that the fractionalization factor has been set for this token.
    require(_fractionalizationFactors[tokenId] > 0, "The fractionalization factor has not been set for this token.");

    // Calculate the equivalent amount of the ERC20 token.
    uint256 equivalentAmount = amount.mul(_fractionalizationFactors[tokenId]);

    // Transfer the equivalent amount of the ERC20 token to the caller.
    _erc20Balances[tokenId] = _erc20Balances[tokenId].sub(equivalentAmount);
    msg.sender.transfer(equivalentAmount);

    // Burn the corresponding amount of the ERC1155 token.
    _burn(msg.sender, tokenId, amount);
  }


}
