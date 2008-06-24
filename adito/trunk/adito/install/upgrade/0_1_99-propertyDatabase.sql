//
// This is the first database created so is the best place to create the functions
//

CREATE ALIAS PASSWORD FOR 'com.adito.jdbc.hsqldb.DBFunctions.password';
CREATE ALIAS ENCODE FOR 'com.adito.jdbc.hsqldb.DBFunctions.encode';
CREATE ALIAS DECODE FOR 'com.adito.jdbc.hsqldb.DBFunctions.decode';
CREATE ALIAS ENCPASSWORD FOR 'com.adito.jdbc.hsqldb.DBFunctions.encPassword';
CREATE ALIAS MATCHES FOR 'com.adito.jdbc.hsqldb.DBFunctions.matches';

// DB configuration

SET PROPERTY "hsqldb.cache_scale" 8;

// 
// Properties
//

CREATE CACHED TABLE EXPLORER_PROPERTIES
(
   USERNAME VARCHAR(255) not null,
   NAME VARCHAR(255) not null,
   VALUE VARCHAR(255) not null,
   PROFILE_ID INTEGER
);

CREATE UNIQUE INDEX SYS_IDX_PROPERTY_CONSTRAINT_1 ON EXPLORER_PROPERTIES
(
  USERNAME,
  NAME,
  PROFILE_ID
);


INSERT INTO EXPLORER_PROPERTIES (USERNAME,NAME,VALUE,PROFILE_ID) VALUES ('','client.heartbeat.interval','40000',0);
INSERT INTO EXPLORER_PROPERTIES (USERNAME,NAME,VALUE,PROFILE_ID) VALUES ('','client.registration.synchronization.timeout','10000',0);
INSERT INTO EXPLORER_PROPERTIES (USERNAME,NAME,VALUE,PROFILE_ID) VALUES ('','client.shutdown.wait','2500',0);
CREATE CACHED TABLE EXPLORER_PROPERTY_DEFINITION
(
   NAME VARCHAR(255) PRIMARY KEY,
   VISIBILITY TINYINT not null,
   TYPE TINYINT not null,
   SORT_ORDER INTEGER not null,
   TYPE_META VARCHAR(255) not null,
   CATEGORY INTEGER not null,
   DEFAULT_VALUE VARCHAR(255) not null,
   HIDDEN TINYINT
);

INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('authenticationScheme.default',2,3,5,'',65,'1',1);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('cifs.guestPassword',2,4,200,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('cifs.guestUser',2,0,190,'',40,'GUEST',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('cifs.userCacheSize',2,0,170,'',40,'10000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('cifs.userCacheTTL',2,7,180,'s',40,'30000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.autoStart',1,2,40,'',10,'false',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.browserCommand',1,0,50,'',10,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.debug',1,2,70,'',10,'false',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.heartbeat.interval',1,7,10,'s',10,'40000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.preventSessionTimeoutIfActive',1,2,110,'',10,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.registration.synchronization.timeout',1,7,30,'s',10,'60000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.shutdown.wait',1,7,20,'s',10,'2500',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.tunnel.inactivity',1,7,65,'s',10,'600000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('client.webforward.inactivity',1,7,60,'s',10,'300000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.hostname',1,0,20,'',15,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.password',1,4,50,'',15,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.port',1,1,30,'',15,'3128',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.preferredAuthentication',1,3,60,'AUTO,BASIC,NTLM',15,'AUTO',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.type',1,3,10,'none,browser,http,https',15,'browser',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('clientProxy.username',1,0,40,'',15,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('fileBrowsing.auth.tryCurrentUser',2,2,70,'',20,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('fileBrowsing.auth.tryGuest',2,2,80,'',20,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.baddr',2,0,80,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.hostname',2,0,50,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.laddr',2,0,70,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.lmhosts',2,0,90,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.retryCount',2,1,110,'',40,'2',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.retryTimeout',2,7,120,'s',40,'3000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.scope',2,0,60,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.soTimeout',2,7,100,'s',40,'5000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.netbios.wins',2,0,40,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.resolveOrder',2,0,160,'',40,'LMHOSTS,WINS,BCAST,DNS',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.smb.client.disablePlainTextPasswords',2,2,140,'',40,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.smb.client.laddr',2,0,130,'',40,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.smb.client.responseTimeout',2,7,150,'s',40,'10000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('jcifs.smb.client.soTimeout',2,7,150,'s',40,'15000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('profiles.promptForProfileAtLogon',2,2,10,'',50,'false',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('radius.accountingPort',2,1,30,'',200,'1813',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('radius.authenticationMethod',2,3,50,'chap,ppp',200,'chap',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('radius.authenticationPort',2,1,20,'',200,'1812',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('radius.serverHostName',2,0,10,'',200,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('radius.sharedSecret',2,0,40,'',200,'shared_secret',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.administrators',2,5,100,'25x5',60,'Administrators!admin',1);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.lockDuration',2,1,30,'',60,'300',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.maskPersonalAnswers',2,2,130,'',60,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.maxLocksBeforeDisable',2,1,20,'',60,'3',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.maxLogonAttemptsBeforeLock',2,1,10,'',60,'3',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.multipleSessions',2,3,100,'0,1,2',60,'0',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.password.daysBeforeExpiry',2,1,70,'',60,'28',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.password.daysBeforeExpiryWarning',2,1,60,'',60,'21',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.password.pattern',2,0,40,'',60,'.{5,}',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.password.pattern.description',2,6,50,'30x5',60,'Password must be at least five characters in length',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.session.lockSessionOnBrowserClose',2,2,90,'',60,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.session.maxCookieAge',2,1,80,'',60,'900',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.userDatabase',2,3,5,'',60,'builtIn',1);

INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('security.privateKeyMode',2,3,90,'disabled,prompt,automatic',67,'automatic',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('pki.algorithm',2,3,200,'rsa,dsa',67,'rsa',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('pki.bitLength',2,3,210,'512,768,1024,2048',67,'1024',0);

INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('smtp.hostname',2,0,10,'',220,'localhost',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('smtp.login',2,0,30,'',220,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('smtp.port',2,1,20,'',220,'25',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('smtp.senderAddress',2,0,30,'',220,'adito@localhost.localdomain',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('smtp.startOnStartup',2,2,0,'',220,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('ui.homePage',1,0,20,'',30,'/showHome.do',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('ui.theme',1,0,40,'',30,'/theme/default',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('ui.toolTips',1,2,10,'',30,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('updates.automaticallyConnectToApplicationStore',2,2,0,'',110,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('updates.checkForCoreUpdates',2,2,10,'',110,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('updates.checkForExtensionUpdates',2,2,20,'',110,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webForwards.cache.clearOnLogout',2,2,50,'',90,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webForwards.cache.directory',2,0,10,'',90,'%TMP%/webcache',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webForwards.cache.maxUserAge',2,1,40,'',90,'0',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webForwards.cache.maxUserObjects',2,1,30,'',90,'10000',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webForwards.cache.maxUserSize',2,1,20,'',90,'10',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webServer.compression',1,2,120,'',70,'true',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webServer.sessionInactivityTimeout',1,1,50,'',70,'15',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webServer.validExternalHostnames',2,5,150,'30x5',70,'',0);
INSERT INTO EXPLORER_PROPERTY_DEFINITION (NAME,VISIBILITY,TYPE,SORT_ORDER,TYPE_META,CATEGORY,DEFAULT_VALUE,HIDDEN) VALUES ('webServer.invalidHostnameAction',2,3,160,'none,redirect,error,disconnect',70,'none',0);

//
// Profiles
//

CREATE CACHED TABLE PROPERTY_PROFILES
(
   ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 0, INCREMENT BY 1) NOT NULL ,
   USERNAME VARCHAR(50) not null,
   SHORT_NAME VARCHAR(255) not null,
   DESCRIPTION VARCHAR(255) not null,
   PARENT_RESOURCE_PERMISSION INTEGER,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP
);

INSERT INTO PROPERTY_PROFILES (USERNAME,SHORT_NAME,DESCRIPTION,PARENT_RESOURCE_PERMISSION,DATE_CREATED,DATE_AMENDED) VALUES ('','Default','The default profile.',0,NOW(),NOW());

DROP TABLE USER_ATTRIBUTES IF EXISTS;
CREATE CACHED TABLE USER_ATTRIBUTES
(
   USERNAME VARCHAR(2147483647) not null,
   ATTRIBUTE_NAME VARCHAR(2147483647) not null,
   ATTRIBUTE_VALUE VARCHAR(2147483647),
   CONSTRAINT USER_ATTRIBUTES_PK PRIMARY KEY (USERNAME,ATTRIBUTE_NAME)
);

DROP TABLE USER_ATTRIBUTE_DEFINITION IF EXISTS;
CREATE CACHED TABLE USER_ATTRIBUTE_DEFINITION
(
   NAME VARCHAR(255) PRIMARY KEY,
   VISIBILITY TINYINT not null,
   TYPE TINYINT not null,
   SORT_ORDER INTEGER not null,
   TEXT_LABEL VARCHAR(255) not null,
   TEXT_DESCRIPTION VARCHAR(65535) not null,
   TYPE_META VARCHAR(255) not null,
   CATEGORY INTEGER not null,
   CATEGORY_LABEL VARCHAR(255) not null,
   DEFAULT_VALUE VARCHAR(255) not null,
   HIDDEN TINYINT
);