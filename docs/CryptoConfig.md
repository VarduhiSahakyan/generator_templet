**Warning: This is still a work in progress!**
# Cryptographical configuration for ACS3

## General information (Where to find keys and certificates)

All productive keys in [Prod key references](https://sp2013.myatos.net/communities/cm1/HSMA-FR-WL/Sauvegarde%20fichiers%20de%20cl/ACS%20V3%20PRD%20-%20TAG%20clefs%20Bull%20v1.xls)

All test key references are contained in [Test key References](https://sp2013.myatos.net/communities/cm1/HSMA-FR-WL/Sauvegarde%20fichiers%20de%20cl/ACS%20V3%20RCE%20-%20TAG%20clefs%20Bull%20v1.xlsx)

The certificates can normally be found in these network drives:

### 3DS1
`R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0 CAPS\7 - Dossier d'exploitation\KeysAndCertificates`

### 3DS2
`R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0 CAPS\7 - Dossier d'exploitation\KeysAndCertificates`

The values from the Key reference excel sheet are mapped to the values to the JSON configuration contained in the `CryptoConfig` database table by the following table. Mapping of values from the Excelsheets is as follows:

| Key in Excel sheet | field in JSON | Used for |
|--------------------|---------------|----------|
| KCAVV              | cardNetworkIdentifierMap| todo |
|KAAV (for HMAC CAVV calculations)| cardNetworkIdentifierMap | todo |
| KTOR               | cardNetworkIdentifierMap | todo |
| KTOK               | cipherKeyIdentifier |  todo |

 
For all key references from that excel sheet the according files have to be in crypto module.

The key tags in the database have to modified and set to the right key tags if you want to change a key. The right ksk, kdk and jks files have to be in the instance specific sub package, module, properties directory. To be used by the application, they must also be referenced in the cluster_ACS.xml file in the crypto-hsm delivery artifact.

## TLS Client config

In `dsKeyAlias` use the name of the certificte inside the p12 file. The p12 files can be found at `R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0\7 - Dossier d'exploitation\KeysAndCertificates\MUTU\PROD\PROTO 2.1\MC 2.1\TLS CLIENT`

The productive certificate aliases in the p12 files used for the mutual authentication should be: 
- `dsvisa_call_alias_cert_01` for Visa
- `dsmc_call_alias_cert_01` for MasterCard

## Productive Certificates 


## HSM change 
Changes on OPS for HSM change:

Brussels; 
IP_C2PBOX_1 10.82.199.93 -> 10.82.199.95
IP_C2PBOX_2: 10.82.199.94 -> 10.82.199.96

NAME_C2PBOX_1: HPACSC04B -> HPACSC06B
NAME_C2PBOX_2:HPACSC05B -> HPACSC07B

Vendome: 

IP_C2PBOX_1 10.72.184.26 -> 10.72.184.28
IP_C2PBOX_2: 10.72.184.27 -> 10.72.184.29

NAME_C2PBOX_1: HPACSC04V -> HPACSC06V
NAME_C2PBOX_2:HPACSC05V -> HPACSC07V

Truststore Password:
ba9270cc3a0c06ca29c3e2bb3a5d4913bbfeb68a087604348ac8fd8b2a84eb08 

