package study.login.service;

import java.security.Key;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {
	private Key cryptKey;
	private String iv;
	
	public AESUtil(String key) throws Exception {
		iv = key.substring(0, 16);
		
		byte[] keyBytes = new byte[16];
		byte[] keyStringToBytes = key.getBytes("UTF-8");
		int len = keyStringToBytes.length;
		if (len > keyBytes.length) {
			len = keyBytes.length;
		}
		System.arraycopy(keyStringToBytes, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		
		cryptKey = keySpec;
	}
	
	public String encode(String str) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, cryptKey, new IvParameterSpec(iv.getBytes()));
		byte[] encreptedBytes = cipher.doFinal(str.getBytes("UTF-8"));
		String encreptedStr = new String(Base64.getEncoder().encode(encreptedBytes));
		
		return encreptedStr;
	}
	
	public String decode(String str) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, cryptKey, new IvParameterSpec(iv.getBytes()));
		
		byte[] encreptedBytes = (Base64.getDecoder().decode(str.getBytes("UTF-8")));
		String decryptedStr = new String(cipher.doFinal(encreptedBytes));
		
		return decryptedStr;
	}
	
	
}
