ALTER TABLE SECURE_PROXY_OPTIONS ADD COLUMN RESTRICT_TO_HOSTS VARCHAR;
ALTER TABLE SECURE_PROXY_OPTIONS DROP COLUMN RESTRICT_TO_URL;
