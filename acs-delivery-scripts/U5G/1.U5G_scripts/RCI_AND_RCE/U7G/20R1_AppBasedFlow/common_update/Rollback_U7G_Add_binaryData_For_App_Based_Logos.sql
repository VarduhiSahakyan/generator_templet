USE `U7G_ACS_BO`;

SET @createdBy ='A758582';

SET @VisaS = 'VISA_small.png';
SET @VisaM = 'VISA_medium.png';
SET @VisaL = 'VISA_large.png';
SET @MCS = 'MC_small.png';
SET @MCM = 'MC_medium.png';
SET @MCL = 'MC_large.png';
SET @UBSS = 'ubs_small.png';
SET @UBSM = 'ubs_medium.png';
SET @UBSL = 'ubs_large.png';
SET @CSS = 'cs_small.png';
SET @CSM = 'cs_medium.png';
SET @CSL = 'cs_large.png';
SET @NABS = 'nab_small.png';
SET @NABM = 'nab_medium.png';
SET @NABL = 'nab_large.png';
SET @SGKBS = 'sgkb_small.png';
SET @SGKBM = 'sgkb_medium.png';
SET @SGKBL = 'sgkb_large.png';
SET @BALIS = 'bali_small.png';
SET @BALIM = 'bali_medium.png';
SET @BALIL = 'bali_large.png';
SET @BEKBS = 'bekb_small.png';
SET @BEKBM = 'bekb_medium.png';
SET @BEKBL = 'bekb_large.png';
SET @GRKBS = 'grkb_small.png';
SET @GRKBM = 'grkb_medium.png';
SET @GRKBL = 'grkb_large.png';
SET @LLBS = 'llb_small.png';
SET @LLBM = 'llb_medium.png';
SET @LLBL = 'llb_large.png';
SET @TGKBS = 'tgkb_small.png';
SET @TGKBM = 'tgkb_medium.png';
SET @TGKBL = 'tgkb_large.png';
SET @LUKBS = 'lukb_small.png';
SET @LUKBM = 'lukb_medium.png';
SET @LUKBL = 'lukb_large.png';
SET @SOBAS = 'soba_small.png';
SET @SOBAM = 'soba_medium.png';
SET @SOBAL = 'soba_large.png';
SET @ENTRISS = 'entris_small.png';
SET @ENTRISM = 'entris_medium.png';
SET @ENTRISL = 'entris_large.png';
SET @NIDWALDENS = 'nidwalden_small.png';
SET @NIDWALDENM = 'nidwalden_medium.png';
SET @NIDWALDENL = 'nidwalden_large.png';
SET @RCHS = 'rch_small.png';
SET @RCHM = 'rch_medium.png';
SET @RCHL = 'rch_large.png';
SET @SQNS = 'sqn_small.png';
SET @SQNM = 'sqn_medium.png';
SET @SQNL = 'sqn_large.png';

UPDATE `Image` SET `binaryData` = '' WHERE `name` IN (@VisaS, @VisaM, @VisaL, @MCS, @MCM, @MCL,
                                                    @UBSS, @UBSM, @UBSL, @CSS, @CSM, @CSL,
                                                    @NABS, @NABM, @NABL, @SGKBS, @SGKBM, @SGKBL,
                                                    @BALIS, @BALIM, @BALIL, @BEKBS, @BEKBM, @BEKBL,
                                                    @GRKBS, @GRKBM, @GRKBL, @LLBS, @LLBM, @LLBL,
                                                    @TGKBS, @TGKBM, @TGKBL, @LUKBS, @LUKBM, @LUKBL,
                                                    @SOBAS, @SOBAM, @SOBAL, @ENTRISS, @ENTRISM, @ENTRISL,
                                                    @NIDWALDENS, @NIDWALDENM, @NIDWALDENL, @RCHS, @RCHM, @RCHL,
                                                    @SQNS, @SQNM, @SQNL);
