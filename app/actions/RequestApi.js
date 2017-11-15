import Request from '../services/Request';
import * as types from './actionsTypes';

export function requestApi(apiName, params = {}, successCallback=function(){},failureCallback=function(){}) {
		const request = new Request();
	return dispatch =>{
		request.requestPost(apiName,
							params,
							(response) =>{
								dispatch({type:apiName,response:response});
								successCallback(response);
							 },
							failureCallback
						);
	}
}

export function initData() {
	return {
    	type: types.INITDATA,
	};
}
