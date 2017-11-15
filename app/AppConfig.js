//获取接口名称
exports.getApiName = function () {
    const names = require('./Api.name.config.json');
    return names;
};