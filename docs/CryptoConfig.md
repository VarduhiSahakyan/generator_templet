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

To configure the config configuration you can use the templates provided in the docs/templates directory, located in the delivery 
repository. 

Basically all you need to do is replace the placeholder variables with the values you get from the excel sheet for the key information and the 
certificates and addtional key information provided by the product or project managers. See the table for more information where you 
should get these informations.

One thing to watch out for: In the past we ran into some issues because of new line characters in the JSON files. so to be on the safe 
side, you should filter out all newline character from your finished json config, before you add them to sql setup scripts 
(A search and replace in a decent text editor should do the trick).

How the values from the Key reference excel sheet are mapped to the values to the JSON configuration contained in 
the `CryptoConfig` database table is described in the following section. 

## Crypto parameters 
 
This is a description of the  
These are the keys set up in the CryptoConfig JSON templates (The descriptions were shamelessy copied from the ACS3 
documentation pages for [protocol 1](https://acs-30.gitlab-pages.kazan.atosworldline.com/acs-30-documentation/cryptography/3DS1/crypto/)
and [protocol 2](https://acs-30.gitlab-pages.kazan.atosworldline.com/acs-30-documentation/cryptography/3DS2/crypto/) )

### Key references in the crypto config 

The follwing values can be taken from the Excelsheets provided by the HSM team.

| Keys in JSON templates | Key in Excel sheet| Description |
|--------------------|---------------|----------|
|  cardNetworkIdentifierMap | KCAVV  | reference for private key for generation of the CAVV |
|  cardNetworkIdentifierMap  | KAAV (for HMAC CAVV calculations)  | reference for private key for generation of the CAVV |
|  cardNetworkSignatureKeyMap  | KTOR  | reference for private key for signing the PARes |
|  cipherKeyIdentifier  | KTOK  |  reference for AES key for encryptimg messages to the hub|
|  desCipherKeyIdentifier | (see description)  |  Reference of the AES encryption key for messages to the VISA history server. Used to encrypt the PAN in the message. Only applicable for protocol 1. same key reference for all issuers  |

### Addtional crypto information 

The following information must be provided by the produt or project managers 

| Keys in JSON templates  | Description |
|-------------------------|-------------|
| cavvKeyIndicator        | (Visa only)  value used for the calculation of the AVV value      |
| secondFactorAuthentication |  Default is "NO_SECOND_FACTOR", see SecondFactorAuthentication enum for more info.            |
| acsIdForCrypto     |    (Mastercard only)  value used for the calculation of the AVV value      |
| desKeyId     |   Sent with the PaTransReq to the History server as numKeyDep. Used by the AHS to get the AES key to decipher the PAN (AES). Only applicable for protocol 1. same key reference for all issuers        |
| binKeyIdentifier     |  (Mastercard only) Used for the calculation of the AVV value         |
| hubAESKey     |  Identifier sent to the hub for `cipherKeyIdentifier`          |
| cardNetworkAlgorithmMap_MC     | (Mastercard only) Identifier for the algorithm used to calculate the AAV for Mastercard. Valid values can be taken from the `AVMethod` class |
| cardNetworkAlgorithmMap_VISA     |(Visa only) Identifier for the algorithm used to calculate the AAV for Visa. Valid values can be taken from the `AVMethod` class |
|  cardNetworkSignatureKeyMap_MC  |(Mastercard only) key for the private key used to calculate the message signature|
|  cardNetworkSignatureKeyMap_VISA  |(Visa only) key for the private key used to calculate the message signature (VISA)|

### Fields related to certificates  

These fields contain the certificates that are part of the response messages. These certificates must also be provided by the 
product or project managers  

| Keys in JSON templates  | Description |
|-------------------------|-------------|
| signingCertificate_MC  | (Mastercard only)  The public certificate issued by Mastercard |
| authorityCertificate_MC  | (Mastercard only)  The Mastercard CA certificate in the certificate chain |
| signingCertificate_MC  | (Mastercard only) The Mastercard root certificate in the certificate chain  |
| signingCertificateExpiryDate_MC  | (Mastercard only)  The expiry date of the Mastercard signing certificate. Can be extracted from the certificate file |
| authorityCertificateExpiryDate_MC  |  (Mastercard only)  The expiry date of the Mastercard CA certificate. Can be extracted from the certificate file |
| rootCertificateExpiryDate_MC  |  (Mastercard only)  The expiry date of the Mastercard root certificate. Can be extracted from the certificate file|
| signingCertificate_VISA  | (VISA only)  The public certificate issued by VISA |
| authorityCertificate_VISA  | (VISA only)  The VISA CA certificate in the certificate chain |
| signingCertificate_VISA  | (VISA only) The VISA root certificate in the certificate chain  |
| signingCertificateExpiryDate_VISA  | (VISA only)  The expiry date of the VISA signing certificate. Can be extracted from the certificate file |
| authorityCertificateExpiryDate_VISA  |  (VISA only)  The expiry date of the VISA CA certificate. Can be extracted from the certificate file |
| rootCertificateExpiryDate_VISA  |  (VISA only)  The expiry date of the VISA root certificate. Can be extracted from the certificate file|
 
### Protocol 2 specific fields

In the protocol 2 setup most fields are identical with the ones used in the protocol 1 setup. In addition, there are the following fields to add:

| Keys in JSON templates | Description |
|------------------------|-------------|
| acsSignedContentCertificateKeyMap_VISA | (Visa only) Reference for the private key used to sign the response message |
| acsSignedContentCertificateKeyMap_MC | (Mastercard only) Reference for the private key used to sign the response message |

## TLS Client config

In `dsKeyAlias` use the name of the certificate inside the p12 file. The p12 files can be found at (file://R:\BFI-BU\Pôle Issuing\Projets\ACS\2015.09.ZF.GBLS63.001.DV - ACS 3.0\7 - Dossier d'exploitation\KeysAndCertificates\MUTU\PROD\PROTO 2.1\MC 2.1\TLS CLIENT)

The productive certificate aliases in the p12 files used for the mutual authentication should be: 
- `dsvisa_call_alias_cert_01` for Visa
- `dsmc_call_alias_cert_01` for MasterCard

## Crypto HSM module  

The `acs-crypto-hsm` module contains the configuration for the HSMs. The main configuration can be found in the directory 
`acs-delivery-artifacts/acs-crypto-hsm/src/main/resources`. In this directory each combination of instance and environment
needs its own directory for the actual configuration (e.g `crypto-hsm-u5g-rct` for test enviroments of U5G and 
`crypto-hsm-u5g-prd` for the prod environment) Each of these directories contains several files with the suffixes .ksk, .kdk and .rsa.
These are configuration files that are provided by the HSM administrators. Additionally, there is a jks truststore and a jks keystore.
They are used for securing the connection to the HSM. 

### cluster_ACS.xml configuration file

The various *.kdk, *.ksk and *.rsa file must be configured in the file `cluster_ACS.xml`. The *.ksk and *.rsa are not 
instance specific, while the *.kdk have to be setup per per instance. If you have a look at the currenly checked in, you 
should get an good idea on how to update the configuration. Usually you will only be required to update existing entries 
or add new ones.    


### Prod HSMs
 
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

