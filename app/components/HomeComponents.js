import React, {Component} from "react";
import {StyleSheet, Image,View,Text,ListView} from "react-native";
import Request from "../services/Request";
import Banner from "react-native-banner";
import HomeViewListCell from "../cell/HomeViewListCell";
export default class HomeComponents extends Component {
   constructor(props) {
        super(props);
        //banner数据（随便找的）
        this.banners = [
            {
                title: '第一张',
                image: 'https://img.xianhuoapp.com/FsIfwABy2i-MmcaUaEMhnntSMVNO',
            },
            {
                title: '第二张',
                image: 'https://img.xianhuoapp.com/pdf/5243717961.png',
            },
            {
                title: '第三张',
                image: 'https://img.xianhuoapp.com/FsIfwABy2i-MmcaUaEMhnntSMVNO',
            },
            {
                 title: '第四张',
                image: 'https://img.xianhuoapp.com/pdf/5243717961.png',
            },
        ];
        this.state = {
            defaultIndex: 0,
            dataList:[],
            dataSource: new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 }),            
        }
        this.defaultIndex = 0;

    }
  //网络请求
    componentWillMount(){
      //参数
      let param = {'p':'1'};
        //发起请求
        Request.requestPost('Goods/index',param,this.callback);
    }

  //成功的回调
  callback(data,isSuccess){
    if(isSuccess){
      alert(data["msg"]);
      console.log("数据："+ data["data"]);
      console.log("zz:"+global.height);
      this.setState({dataSource: this.state.dataSource.cloneWithRows(JSON.parse(JSON.stringify(['3','4'])))});
    }
  }

  //轮播图的点击事件
  clickListener(index) {
    // alert("click"+index);
    }

  onMomentumScrollEnd(event, state) {

    this.defaultIndex = state.index;
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
    }
  render() {

    //轮播图
    const banner = <Banner
                    banners={this.banners}
                    defaultIndex={this.defaultIndex}
                    onMomentumScrollEnd={this.onMomentumScrollEnd.bind(this)}
                    intent={this.clickListener.bind(this)}
                  />
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
             {banner}
             {mainView()}
            </View>
            );
  }


}
const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
    },
    listviewStyle: {
        flex:1,
        width:375,
        height:300,
        backgroundColor: 'red',
    }
});