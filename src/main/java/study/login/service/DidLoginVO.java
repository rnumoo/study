package study.login.service;

public class DidLoginVO {
    private String DID;
    private String Name;
    private String Gender;
    private String BirthDate;
    private String PhoneNumber;
    private String isForeigner;
    private String CI;

    public String getDID() {
        return DID;
    }

    public void setDID(String dID) {
        this.DID = dID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        this.Gender = gender;
    }

    public String getBirthDate() {
        return BirthDate;
    }

    public void setBirthDate(String birthDate) {
        this.BirthDate = birthDate;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.PhoneNumber = phoneNumber;
    }

    public String getIsForeigner() {
        return isForeigner;
    }

    public void setIsForeigner(String isForeigner) {
        this.isForeigner = isForeigner;
    }

    public String getCI() {
        return CI;
    }

    public void setCI(String cI) {
        this.CI = cI;
    }

}
