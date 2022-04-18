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
        tokensImage[0] = 'https://gateway.ipfs.io/ipfs/QmUY4vH5EXPsp81PpTzSLyqRBSrEuFKDxy9qkcE6daWgaA';
        tokensImage[1] = 'https://gateway.ipfs.io/ipfs/QmTEanS95e3XsGpfrtD3ZYwZUZ2bVmZV8AaDMRsNH1hxZ9';
        tokensImage[2] = 'https://gateway.ipfs.io/ipfs/QmcnS6nD4XmZZzbw7osCrXBCsh3nkk9NenyrQAnxdUjczb';
        tokensImage[3] = 'https://gateway.ipfs.io/ipfs/QmSMhtkrXDwJunJ3voAPqSP8nbiCMJDwRkzwLBuFTPHhyb';
        tokensImage[4] = 'https://gateway.ipfs.io/ipfs/QmVgCmyVvNBT7464iHzoZGUi7QcLPWYCZ37w9UBfR1X9pU';
        tokensImage[5] = 'https://gateway.ipfs.io/ipfs/QmQBVoc3H8khRQ8wYkXXWf1EtPF92KJK2bHHFhtdNjgzCE';
        tokensImage[6] = 'https://gateway.ipfs.io/ipfs/QmeVmdasjCr7rTAyweTZvM2CNBwcgGtgyJKDhmpqWrAgb3';
        tokensImage[7] = 'https://gateway.ipfs.io/ipfs/QmRYN5CrCM4ER6h5BhrYtGY5VPgZ4DSbpJ4cm9mhMVum7h';
        tokensImage[8] = 'https://gateway.ipfs.io/ipfs/QmaN8c96RFkazjC7hqj7McJi21ENx56tbx3B419xtCqQLZ';
        tokensImage[9] = 'https://gateway.ipfs.io/ipfs/QmTWcjkzAXm6PiFFPV2U1M3iJn7FXZu4koYvWvCkK45mRN';
        tokensImage[10] = 'https://gateway.ipfs.io/ipfs/QmPJqTT1c6WzpYCn9wyEH9oRCEAFFDXQt6A1AuwdPgsxAv';
        tokensImage[11] = 'https://gateway.ipfs.io/ipfs/QmdWAmSBDqyTZkUE8PKEffQAEuw6QbCmHmv1aFt148jJpG';
        tokensImage[12] = 'https://gateway.ipfs.io/ipfs/QmPfwZZ9Mtp4wbraEDUFbQfktURpzGMecUmNZsRy6bBRF8';
        tokensImage[13] = 'https://gateway.ipfs.io/ipfs/QmYABNSvzKjFs7J8YyPs7WxjSMxjjiBagQ8u3m56y28P9u';
        tokensImage[14] = 'https://gateway.ipfs.io/ipfs/QmZNCoy2Se3wYEmPfaWg2oPYyNY4XFpa5MEfbRJAuk4hpg';
        tokensImage[15] = 'https://gateway.ipfs.io/ipfs/QmRcQg3XK958VEdff7jYTGXsg2eEaKz7J5GcaorMc1n3oK';
        tokensImage[16] = 'https://gateway.ipfs.io/ipfs/QmdVWZBVJzERm5A2tjVqKq8hfyxNLxp9sf9W7NuZoxSZiQ';
        tokensImage[17] = 'https://gateway.ipfs.io/ipfs/QmSCrKFBfMVWW9mte4UPedAJFUEHFpomd6jfaadvsAsLTY';
        tokensImage[18] = 'https://gateway.ipfs.io/ipfs/QmVKhLNGVprzDczYZtPc2piZuzWZm8NmiKJnxLtaRDtp4w';
        tokensImage[19] = 'https://gateway.ipfs.io/ipfs/QmUdSS7hyufX2FSvocN7b6vFXr94sZkX2uSRrtMBnA4VmV';
        tokensImage[20] = 'https://gateway.ipfs.io/ipfs/QmWu5MTLmxSCswxnPQj1umfbByDuMt3SwzThPDJ3X4snAh';
        tokensImage[21] = 'https://gateway.ipfs.io/ipfs/QmRhHzboSRQrqM9CQzZouyVAfoCXxAoKN5LaPrts53N5zi';
        tokensImage[22] = 'https://gateway.ipfs.io/ipfs/QmfT72MhV6sPfMw1x4xvgzmYuwiJgM9BNcZt1cTi3gnPz8';
        tokensImage[23] = 'https://gateway.ipfs.io/ipfs/QmeeogkNCiDCdWMorPBZrK9CXknZ8cJXPtw3kNGe2Uxi8G';
        tokensImage[24] = 'https://gateway.ipfs.io/ipfs/QmaYWvxxT3YtEPrXbxee3yrdP3xfdNFYApxKALN9xYNaM4';
        tokensImage[25] = 'https://gateway.ipfs.io/ipfs/QmUJU1hi6qoT5QH2rCAgsdetS7Ja2YSGXd2u4xyF6cKfXS';
        tokensImage[26] = 'https://gateway.ipfs.io/ipfs/QmRm6GjNhcxeF6Skm9nE1gp8PH7Wb6472yEVNRPwc6xWaT';
        tokensImage[27] = 'https://gateway.ipfs.io/ipfs/QmUfttVicnmGcJoH4smQPDofskMujuWPhozqHxoDP5tQwW';
        tokensImage[28] = 'https://gateway.ipfs.io/ipfs/Qmd46B2wow9qJhGSLJzHT6UtvMX3u94V7CMdwUEWCYyrtR';
        tokensImage[29] = 'https://gateway.ipfs.io/ipfs/QmPA2nWfAo3tBWSBPM4QZUXyogcsbutZmBPMnWWHZNQ16p';
    }

    constructor(uint256 _maxSupply) ERC721("Tribe Masks", "TEMSK") {
        maxSupply = _maxSupply;
        fillTokensImages();
    }

    // _safeMint already comes with 721 BUT It is a private function, so we create this mint function as a security layer
    // The challange here!!! is to make this mint payable papiii 
    function mint() public virtual payable {
        require(msg.value >= 1, "Not enough ETH sent; check price!");
        // .current() comes in Counter
        uint256 current = _idCounter.current();
        // Then validate the maxSupply so we no create more of what is expected
        require(current < maxSupply, "No Tribe Masks left :(");
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
          '{ "name": "Tribe Masks #',
          tokenId.toString(),
          '", "description": "Tribe Masks is a collection created by Diamond Studios", "image": "',
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
