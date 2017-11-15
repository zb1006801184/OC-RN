import React, {Component} from "react";
import {StyleSheet, Image,View} from "react-native";
import TabNavigator from "react-native-tab-navigator";
//tabbar 对应的四个页面
import HomeComponents from "../components/HomeComponents";
import FineComponents from "../components/FineComponents";
import MessageComponents from "../components/MessageComponents";
import MinComponents from "../components/MinComponents";

//tabbar  四个按钮
const SELECTED_TAG = 'home';
const SELECTED_TITLE = '首页';
const SELECTED_NORMAL = require('../images/syqt/home.png');
const SELECTED_FOCUS = require('../images/syqt/homeco.png');

const EXPLORE_TAG = 'find';
const EXPLORE_TITLE = '发现';
const EXPLORE_NORMAL = require('../images/syqt/secret.png');
const EXPLORE_FOCUS = require('../images/syqt/secretco.png');

const FOLLOW_TAG = 'message';
const FOLLOW_TITLE = '信息';
const FOLLOW_NORMAL = require('../images/syqt/notice.png');
const FOLLOW_FOCUS = require('../images/syqt/noticeco.png');

const PROFILE_TAG = 'mine';
const PROFILE_TITLE = '我的';
const PROFILE_NORMAL = require('../images/syqt/mine.png');
const PROFILE_FOCUS = require('../images/syqt/mineco.png');

export default class TabbarText extends Component {

    constructor(props) {
        super(props)

        this.state = {
            selectedTab: SELECTED_TAG
        }
    }
// <view/>
    render() {
        return (
            <TabNavigator
                tabBarStyle={MainPageStyle.tab_container}
                tabBarShadowStyle={{height: 0}}>
                {this._renderTabItem(SELECTED_TAG, SELECTED_TITLE, SELECTED_NORMAL, SELECTED_FOCUS)}
                {this._renderTabItem(EXPLORE_TAG, EXPLORE_TITLE, EXPLORE_NORMAL, EXPLORE_FOCUS)}
                {this._renderTabItem(FOLLOW_TAG, FOLLOW_TITLE, FOLLOW_NORMAL, FOLLOW_FOCUS)}
                {this._renderTabItem(PROFILE_TAG, PROFILE_TITLE, PROFILE_NORMAL, PROFILE_FOCUS)}
            </TabNavigator>
        )
    }

    /**
     * 渲染tab中的item
     * @param tag
     * @param title
     * @param iconNormal
     * @param iconFocus
     * @param pageView
     * @returns {XML}
     * @private
     */
    _renderTabItem(tag, title, iconNormal, iconFocus) {
        return (
            <TabNavigator.Item
                selected={this.state.selectedTab === tag}
                title={title}
                titleStyle={MainPageStyle.tab_title}
                selectedTitleStyle={MainPageStyle.tab_title_selected}
                renderIcon={() => <Image source={iconNormal} style={MainPageStyle.tab_icon}/>}
                renderSelectedIcon={() => <Image source={iconFocus} style={MainPageStyle.tab_icon}/>}
                onPress={() => this.setState({selectedTab: tag})}>
                {this._createContentPage(tag)}
            </TabNavigator.Item>
        )
    }

    /**
     * 渲染tab对应的内容页面
     * @param tag
     * @returns {XML}
     * @private
     */
    _createContentPage(tag) {
        switch (tag) {
            case SELECTED_TAG:
                return (<HomeComponents/>);
            case EXPLORE_TAG:
                return (<FineComponents/>);
            case FOLLOW_TAG:
                return (<MessageComponents/>);
            case PROFILE_TAG:
                return (<MinComponents/>);
        }
    }


}

const MainPageStyle = StyleSheet.create({
    tab_container: {
        height: 49,
    },
    tab_icon: {
        width: 23,
        height: 23,
        resizeMode: 'contain',
    },
    tab_title: {
        color: "#929292",
        fontSize: 8,
    },
    tab_title_selected: {
        color: "#333333",
        fontSize: 8,
    }
})