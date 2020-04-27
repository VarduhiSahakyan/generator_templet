**Warning: This is still a work in progress!**
# Cryptographical configuration for ACS3

## General information (Where to find keys and certificates)

### Keys
All productive keys in [Prod key references](https://sp2013.myatos.net/communities/cm1/HSMA-FR-WL/Sauvegarde%20fichiers%20de%20cl/ACS%20V3%20PRD%20-%20TAG%20clefs%20Bull%20v1.xls)

All test key references are contained in [Test key References](https://sp2013.myatos.net/communities/cm1/HSMA-FR-WL/Sauvegarde%20fichiers%20de%20cl/ACS%20V3%20RCE%20-%20TAG%20clefs%20Bull%20v1.xlsx)

### Certificates
The certificates can normally be found in these network drives:

#### 3DS1
(file://R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0 CAPS\7 - Dossier d'exploitation\KeysAndCertificates)

#### 3DS2
(file://R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0 CAPS\7 - Dossier d'exploitation\KeysAndCertificates)

## Configuration of CryptoConfig json 
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

In `dsKeyAlias` use the name of the certificate inside the p12 file. The p12 files can be found at (file://R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0\7 - Dossier d'exploitation\KeysAndCertificates\MUTU\PROD\PROTO 2.1\MC 2.1\TLS CLIENT)

The productive certificate aliases in the p12 files used for the mutual authentication should be: 
- `dsvisa_call_alias_cert_01` for Visa
- `dsmc_call_alias_cert_01` for MasterCard

## Prod HSMs
 
Brussels

| Device Name | IP Address |
|-------------|------------|
| HPACSC06B | 10.82.199.95 |
| HPACSC07B | 10.82.199.96 |

Vendome 

| Device Name | IP Address |
|-------------|------------|
| HPACSC06V | 10.72.184.28 |
| HPACSC07V | 10.72.184.29 |

