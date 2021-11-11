/**
 * 
 *  Last Updated: 2021.01.29
 *  Writer: Lee Hyun Ki
 * 
 */
checkStatusInterval = null;
didSessionKey = null;

var didLogin = {
	setOption: function(jsonInput) {
		if (jsonInput.origin != undefined) {
			this.loginOption.origin = jsonInput.origin;
		}
		if (jsonInput.siteId != undefined) {
			this.loginOption.siteId = jsonInput.siteId;
		}
		if (jsonInput.width != undefined) {
			this.loginOption.width = jsonInput.width;
		}
		if (jsonInput.isClose != undefined) {
			this.loginOption.isClose = jsonInput.isClose;
		}
		if (jsonInput.requiredVC != undefined) {
			this.loginOption.requiredVC = jsonInput.requiredVC;
		}
		if (jsonInput.subVC != undefined) {
			this.loginOption.subVC = jsonInput.subVC;
		}
	},
	loginOption: {origin: window.location.origin, siteId: '', requiredVC: '', subVC: '', width: 800, height: 700, isClose: true},
	vpVerify: function(qrcodeVal, inputFunction) {
		var siteId = '';
		var requiredVC = '';
		var subVC = '';
		var origin = window.location.origin;
		
		if (qrcodeVal == null || qrcodeVal == '' || qrcodeVal == 'null') {
			console.error("qrcode값은 null이 될 수 없습니다.");
			return false;
		}
		
		if (this.loginOption.siteId != null && this.loginOption.siteId != undefined) {
			siteId = this.loginOption.siteId;
		}
		
		if (this.loginOption.requiredVC != null && this.loginOption.requiredVC != undefined) {
			requiredVC = this.loginOption.requiredVC;
		}
		
		if (this.loginOption.subVC != null && this.loginOption.subVC != undefined) {
			subVC = this.loginOption.subVC;
		}
		
		if (this.loginOption.origin != null && this.loginOption.origin != undefined) {
			origin = this.loginOption.origin;
		}
		
		$.ajax({
     		//url:"https://diddapp.daegu.go.kr/dgbp/externalQrCheckerSelectedVC.do",
     		url:"https://dgbp.daeguedu.com/dgbp/externalQrCheckerSelectedVC.do",
     		type: "post",
     		data: {qrcode: qrcodeVal, siteId: siteId, origin: origin, requiredVC: requiredVC, subVC: subVC},
     		dataType: "json",
     		success: function(result) {
     			if (result.success) {
     				inputFunction(result.returnData);
     			} else {
     				console.error("VP verification failed");
     			}
     		}
     	});
	},
	getQrData: function() {
		var qrcode = '';
		var origin = window.location.origin;
		if (this.loginOption.origin != null && this.loginOption.origin != undefined) {
			origin = this.loginOption.origin;
		}
		$.ajax({
			//url: "https://diddapp.daegu.go.kr/dgbp/extDidQrCodeCreateSelectedVC.do",
     		url:"https://dgbp.daeguedu.com/dgbp/extDidQrCodeCreateSelectedVC.do",
			data: {sessionKey: '',  parentUrl: '' , requiredVC: this.loginOption.requiredVC, subVC: this.loginOption.subVC},
			dataType: "json",
			type: "post",
			async:false,
			success: function(data) {
				didSessionKey = data.session_key;
				var qrcode2 = JSON.stringify(data);
				qrcode = '{\"response\":' + qrcode2 + '}';
			},
			error :function (xhr,status) {
				console.error("세션을 반환받을 수 없었습니다.");
			}
		});
		return qrcode;
	},
	callback: function(inputFunction, isClose) {
		if (isClose != undefined) {
			this.loginOption.isClose = isClose;
		}
		chkrun(inputFunction);
		checkStatusInterval = setInterval(function() {chkrun(inputFunction);}, 2000);
	}
}

function chkrun(inputFunction) {
	var sessionKey = didSessionKey;
	var siteId = didLogin.loginOption.siteId;
	var origin = window.location.origin;
	if (didLogin.loginOption.origin != null && didLogin.loginOption.origin != undefined) {
		origin = didLogin.loginOption.origin;
	}
	$.ajax({
		//url: "https://diddapp.daegu.go.kr/dgbp/extQrCodeCheckerSelectedVC.do",
 		url:"https://dgbp.daeguedu.com/dgbp/extQrCodeCheckerSelectedVC.do",
		data: {session_key: sessionKey, siteId: siteId, origin: origin},
		dataType: "json",
		type: "post",
		success: function(data) {
			if (data.success) {
				clearInterval(checkStatusInterval);
				
				var returnUrl = data.returnUrl;
				
				if (returnUrl != "Failed") {
					var returnJson = JSON.stringify(data.returnData);
					
					inputFunction(data.returnData);
					if (didLogin.loginOption.isClose) {
						self.close();
					}
				} else {
					alert(data.msg);
					if (didLogin.loginOption.isClose) {
						self.close();
					}
					return;
				}
				
			}else {
				if (data.returnUrl == "Failed") {
					clearInterval(checkStatusInterval);
					console.error(data.msg);
					return;
				}
			}
		},
		error :function (xhr,status) {
			console.error("세션을 반환받을 수 없었습니다.");
			return;
		}
	});
}