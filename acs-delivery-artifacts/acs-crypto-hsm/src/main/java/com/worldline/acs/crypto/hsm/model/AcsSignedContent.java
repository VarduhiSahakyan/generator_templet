package com.worldline.acs.crypto.hsm.model;

import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import net.wl.crys.hsm.api.exception.CryptoException;
import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.map.ObjectMapper;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Objects;

final public class AcsSignedContent {

    private ObjectMapper objectMapper = new ObjectMapper();

    private Base64 base64UrlEncoder = new Base64(-1, null, true);

    private HeaderAcsSignedContent header;
    private byte[] payload;
    private byte[] signatureBytes;

    private static final String EMPTY_STRING = "";
    private static final String PERIOD_SEPARATOR = ".";
    private static final String PERIOD_SEPARATOR_REGEX = "\\.";
    private static final String US_ASCII = "US-ASCII";

    public AcsSignedContent() {}

    public void constructHeader(String signingCertificate, String authorityCertificate, String rootCertificate, String algo) throws CryptoOperationFailedException {
        if(Objects.isNull(signingCertificate)){
            throw new CryptoOperationFailedException("No signing certificate for acsSignedContent");
        }

        header = new HeaderAcsSignedContent();
        header.setAlg(algo);

        ArrayList<String> certificatesList = new ArrayList();
        certificatesList.add(signingCertificate);
        certificatesList.add(authorityCertificate);
        certificatesList.add(rootCertificate);
        certificatesList.removeAll(Collections.singleton(null));

        header.setX5c(certificatesList.toArray(new String[certificatesList.size()]));
    }

    public String getCompactSerialization() throws CryptoOperationFailedException {
        return serialize(getEncodedHeader(), getEncodedPayload(), getEncodedSignature());
    }

    public void setPayload(byte[] payload) {

        this.payload = payload;
    }

    public void setSignatureBytes(byte[] signatureBytes) {
        this.signatureBytes = signatureBytes;
    }

    public String getEncodedSignature() {
        return base64UrlEncode(signatureBytes);
    }

    public String getEncodedPayload() {
        return base64UrlEncode(payload);
    }

    public String getEncodedHeader() throws CryptoOperationFailedException {
        String output = "";
        try {
            output = objectMapper.writeValueAsString(header);
        } catch (IOException e) {
            output = header.toString();
        }

        return base64UrlEncodeUtf8ByteRepresentation(output);
    }

    public HeaderAcsSignedContent getHeader(){
        return this.header;
    }

    public byte[] getSigningInputBytes() throws CryptoOperationFailedException {
        String signingInputString = serialize(getEncodedHeader(), getEncodedPayload());
        try {
            return signingInputString.getBytes(US_ASCII);
        } catch (UnsupportedEncodingException e) {
            throw new CryptoOperationFailedException("Error during header construction of AcsSignedContent",e.getCause());
        }
    }

    private String serialize(String... parts)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < parts.length; i++)
        {
            String part = (parts[i] == null) ? EMPTY_STRING : parts[i];
            sb.append(part);
            if (i != parts.length - 1)
            {
                sb.append(PERIOD_SEPARATOR);
            }
        }
        return sb.toString();
    }

    private String base64UrlEncode(byte[] input) {
        return base64UrlEncoder.encodeToString(input);
    }

    private String base64UrlEncodeUtf8ByteRepresentation(String input) throws CryptoOperationFailedException {
        try {
            return base64UrlEncode(input.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            throw new CryptoOperationFailedException("Error during Encoded in UTF-8 acsSignedContent header", e.getCause());
        }
    }

    protected static String[] deserialize(String compactSerialization)
    {
        String[] parts = compactSerialization.split(PERIOD_SEPARATOR_REGEX);

        if (compactSerialization.endsWith(PERIOD_SEPARATOR))
        {
            String[] tempParts = new String[parts.length + 1];
            System.arraycopy(parts, 0, tempParts, 0, parts.length);
            tempParts[parts.length] = EMPTY_STRING;
            parts = tempParts;
        }

        return parts;
    }

    final public class HeaderAcsSignedContent {

        private String[] x5c;
        private String alg;

        public String getAlg() {
            return alg;
        }

        public void setAlg(String alg) {
            this.alg = alg;
        }

        public String[] getX5c() {
            return x5c;
        }

        public void setX5c(String[] x5c) {
            this.x5c = x5c;
        }

        public String toString(){
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("{\"x5c\":[");
            for (int i = 0; i < x5c.length; i++){
                stringBuilder.append("\""+x5c[i]+"\"");

                if(i + 1 != x5c.length){
                    stringBuilder.append(",");
                }else{
                    stringBuilder.append("],");
                }
            }

            stringBuilder.append("\"alg\":").append("\""+alg+"\"}");

            return stringBuilder.toString();
        }
    }

}
