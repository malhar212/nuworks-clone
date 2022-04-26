use malhar;

drop procedure check_user;
DELIMITER $$
CREATE PROCEDURE check_user(IN username VARCHAR(255), IN pass VARCHAR(255))
BEGIN
SELECT first_name, role_id, email FROM malhar.user where email like username and password like pass;
END$$

DELIMITER ;

Call check_user('abca@gmail.com','abcad2123');