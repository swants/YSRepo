/**
 * @param url String地址.
 * @param type Int类型.
 * @param callBack String回调方法名.
 * @param params String json形式的字符串.
 * @returns {*}
 */
function checkAndroid() {
    var u = navigator.userAgent;
    //android终端
    return u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;
  }
  function checkIos() {
    var u = navigator.userAgent;
    //ios终端
    return !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
  }
 function api(type, callBack, params) {
     var status=0;
     if (checkAndroid()) {
      window.getDataFromNative.postMessage(type, callBack,params);

    } else if (checkIos()) {
      window.webkit.messageHandlers.appTest.postMessage({
        type: type,
        callback: callBack,
        params: params
      });
    } else {
      alert('无法识别设备');
    } 
  }

  