import {getApiName} from '../AppConfig'
const initialState = {
    data:[],
    };
export default function GoodsIndex(state = initialState, action = {}) {
    const response = action.response;
    switch (action.type) {
      case getApiName().GoodsIndex:
        return {
          ...state,
          data: response.data,
        };
      default:
        return state;
    }
  }
      