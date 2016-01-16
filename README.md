# fw-syslog-parser  
Install  
-------  
1. npm i https://github.com/Orientsoft/fw-syslog-parser.git  
2. cp config/default.js config/config.js, modify it if you need. ONLY config/config.js will be read by parser  
3. gulp build  
4. node fw-syslog-parser  

Description  
-----------  
1. syslog is feed from STDIN  
2. unsuccessfully parsed log and error message will be published to [YOUR_REDIS_CHANNEL]-log channel  
