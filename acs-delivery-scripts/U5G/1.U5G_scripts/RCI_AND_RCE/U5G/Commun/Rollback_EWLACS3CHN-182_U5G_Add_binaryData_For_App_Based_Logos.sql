USE `U5G_ACS_BO`;

SET @createdBy ='A758582';

SET @VisaS = 'VISA_small.png';
SET @VisaM = 'VISA_medium.png';
SET @VisaL = 'VISA_large.png';
SET @MCS = 'MC_small.png';
SET @MCM = 'MC_medium.png';
SET @MCL = 'MC_large.png';
SET @EWBS = 'ewb_small.jpg';
SET @EWBM = 'ewb_medium.jpg';
SET @EWBL = 'ewb_large.jpg';
SET @LBBWS = 'lbbw_small.png';
SET @LBBWM = 'lbbw_medium.png';
SET @LBBWL = 'lbbw_large.png';
SET @INGS = 'ing_small.png';
SET @INGM = 'ing_medium.png';
SET @INGL = 'ing_large.png';
SET @COZS = 'coz_small.png';
SET @COZM = 'coz_medium.png';
SET @COZL = 'coz_large.png';
SET @COMDIRECTS = 'comdirect_small.png';
SET @COMDIRECTM = 'comdirect_medium.png';
SET @COMDIRECTL = 'comdirect_large.png';
SET @COBS = 'cob_small.png';
SET @COBM = 'cob_medium.png';
SET @COBL = 'cob_large.png';
SET @CONSORSS = 'consors_small.png';
SET @CONSORSM = 'consors_medium.png';
SET @CONSORSL = 'consors_large.png';
SET @PAYBOXS = 'paybox_small.png';
SET @PAYBOXM = 'paybox_medium.png';
SET @PAYBOXL = 'paybox_large.png';
SET @OPS = 'op_small.png';
SET @OPM = 'op_medium.png';
SET @OPL = 'op_large.png';
SET @REISES = 'reise_small.png';
SET @REISEM = 'reise_medium.png';
SET @REISEL = 'reise_large.png';
SET @POSTBANKS = 'postbank_small.png';
SET @POSTBANKM = 'postbank_medium.png';
SET @POSTBANKL = 'postbank_large.png';
SET @BNPWMS = 'bnp_wm_small.png';
SET @BNPWMM = 'bnp_wm_medium.png';
SET @BNPWML = 'bnp_wm_large.png';
SET @SPARDAS = 'sparda_small.png';
SET @SPARDAM = 'sparda_medium.png';
SET @SPARDAL = 'sparda_large.png';
SET @CHINABANKS = 'chinabank_small.png';
SET @CHINABANKM = 'chinabank_medium.png';
SET @CHINABANKL = 'chinabank_large.png';
UPDATE `Image` SET `binaryData` = '' WHERE `name` IN (@VisaS, @VisaM, @VisaL, @MCS, @MCM, @MCL,
                                                    @EWBS, @EWBM, @EWBL, @LBBWS, @LBBWM, @LBBWL,
                                                    @INGS, @INGM, @INGL, @COZS, @COZM, @COZL,
                                                    @COMDIRECTS, @COMDIRECTM, @COMDIRECTL,
                                                    @COBS, @COBM, @COBL, @CONSORSS, @CONSORSM, @CONSORSL,
                                                    @PAYBOXS, @PAYBOXM, @PAYBOXL, @OPS, @OPM, @OPL,
                                                    @REISES, @REISEM, @REISEL, @POSTBANKS, @POSTBANKM, @POSTBANKL,
                                                    @BNPWMS, @BNPWMM, @BNPWML, @SPARDAS, @SPARDAM, @SPARDAL,
                                                    @CHINABANKS, @CHINABANKM, @CHINABANKL);