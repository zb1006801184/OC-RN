import { AppRegistry ,ListView,NativeModules} from 'react-native';
import React, { Component ,TouchableOpacity} from 'react';
import {
    StyleSheet,
    Text,
    View
  } from 'react-native';
  import {
    StackNavigator,
    TabNavigator
} from 'react-navigation';
import HomeViewListCell from "../cell/HomeViewListCell";
import FineComponents from './FineComponents';

import { createStore, applyMiddleware, combineReducers } from 'redux';
import { Provider } from 'react-redux';
import thunk from 'redux-thunk';
import * as reducers from '../reducers';
const createStoreWithMiddleware = applyMiddleware(thunk)(createStore);
const reducer = combineReducers(reducers);
const store = createStoreWithMiddleware(reducer);

var RNViewController = NativeModules.RNViewController;
export class HomeNComponents extends Component {
    constructor(props) {
        super(props);
        this.state = {
            dataList:[],
            dataSource: new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 }),            
        }

    }
      static navigationOptions={
          title: '首页',//设置标题内容
          headerBackTitle:null,          
      }
          //HomeViewListCell
    renderCell(rowData,rowId) {
        return(
            <HomeViewListCell
            rowData = {rowData}
            index = {rowId}
            onClick = {this.cellOnClick.bind(this)}
            />
        );
    }
    
    //cell的点击事件
    cellOnClick(rowData) {
        console.log("点击了"+rowData);
        const { navigate } = this.props.navigation;        
        if(rowData == 0){
            RNViewController.RNViewControllerClick(rowData);
        }else {
            navigate('FineComponents', { user: 'Lucy' });
        }
    }
      render() {
          //列表
    const mainView = () => {
        return (
            <ListView
            dataSource={this.state.dataSource.cloneWithRows(['1','2'])}
            renderRow={(rowData, sectionId, rowId) => this.renderCell(rowData, rowId)}
            enableEmptySections={true}
            removeClippedSubviews={false}
            />
        );

    }
        return (
          <View style={styles.container}>
            {mainView()}
          </View>
        );
      }
    }
    const styles = StyleSheet.create({
        container: {
          flex: 1,
          justifyContent: 'center',
          alignItems: 'center',
          backgroundColor: '#F5FCFF',
        },
        welcome: {
          fontSize: 20,
          textAlign: 'center',
          margin: 10,
        },
        mainStyle: {
          textAlign: 'center',
          color: '#333333',
          marginBottom: 5,
        },
      });
      const SimpleApp = StackNavigator({
        Home: {
               screen: HomeNComponents,
        },
        FineComponents: {
              screen: FineComponents,
        }
    });

    export default SimpleApp;