# fw-syslog-parser  
Install  
-------  
1. npm i https://github.com/Orientsoft/fw-syslog-parser.git  
2. npm i
3. npm i -g gulp, if you don't have gulp installed globally
2. cp config/default.js config/config.js, modify it if you need. ONLY config/config.js will be read by parser  
3. gulp build  
4. node fw-syslog-parser  

Description  
-----------  
1. syslog is feed from STDIN  
2. unsuccessfully parsed log and error message will be published to [YOUR_REDIS_CHANNEL]-log channel  

Grammar
-------
fw-syslog-parser supports 2 stage parsing:
Stage 1. syslog - produces standard syslog structure:  
    
    var json = {
      localTime: Date, // 收集日志的主机时间
      remoteTime: Date, // 产生日志的主机时间
      hostname: 'FW-OUT', // 主机名称
      tag: '%%', // 厂商标识，%%代表华为
      version: '01', // 日志版本，2位数，从01开始编号
      module: 'SEC', // 产生日志的模块
      serverity: 4, // 日志级别，0-7，越小越严重
      brief: 'POLICYPERMIT', // 日志内容概要
      type: 'i', // i表示日志类型
      secInfo: String // 下一级内容字串
    }
Stage 2. payload - there are three kinds of payload possible for now, the type of payload is identified by 'brief' field in syslog structure:  
1. 'POLICYPERMIT' or 'POLICYDENY'  
2. 'ATCKDF'  
3. 'STREAM'  

To add more payload support, visit pegjs.org/online and review its documents.

Example
-------
Raw log:  
    
    Jan 13 17:56:09 2016-01-13 17: 53:49 FW-OUT %%01SEC/4/POLICYPERMIT(l): protocol=17, source-ip=10.21.35.190, source-port=16123, destination-ip=81.193.166.96, destination-port=6010, time=2016/01/13 17:53:49, interzone-trust(public)-cmcc(public) outbound, policy=0.#015  

Parser output:  
    
    var json = {
      localTime: Date, // 收集日志的主机时间
      remoteTime: Date, // 产生日志的主机时间
      hostname: 'FW-OUT', // 主机名称
      tag: '%%', // 厂商标识，%%代表华为
      version: '01', // 日志版本，2位数，从01开始编号
      module: 'SEC', // 产生日志的模块
      serverity: 4, // 日志级别，0-7，越小越严重
      brief: 'POLICYPERMIT', // 日志内容概要
      type: 'i', // i表示日志类型
      secInfo: { // SEC模块输出的日志内容
        protocol: 17, // 协议
        sourceIP: '10.21.35.190', // 源IP
        sourcePort: 16123, // 源端口
        destIP: '81.193.166.96', // 目标IP
        destPort: 6010, // 目标端口
        ts: Date, // 时间戳，理论上与remoteTime一致
        commLink: 'interzone-trust(public)-cmcc(public) outbound', // 通信链路信息
        policy: '0.#015' // 规则信息
      }
    }
