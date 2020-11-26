/*!40101 set names utf8 */;
/*!50503 set names utf8mb4 */;
use `U0P_ACS_WS`;

set @BankB = 'Swisskey AG';
set @subIssuerLLB = 'Liechtensteinische Landesbank AG';
set @SubIssuerCodeLLB = '88000';
set @RoleLLB = 'Liechtensteinische Landesbank AG Admin';

set FOREIGN_KEY_CHECKS = 0;

set @parentId = (select c.id
				 from `Customer` c
				 where c.name = @BankB
				   and c.customerType = 'ISSUER');
set @id_customer = (select id
					from Customer
					where code = @SubIssuerCodeLLB
					  and customerType = 'SUB_ISSUER'
					  and name = @subIssuerLLB
					  and parent_id = @parentID);


set @roleId = (select id from Role where name = @RoleLLB);

delete from Role_Permission where id_role = @roleId;

delete from Role_Customer where id_customer = (@id_customer);

delete from Role where id = @roleId;

delete from Customer where id = @id_customer;

set FOREIGN_KEY_CHECKS = 1;
