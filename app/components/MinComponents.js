import React, {Component} from "react";
import {StyleSheet, Image,View,Text} from "react-native";

export default class MineComponents extends Component {
   constructor(props) {
        super(props);
    }
  render() {
    return (
      <Text style = {styles.mainText}>mine!!</Text>
    );
  }
}

const styles = StyleSheet.create({
    
    mainText:{
        marginTop:100,
    },

});