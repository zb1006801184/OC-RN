import React, { Component } from 'react';
import {Text,View,Image,StyleSheet,TouchableOpacity} from 'react-native';
import PropTypes from 'prop-types';
class HomeViewListCell extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        const {rowData,index,onClick} = this.props;
        //左边图片
        const leftImage = 
                <Image style = {{width:90*scrnRatioX,height:90*scrnRatioY,marginLeft:3,marginTop:3,backgroundColor:'red'}}>
                </Image>
        //底部
        const bottomImage = 
                <Image style = {{backgroundColor:'#999999',height:6*scrnRatioY,width:global.width}}></Image>
        
        //右边视图
        const rightView = 
                <View style = {{width:(global.width - 100)*scrnRatioX,height:90*scrnRatioY,justifyContent:'space-between'}}>
                    <View style = {{height:20*scrnRatioY,justifyContent:"space-between",flexDirection:'row',alignItems:'center'}}>
                        <Text>标题</Text>
                        <Text>价格:98</Text>
                    </View>
                    <View style = {{}}>
                        <Text>简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介</Text>
                    </View>
                    <View style = {{flexDirection:'row',justifyContent:'space-between'}}>
                        <View></View>
                        <Text style = {{marginRight:5}}>2017-11-6 11:21</Text>
                    </View>
                </View>

        
       return(
           <TouchableOpacity onPress = {() => {this.props.onClick(index)}}>
          <View>
           <View style = {{height:96*scrnRatioY,flexDirection:'row'}}>
             {leftImage}
             {rightView}
           </View>
             {bottomImage}
          </View>
          </TouchableOpacity>
       );
    }
}
HomeViewListCell.PropTypes = {
    //数据源
    rowData:PropTypes.object.isReuired,
    index:PropTypes.string.isReuired,
    //点击方法
    onClick:PropTypes.func.isReuired,
}
HomeViewListCell.defautProps = {
    rowData : {},
    index : '0',
    onClick: () => {},
}

const styles = StyleSheet.create({
    ConmonViewStyle:{
        width:(global.width - 100),
        height:90,
    }
})
export default HomeViewListCell;