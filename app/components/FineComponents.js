import React, {Component} from "react";
import {StyleSheet, Image,View,Text} from "react-native";
import { requestApi } from '../actions/RequestApi';
import { connect } from 'react-redux';

 class FineComponents extends Component {
   constructor(props) {
        super(props);
    }
    static navigationOptions={
      title: '第二页',//设置标题内容
  }
  componentWillMount() {
    const {dispatch} = this.props;    
     dispatch(requestApi("Goods/index", { 'p' : '1' }, this.onSuccess.bind(this), this.onFlied.bind(this)));
    
  }
  onSuccess() {
    console.log('成功了。');
    console.log('data:'+this.props.GoodsIndex.data);
  }
  onFlied() {
    console.log('失败了。');
  }
  render() {
    return (
      <Text style = {styles.mainText}>FindPage!!</Text>
    );
  }
}

const styles = StyleSheet.create({
    
    mainText:{
        marginTop:100,
        marginLeft:100,
    },

});
function mapStateToProps(state) {
  const { GoodsIndex } = state
  return {
    GoodsIndex,
  }
}
export default connect(mapStateToProps)(FineComponents);
