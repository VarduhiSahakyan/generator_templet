UPDATE BinRange SET BinRange.sharedBinRange = 1 WHERE BinRange.id IN
  (SELECT id_binRange FROM BinRange_SubIssuer WHERE id_subIssuer =
    (SELECT id FROM SubIssuer WHERE code = '99999'));

DELETE FROM BinRange_SubIssuer WHERE BinRange_SubIssuer.id_subIssuer =
  (SELECT id FROM SubIssuer WHERE code = '99999');

DELETE FROM SubIssuerCrypto WHERE SubIssuerCrypto.fk_id_subIssuer =
  (SELECT id FROM SubIssuer WHERE code = '99999');

DELETE FROM SubIssuer WHERE code = '99999';