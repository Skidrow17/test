public with sharing class PipelineCheck {
    public static void PipelineCheckMethod() {
        if (Schema.sObjectType.Account.isCreateable()) {
            Account acc = new Account(Name = 'Silvan');
            insert acc;
        } else {
            throw new SecurityException('Insufficient permissions to create Account.');
        }
    }
}
