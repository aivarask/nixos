SELECT user, host FROM mysql.user;

GRANT ALL ON ak.* to 'ak'@'%.compute-1.amazonaws.com' IDENTIFIED BY 'l';
GRANT ALL ON ak.* to 'ak'@'%.eu-central-1.compute.amazonaws.com' IDENTIFIED BY 'l';
GRANT ALL ON ak.* to 'ak'@'%.compute-1.amazonaws.com' IDENTIFIED BY 'l';
GRANT ALL ON ak.* to 'ak'@'q0nr.l.dedikuoti.lt' IDENTIFIED BY 'l';

FLUSH PRIVILEGES;
SELECT host FROM mysql.user WHERE user = "ak";
