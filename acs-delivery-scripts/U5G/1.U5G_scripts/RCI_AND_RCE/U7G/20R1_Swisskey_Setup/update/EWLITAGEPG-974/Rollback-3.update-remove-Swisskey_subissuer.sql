/*!40101 set names utf8 */;
/*!50503 set names utf8mb4 */;
use `U0P_ACS_WS`;

set @BankB = 'Swisskey AG';
set @subIssuerSWISSKEY = 'Swisskey AG';
set @SubIssuerCodeSWISSKEY = '41001';

set FOREIGN_KEY_CHECKS = 0;

set @parentId = (select c.id
				 from `Customer` c
				 where c.name = @BankB
				   and c.customerType = 'ISSUER');
set @id_customer = (select id
					from Customer
					where code = @SubIssuerCodeSWISSKEY
					  and customerType = 'SUB_ISSUER'
					  and name = @subIssuerSWISSKEY
					  and parent_id = @parentID);
## Roles are for Swisskey issuer , no need to remove roles and permissions .

delete from Role_Customer where id_customer = (@id_customer);

delete from Customer where id = @id_customer;

set FOREIGN_KEY_CHECKS = 1;
