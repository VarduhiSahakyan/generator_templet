**Warning: This is still a work in progress!**
# Cryptographical configuration for ACS3

## Overview 

This section should give you an overview where in ACS 3 cryptographic algorithms are used. 

### TLS connections to other services 

Most HTTP connections to other services are using TLS with client certificate authentication. Other services used by ACS3 are:

- Authentication hub 
- Flash 
- HSM Cryptobox 

### Field encryption

PCI relevant data like PANs are usually encrypted even if they are transmitted via a TLS secured connection

### Protocol-specific cryptographic signatures, authentication codes and certificates  

The 3DS2 protocols require the calculation of authentication codes, message signatures and certificates to be included in the messages send by the ACS system 
 
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

For more information on how to use the certificate files, please the section about setting up the cryptoConfig database table below.

## Configuration of CryptoConfig json

TODO: Write a step-by-step description on how to set up the crypto config for the different protocols

TODO: Create a template for the json config (CyptoConfig, protocol 1 and 2)
 
The values from the Key reference excel sheet are mapped to the values to the JSON configuration contained in the `CryptoConfig` database table by the following table. Mapping of values from the Excelsheets is as follows:

### Key references in the crypto config 

These are the keys set up in the CryptoConfig JSON templates (The descriptions were shamelessy copied from the ACS3 
documentation pages for [protocol 1](https://acs-30.gitlab-pages.kazan.atosworldline.com/acs-30-documentation/cryptography/3DS1/crypto/)
and [protocol 2](https://acs-30.gitlab-pages.kazan.atosworldline.com/acs-30-documentation/cryptography/3DS2/crypto/) )

| Keys in JSON templates | Key in Excel sheet| Description |
|--------------------|---------------|----------|
|  cardNetworkIdentifierMap | KCAVV  | todo |
|  cardNetworkIdentifierMap  | KAAV (for HMAC CAVV calculations)  | todo |
|  cardNetworkSignatureKeyMap  | KTOR  | todo |
|  cipherKeyIdentifier  | KTOK  |  todo |
|  desCipherKeyIdentifier | (see description)  |  Identifier of the AES encryption key in the HSM. Used to cipher the PAN before sending it to the AHS (ACS History Server, a service by the card schemes, that archives some information in regards to the transactions). For now it's always the same, can be found in CAPS or NPS configurations. |

### Addtional crypto information 

| Keys in JSON templates  | Where to find them | Description |
|-------------------------|--------------------|-------------|
| cavvKeyIndicator        |                    | Value for the AV generation ("serviceCode").            |
| secondFactorAuthentication |                 |  Default is "NO_SECOND_FACTOR", see SecondFactorAuthentication enum for more info.            |
| acsIdForCrypto     |               |           |
| desKeyId     |               |   Sent with the PaTransReq as numKeyDep. Used by the AHS to get the AES key to decipher the PAN (AES). For now it's always the same, can be found in CAPS or NPS configurations.        |
| binKeyIdentifier     |               |           |
| hubAESKey     |               |           |
| cardNetworkAlgorithmMap_MC     |               |  Key : Network code / Value : Identifier of the private key in the HSM used for the PARes XML signature. In test environments we use the default keys (MUTU). For production, please refer to the 'HSM Key Tag' doc (link available on the Home page).         |
| cardNetworkAlgorithmMap_VISA     |               |   Key : Network code / Value : Identifier of the private key in the HSM used for the PARes XML signature. In test environments we use the default keys (MUTU). For production, please refer to the 'HSM Key Tag' doc (link available on the Home page).        |
|  cardNetworkSignatureKeyMap_MC  |               |Key : Network code / Value : Place the XML Namespace of the signature algorithm used. Default if not filled is RSA_SHA1. |
|  cardNetworkSignatureKeyMap_VISA  |               |Key : Network code / Value : Place the XML Namespace of the signature algorithm used. Default if not filled is RSA_SHA1. |

### Fields related to certificates  
| Keys in JSON templates  | Where to find them | Description |
|-------------------------|--------------------|-------------|
| cavvKeyIndicator        |                    |             |
 

 
For all key references from that excel sheet the according files have to be in crypto module.

The key tags in the database have to modified and set to the right key tags if you want to change a key. The right ksk, kdk and jks files have to be in the instance specific sub package, module, properties directory. To be used by the application, they must also be referenced in the cluster_ACS.xml file in the crypto-hsm delivery artifact.

## TLS Client config

In `dsKeyAlias` use the name of the certificate inside the p12 file. The p12 files can be found at (file://R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0\7 - Dossier d'exploitation\KeysAndCertificates\MUTU\PROD\PROTO 2.1\MC 2.1\TLS CLIENT)

The productive certificate aliases in the p12 files used for the mutual authentication should be: 
- `dsvisa_call_alias_cert_01` for Visa
- `dsmc_call_alias_cert_01` for MasterCard

## TODO: Document the setup of the crypto hsm module 

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

