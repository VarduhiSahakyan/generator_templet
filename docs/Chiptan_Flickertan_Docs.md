# Flicker-TAN Component 

## Technical background 

Flicker TAN or officially "HHD-Erweiterung für unidirektionale Kopplung" (no idea how to translate that properly)
is a method of transmitting authentication parameters to a handheld device that creates a TAN using the EMV chip 
on the card. After transmission to the device the EMV chip calculates a tan based on the parameters, which is send back to the issuer 
and validated. Basically Flicker TAN is a variant of the QRCode or PhotoTAN authentication method. 

TODO: insert images of the device

### Flicker TAN 
The basic idea is that the issuer send us a string with the authentication parameters, then these parameters 
are converted to a specfic format (outlined below) which then is displayed as an animated pattern on the screen.
This animated pattern consist of five blinking white/black squares that are read by the handheld device with five LEDs on 
the device: 

### Fallback: Manual mode 
If for some reason it is not possible to show the animated pattern, a fallback is provided by the manual mode.
This fallback consists of a single init value, that the customer must enter manually on the device as a seed value for 
the TAN generator. 

## The payload send by the issuer 

An example of the payload send by the issuer looks like this: 

`267160      0550,00$26726161550012MerchantName0550,0012Währung: EUR`

This string contains actually two messages separated by the dollar sign: 

| payload | purpose |
|---------|---------|
|`267160      0550,00`| Manual payload: Used as a fallback in case the flicker tan can't be displayed |
|`26726161550012MerchantName0550,0012Währung: EUR`| Flicker payload: The payload used to create the flicker image |

## Structure of the manual challenge:

The structure for the manual challange according to the official specification looks like this:

`26716zzznnp*` (`zzz` is a transaction dependent random number, `p*` stands for an arbitrary number of chars belonging to the payload) Split up into the individual fields the message would look like this:
`2 67 16 zzz` The meaning of these fields is as follows:

| field value | description | 
|-------------|-------------|
| 2           | Indicator what message structure is used. "2" stands for "Selektionstechnik" For our use case it can be seen as a simple constant |
| 67          | Numerical code that stands for the type of payment. 67 stands for internet payment |
| 16          | Numerical code that describes the type of the payload in the message. 16 stands for transaction amount |
| zzz         | A three digit random number |
| nn          | payload length indicator |
| p*          | the payload (in our case the transaction amount) The number of characters in the payload field is indicated by the value of the length field|
 
### Sparda special case

In case of Sparda the manual field is structured differently (Don't ask me why...) For Sparda the manual challenge 
always looks like this:

`267160      aaaaaa`

The header is the same for the first five bytes, but the three random digits are replaced by a single `0`. Also instead 
using the two byte length indicator the amount value is space separated.
  
## Structure of the flicker challenge:

Usually the challenge for flicker tan looks like this example here:

`26726161550012MerchantName0550,0012Währung: EUR`

If we separate this message into the individual fields and replace some of the non constant values from the example
with placeholders, it would look like this:

`2 67 26 16 15 zzz nn pp nn pp nn pp`

TODO: Explain the start code in greater detail 

The individual fields described for this example:

| field value | description | 
|-------------|-------------|
| 2           | Indicator what message structure is used. "2" stands for "Selektionstechnik" For our use case it can be seen as a simple constant |
| 67          | Numerical code that stands for the type of payment. 67 stands for internet payment |
| 26          | Numerical indicator for merchant name |
| 16          | Numerical indicator for amount | 
| 15          | Numerical indicator for bank data e.g. a field that can be used by the bank for arbitrary information | 
| zzz         | 3 digit random number provided by the issuer |
| nn          | length indicator for the following payload field (here the merchant name)|
| pp          | the payload with a length as indicated by the preceding nn length indicator (here the merchant name)|
| nn          | length indicator for the following payload field (here the amount)|
| pp          | the payload with a length as indicated by the preceding nn length indicator (here the amount)|
| nn          | length indicator for the following payload field (here the bank data)|
| pp          | the payload with a length as indicated by the preceding nn length indicator (here the bank data)|

The range from (including) message structure indicator to the 3 digit random number (including) is also refered to as the 
Startcode, as you will see below.

The basic concept in the message structure is that the values between the prefix `267`and the 3 digit random number 
indicate the type and the order of the following payload fields. As you can see in the example above the sequence `26 16 15`
indicates that the payload fields will be in the order Merchant name (26), Amount (16) and arbitrary bank data (15).
 
## Encoding of the text fields 

The text format in the message must be converted to a modified ISO 646 character set. For the most part this encoding is identical with the
characters defined in the ISO 8859 / ASCII standard for the characters codes below $7f. But there are the following modifications to make 
some characters available not normally available in the ISO 646 character set:

| character code | character |
|----------------|-----------|
| $23            | #         |
| $24            | €         |
| $40            | @         |
| $5B            | Ä         |
| $5C            | Ö         |
| $5D            | Ü         |
| $5E            | &#x00a3;  |
| $7B            | ä         |
| $7C            | ö         |
| $7D            | ü         |
| $7E            | &#x00DF;  |

## Preparation for display as a flicker tan

To transmit the payload via the optical transmission, it needs to be transformed to a special format. After the transformation
the payload looks like this: 

`Payload length | Format / Length Startcode | ControlByte | Startcode | Fmt / Length data 1 | data 1 | Fmt / Length data 2 | data 2 |  Fmt / Length data 2 | data 2 | Checksum` 

 
- Payload length : Length of the payload (excluding the synchronisation pattern): Length: 1 Byte
- Format : describes the format of start code. Length: 1 Byte 
    - Internal structure of the Format byte
    - Bit 7: set if a control byte is included. In this use case always set to 1)
    - Bit 6: Indicator if the start code is encoded in ascii or BCD. In our use it's always BCD)
    - Bits 5..0 : the actual length of the start element)
- Control Byte : for our purposes always set to `0x01` Length: 1 Byte
- Startcode: Startcode from the  

- Length/Format : bits 0-5 : length of datafield binary
                  bit 6 : encoding of the following data field (1:ASCII / 0 : BCD)
- Data field : Value in ISO 676 encoding   
- Checksum : The checksum is one byte long. It actually consists of two checksums : 
    - bits 7-4 : Luhn number (Lunh number is calculated with the control byte, the startcode and the data elements) -
    - bits 3-0 :  xor over all 4 bit segments of the message starting from challenge length up and including the data fields    

Example:

| Fieldvalue | Description |
|------------|-------------|
| 29         | Payloadlength|
|86          |  Format | 
|01 | Controlbyte|
|2 67 26 16 15 500 |  Startcode (see above for a detailed description)|
|4C | Length / format 1 |
|4D65726368616E744E616D65 | Data value 1 |
| 45 | Length / Format 2 | 
| 35302C3030 |Data 2 | 
| 4C | Length / Format 3 | 
|577B6872756E673A20455552 | Data 3 |
| 51 | Checksum |
 

## Final preparation
- SynchronisationPattern: `0FF` Length: 12 bits
- payload after the synchronisation: the nibbles in each byte are switched for the transmission via the flicker code 

## Transmission to the device 

The transmission occurs in blocks of 4 bits (encoded in the display fields 2 to 5)
The left most display element is the clock used to synchronize with the device. It flickers at twice the frequency  of the 
other flicker fields and always starts with 1 (white). The device detects the change from 1 to 0 (white to black) and then starts reading 
the current values on the LEDs till the color of the clock field switches again to 1 (white)
 


  


 

