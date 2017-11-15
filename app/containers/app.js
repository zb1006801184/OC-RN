import React, {Component} from 'react';

import { createStore, applyMiddleware, combineReducers } from 'redux';
import { Provider } from 'react-redux';
import thunk from 'redux-thunk';

import * as reducers from '../reducers';
import HomeNComponents from '../components/HomeNComponents';

const createStoreWithMiddleware = applyMiddleware(thunk)(createStore);
const reducer = combineReducers(reducers);
const store = createStoreWithMiddleware(reducer);

//获取屏幕尺寸
import Dimensions from 'Dimensions';
var { width, height } = Dimensions.get('window');
global.width = width;
global.height = height;
global.scrnRatioX = width/375;
global.scrnRatioY = height/667;

export default class App extends Component {
  componentDidMount(){
    
  }
  render() {
    return (
      <Provider store={store}>
        <HomeNComponents/>
      </Provider>
    );
  }
}
