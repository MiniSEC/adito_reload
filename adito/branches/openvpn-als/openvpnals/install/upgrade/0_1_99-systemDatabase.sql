//
// Application shortcuts
//

CREATE CACHED TABLE APPLICATION_SHORTCUTS
(
   RESOURCE_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   NAME VARCHAR(2147483647),
   DESCRIPTION VARCHAR(2147483647),
   APPLICATION VARCHAR(2147483647),
   PARENT_RESOURCE_PERMISSION INTEGER not null,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP
);

CREATE CACHED TABLE APPLICATION_SHORTCUTS_PARAMETERS
(
   SHORTCUT_ID INTEGER not null,
   PARAMETER VARCHAR(255) not null,
   VALUE VARCHAR(255) not null,
   CONSTRAINT APPLICATION_SHORTCUTS_PARAMETERS_PK PRIMARY KEY (SHORTCUT_ID,PARAMETER)
);

//
// Authentication schemes
//

CREATE CACHED TABLE AUTH_SCHEMES
(
   RESOURCE_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   RESOURCE_NAME VARCHAR(2147483647) not null,
   RESOURCE_DESCRIPTION VARCHAR(2147483647) not null,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP,
   ENABLED TINYINT
);

INSERT INTO AUTH_SCHEMES (RESOURCE_NAME,RESOURCE_DESCRIPTION,DATE_CREATED,DATE_AMENDED,ENABLED) VALUES ('Default','The default authentication scheme.',NOW(),NOW(),1);
INSERT INTO AUTH_SCHEMES (RESOURCE_NAME,RESOURCE_DESCRIPTION,DATE_CREATED,DATE_AMENDED,ENABLED) VALUES ('Password and Personal Details','A two stage authentication scheme that requires the username and password for stage 1 and the answer to a random personal question for the second.',NOW(),NOW(),1);
INSERT INTO AUTH_SCHEMES (RESOURCE_NAME,RESOURCE_DESCRIPTION,DATE_CREATED,DATE_AMENDED,ENABLED) VALUES ('WebDAV','A system scheme that allows WebDAV clients to logon using only a username and password',NOW(),NOW(),1);
INSERT INTO AUTH_SCHEMES (RESOURCE_NAME,RESOURCE_DESCRIPTION,DATE_CREATED,DATE_AMENDED,ENABLED) VALUES ('Embedded Client','A system scheme that allows applications using the Embedded Client API to logon using only a username and password',NOW(),NOW(),1);

CREATE CACHED TABLE AUTH_SEQUENCE
(
   SCHEME_ID INTEGER,
   MODULE_ID VARCHAR(2147483647) not null,
   SEQUENCE INTEGER
);

CREATE UNIQUE INDEX SYS_IDX_AUTH_SEQUENCE_CONSTRAINT_9 ON AUTH_SEQUENCE
(
  SCHEME_ID,
  MODULE_ID,
  SEQUENCE
);


INSERT INTO AUTH_SEQUENCE (SCHEME_ID,MODULE_ID,SEQUENCE) VALUES (1,'Password',0);
INSERT INTO AUTH_SEQUENCE (SCHEME_ID,MODULE_ID,SEQUENCE) VALUES (2,'Password',0);
INSERT INTO AUTH_SEQUENCE (SCHEME_ID,MODULE_ID,SEQUENCE) VALUES (2,'PersonalQuestions',10);
INSERT INTO AUTH_SEQUENCE (SCHEME_ID,MODULE_ID,SEQUENCE) VALUES (3,'WebDAV',0);
INSERT INTO AUTH_SEQUENCE (SCHEME_ID,MODULE_ID,SEQUENCE) VALUES (4,'EmbeddedClient',0);

//
// Favorites
//

CREATE CACHED TABLE FAVORITES
(
   FAVORITE_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   USERNAME VARCHAR(2147483647),
   FAVORITE_KEY INTEGER,
   TYPE INTEGER
);

CREATE UNIQUE INDEX SYS_IDX_FAVORITES_5 ON FAVORITES
(
  USERNAME,
  FAVORITE_KEY,
  TYPE
);


//
// IP Restrictions
//

CREATE CACHED TABLE IP_RESTRICTIONS
(
   RESTRICTION_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   ADDRESS VARCHAR(15) not null,
   TYPE INTEGER not null
);

//
// Network Places
//

CREATE CACHED TABLE NETWORK_PLACES
(
   RESOURCE_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   SHORT_NAME VARCHAR(2147483647),
   DESCRIPTION VARCHAR(2147483647),
   URI VARCHAR(2147483647),
   READ_ONLY BOOLEAN not null,
   ALLOW_RESURSIVE BOOLEAN not null,
   NO_DELETE BOOLEAN not null,
   SHOW_HIDDEN BOOLEAN not null,
   PARENT_RESOURCE_PERMISSION INTEGER,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP
);

//
// Personal Answers
//


CREATE CACHED TABLE PERSONAL_ANSWERS
(
   USERNAME VARCHAR(255) not null,
   ID VARCHAR(255) not null,
   ANSWER VARCHAR(255) not null
);

CREATE UNIQUE INDEX SYS_IDX_PERSONAL_ANSWERS_CONSTRAINT_5 ON PERSONAL_ANSWERS
(
  USERNAME,
  ID
);

//
// Replacements
//

CREATE CACHED TABLE replacements (
  username varchar(255) NOT NULL,
  site_pattern varchar(255) NOT NULL,
  mime_type varchar(255) NOT NULL,
  sequence integer GENERATED BY DEFAULT AS IDENTITY (START WITH 0, INCREMENT BY 32) NOT NULL,
  match_pattern longvarchar NOT NULL,
  replace_pattern varchar(255) NOT NULL,
  replace_type integer DEFAULT 0 NOT NULL
);
		
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','','text/html','(<[\s]*form[\s]*)([^>]*)(>)','#net.openvpn.als.replacementproxy.replacers.FormReplacer');

INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','','text/html','(url\s*\(+?)(?:[''\"]*)([^''\"\)]*)([\"'']*)(\)+?)','$1''%2''$4');
	
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','','text/css','(url\s*\(+?)(?:[''\"]*)([^''\"\)]*)([\"'']*)(\)+?)','$1''%2''$4');

INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','http://localhost.*','application/x-javascript','((?:[;\s]+image|[\s;]+url)\=[''\"]*)([^;''\"]*)','$1%2');	
		
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','text/html','(<(?:div|wm\:message)[^>]*url[\s]*=[\s]*\")([^\"]*)(\")','$1%2$3');
	
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','text/html','((nbLinkNav|Navigate)[\s]*\([\s]*'')([^'']*)('')','$1%3$4');	
	
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','text/html','((t\:src|url|imagePath|draftsURL|baseURL|folderRoot|folder|deletedItems)[\s]*=[\s]*\")([^\"]*)(\")','$1%3$4');
		
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','text/html','(<a[^>]*[\s]*id[\s]*=[\s]*\"https:\/\/)([^\"]*)(\")','$1%2$3');
	
INSERT INTO replacements (username, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('','(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','application/x-javascript','(function[\s]*NavigateTo.*this\.location[\s]*=[\s]*)([^;]*)','$1''/getURL.do?sslex_url='' + escape($2).replace(/\\\\+/g, ''\%2C'').replace(/\\\\"/g,''\%22'').replace(/\\\\''/g, ''\%27'')');
	
INSERT INTO replacements (username, replace_type, site_pattern, mime_type, match_pattern, replace_pattern) 
	VALUES ('', 3, '(http|https)(:/{1,2}+)([^/]*)(/)(exchweb|exchange)','User-Agent','Mozilla\/[^\s]*[\s]*\([^\)]*MSIE[^\)]*\)','Mozilla/4.0 (compatible; Replacement Proxy)');

INSERT INTO replacements (username, site_pattern, mime_type, sequence, match_pattern, replace_pattern) 
	VALUES ('','','text/html',1,'(<[^>]*\s+(?:href|src|background)\=[''\"]*)(?!javascript:)([^\s''>\"]*)','$1%2');

//
// Web Forwards
//

CREATE CACHED TABLE WEBFORWARD
(
   ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   DESTINATION_URL VARCHAR(10) not null,
   TYPE INTEGER not null,
   SHORT_NAME VARCHAR(255) not null,
   DESCRIPTION VARCHAR(255) not null,
   CATEGORY VARCHAR(255) not null,
   PARENT_RESOURCE_PERMISSION INTEGER,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP
);

//
// Reverse proxy
//

CREATE CACHED TABLE REVERSE_PROXY_OPTIONS
(
   WEBFORWARD_ID INTEGER not null,
   AUTHENTICATION_USERNAME VARCHAR(255) not null,
   AUTHENTICATION_PASSWORD VARCHAR(255) not null,
   PREFERRED_AUTHENTICATION_SCHEME VARCHAR(255) not null,
   ACTIVE_DNS TINYINT not null,
   HOST_HEADER VARCHAR(255),
   FORM_TYPE VARCHAR(255) not null,
   FORM_PARAMETERS VARCHAR(255) not null
);

CREATE UNIQUE INDEX SYS_IDX_REVERSE_PROXY_ENCODINGS_CONSTRAINT_7 ON REVERSE_PROXY_OPTIONS(WEBFORWARD_ID);

CREATE CACHED TABLE REVERSE_PROXY_PATHS
(
   PATH VARCHAR(255) not null,
   WEBFORWARD_ID INTEGER not null
);

//
// Secure Proxy
//

CREATE CACHED TABLE SECURE_PROXY_OPTIONS
(
   WEBFORWARD_ID INTEGER not null,
   ENCODING VARCHAR(255) not null,
   RESTRICT_TO_URL TINYINT not null,
   AUTHENTICATION_USERNAME VARCHAR(255) not null,
   AUTHENTICATION_PASSWORD VARCHAR(255) not null,
   PREFERRED_AUTHENTICATION_SCHEME VARCHAR(255) not null,
   FORM_TYPE VARCHAR(255) not null,
   FORM_PARAMETERS VARCHAR(255) not null
);

CREATE UNIQUE INDEX SYS_IDX_SECURE_PROXY_OPTIONS_CONSTRAINT_6 ON SECURE_PROXY_OPTIONS(WEBFORWARD_ID);

//
// SSL Tunnels
//

CREATE CACHED TABLE TUNNELS
(
   TUNNEL_ID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) NOT NULL ,
   NAME VARCHAR(2147483647),
   DESCRIPTION VARCHAR(2147483647),
   TYPE INTEGER not null,
   TRANSPORT VARCHAR(3) not null,
   USERNAME VARCHAR(255) not null,
   SOURCE_PORT INTEGER not null,
   DESTINATION_PORT INTEGER not null,
   DESTINATION_HOST VARCHAR(255) not null,
   AUTO_START BOOLEAN not null,
   ALLOW_EXTERNAL_HOSTS BOOLEAN not null,
   PARENT_RESOURCE_PERMISSION INTEGER not null,
   DATE_CREATED TIMESTAMP,
   DATE_AMENDED TIMESTAMP
);





