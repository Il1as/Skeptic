pragma solidity ^0.6.4;

contract SmartPayment {
  uint public delai ;
  uint public Montant;
  address fournisseur ;

  constructor(uint _Montant) public {
    delai = block.timestamp + 200;
    Montant = _Montant;
    fournisseur = msg.sender;
  }

  fallback () payable external {
    require(
      msg.value == Montant,
      'Le paiement doit correspondre au montant facturé.'
    );
  }

  function getContractBalance() public view returns(uint) {
    return address(this).balance;
  }

  function Retirer() public {
    require(
      msg.sender == fournisseur,
      'Seul le fournisseur peut retirer le paiement.'
    );
    require(
      block.timestamp > delai ,
      'La date limite n'a pas été atteinte.'
    );
    msg.sender.transfer(address(this).balance);
  }
}
