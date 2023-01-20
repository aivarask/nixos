SELECT user, host FROM mysql.user;

GRANT ALL ON ak.* to 'ak'@'%.eu-central-1.compute.amazonaws.com' IDENTIFIED BY 'l';
GRANT ALL ON ak.* to 'ak'@'q0nr.l.dedikuoti.lt' IDENTIFIED BY 'l';

GRANT ALL ON `mydb%`.* to 'johndoe'@'localhost' IDENTIFIED BY 'randompassword';

FLUSH PRIVILEGES;
SELECT host FROM mysql.user WHERE user = "*";
