USE ContactHub;
GO

:r .\Security\Role.sql
:r .\Security\User.sql
:r .\Security\UserRole.sql

:r .\Master\Title.sql
:r .\Master\Language.sql
:r .\Master\Department.sql
:r .\Master\Designation.sql
:r .\Master\Country.sql
:r .\Master\GroupMaster.sql

:r .\Classification\ClassificationType.sql
:r .\Classification\ClassificationSegment.sql
:r .\Classification\ConfidentialityLevel.sql
:r .\Classification\ValidationStatus.sql
:r .\Classification\ContactSource.sql

:r .\Contact\Contact.sql
:r .\Contact\ContactEmail.sql
:r .\Contact\ContactPhone.sql
:r .\Contact\ContactCompany.sql
:r .\Contact\ContactRelationship.sql
:r .\Contact\ContactGroup.sql

:r .\Contact\AuditLog.sql
GO