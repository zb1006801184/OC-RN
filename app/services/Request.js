
import React, {Component} from "react";
export default class Request extends Component {
/*
  *  	post请求
  *		url: url地址
  *   param: 参数
  *   callback: 为网络请求回调函数

 */
   requestPost(url, param, callback,falidback) {
    var contentUrl = 'https://api.xianhuoapp.com/Api/' + url +'/';
      var fetchParam = {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(param)
      };
      fetch(contentUrl, fetchParam)
      .then((response) => response.text())
      .then((responseText) => {
        //打印数据
      console.log('ACTION: '+ JSON.stringify(url), 'REQUEST: '+ JSON.stringify(param), 'RESPONSE: '+JSON.stringify(responseText));
        callback(JSON.parse(responseText));
      })
      .catch((error) => {
        console.log(error);
        falidback(error);
      }).done();
    }

}