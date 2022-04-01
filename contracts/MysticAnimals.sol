// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// References
// https://docs.openzeppelin.com/contracts/4.x/api/token/erc721#ERC721
// https://docs.openzeppelin.com/contracts/4.x/api/token/erc721#ERC721Enumerable
// https://docs.openzeppelin.com/contracts/4.x/api/utils#Counters
// https://docs.opensea.io/docs/metadata-standards

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// ERC721Enumerable Expland the posibilities of the 721
// We need It because It has a function that let us know which NFTs an address has
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// We need to ise these functions to handle counters
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract MysticAnimals is ERC721, ERC721Enumerable {
    // State variable
    using Counters for Counters.Counter;
    // The we set the counter variable as private
    Counters.Counter private _idCounter;
    using Strings for uint256;

    // We pass It as a parameter so we do not hardcode the value when It is first created
    uint256 public maxSupply;

    // Here we are going to map the token ID with the image
    mapping(uint256 => string) tokensImage;
    
    function fillTokensImages() private {
        tokensImage[1] = 'https://gateway.ipfs.io/ipfs/QmX1y5gbRACafd1tV9knibjG4nXMaxmKDnk6kQVgmiGrjV';
        tokensImage[2] = 'https://gateway.ipfs.io/ipfs/Qmb711ppmGxLJRf4p5QDqmcKSaJHE5V1L3uMEe8Fixs5LR';
        tokensImage[3] = 'https://gateway.ipfs.io/ipfs/QmaLsvCwhxrYz28tgJK6uw3bmxNH5TTvGpEQSyN1BwS7ii';
        tokensImage[4] = 'https://gateway.ipfs.io/ipfs/QmU9D1LirU1CexxPFHdx5kkz64ce5LqwDsDdDDY3xsC191';
        tokensImage[5] = 'https://gateway.ipfs.io/ipfs/QmVrDuPaexW2s4Nmen7nrXgEYudyXDCMJ8xX8keNYNq31u';
        tokensImage[6] = 'https://gateway.ipfs.io/ipfs/QmNWCHt6AqsQC31TREtRyfrGR7MhNc1f9X6X2p8cUCyFM2';
        tokensImage[7] = 'https://gateway.ipfs.io/ipfs/QmenELgPAr58N31Mdw984sPgJ1H6UFfEfvnnmQyCxCCeDb';
        tokensImage[8] = 'https://gateway.ipfs.io/ipfs/QmRRqPWza9WMYxrPYwdcfZsksXZC9cZnoR8ukdRJM1AXQJ';
        tokensImage[9] = 'https://gateway.ipfs.io/ipfs/QmbToFkKsrHgbHEDazVvtSfgktkpZj7MecjoMyk8bDJ8VX';
        tokensImage[10] = 'https://gateway.ipfs.io/ipfs/QmeFdVW22bB6Xz6X6XPP31VwVzRwcFbesrKTY7w8CW7VaR';
        tokensImage[11] = 'https://gateway.ipfs.io/ipfs/QmSrgVTrrt4LtzoBFQgouDYpMc2jrd2jQ4fJrGJSkzYZwu';
        tokensImage[12] = 'https://gateway.ipfs.io/ipfs/QmYjxBNPr5aUcNTF5Z2QGB17Hb9Qsmt7gexRDoHHQDuz49';
        tokensImage[13] = 'https://gateway.ipfs.io/ipfs/QmSCB9eXEJNNS3CyVravBbeWKMzAyZVcqn9pRgsvrRkTMj';
        tokensImage[14] = 'https://gateway.ipfs.io/ipfs/QmU91BxeTwQM5GwF684wjmwM4ucZq4KWMDsUkwX4pdhazu';
        tokensImage[15] = 'https://gateway.ipfs.io/ipfs/QmQKbv7cohA8D1cufZfH5ntgH4tX7MxGMoz3AFWVb9VwjY';
    }

    constructor(uint256 _maxSupply) ERC721("MysticAnimals", "MYSANI") {
        maxSupply = _maxSupply;
        fillTokensImages();
    }

    // _safeMint already comes with 721 BUT It is a private function, so we create this mint function as a security layer
    // The challange here!!! is to make this mint payable papiii 
    function mint() public {
        // .current() comes in Counter
        uint256 current = _idCounter.current();
        // Then validate the maxSupply so we no create more of what is expected
        require(current < maxSupply, "No Mystic Animals left :(");
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    // This allow us to fetch the metadata based in the tokenid
    // It returns the string, in memory because It is only read
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
      // We need to first double check If the token exists with the included function
      require(_exists(tokenId), "ERC721 Metadata: URI query for nonexisting token");

      string memory image = tokensImage[tokenId];

      // https://docs.opensea.io/docs/metadata-standards here we have the desired values for Open Sea
      string memory jsonURI = Base64.encode(
        abi.encodePacked(
          '{ "name": "Mystic Animals #',
          tokenId.toString(),
          '", "description": "Mystic Animals is a collection that is only owned by the most fearless investors", "image": "',
          image,
          '"}'
        )
      );

      // Here we concatenate with the internet standard
      // string(...) parse to string
      return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }


    // These are override functions that Enumerable needs
    function _beforeTokenTransfer(
      address from,
      address to,
      uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
      super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
      public
      view
      override(ERC721, ERC721Enumerable)
      returns (bool)
    {
      return super.supportsInterface(interfaceId);
    }
}
